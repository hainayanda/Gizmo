//
//  StringExtensionsSpec.swift
//  Gizmo_Tests
//
//  Created by Nayanda Haberty on 28/07/22.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import Foundation
import Quick
import Nimble
import Gizmo
import Fakery

class StringExtensionsSpec: QuickSpec {
    
    // swiftlint:disable function_body_length
    override func spec() {
        let faker = Faker()
        it("should convert string to base64") {
            expect("Hello World!".asBase64).to(equal("SGVsbG8gV29ybGQh"))
        }
        it("should compare using regex") {
            expect("my 1st string" ~= "^\\w{2}\\s\\d\\w+\\s\\S+$").to(beTrue())
            expect("my 1st string" ~= "^\\w+$").to(beFalse())
        }
        it("should return false if regex di not valid") {
            expect("my 1st string" ~= "${this is not regex}").to(beFalse())
        }
        it("should convert to md5") {
            expect("Hello World!".md5).to(equal("ed076287532e86365e841e92bfc50d8c"))
        }
        it("should check if contains digit") {
            expect(faker.phoneNumber.cellPhone().isContainsDigit).to(beTrue())
            expect(faker.lorem.paragraph().isContainsDigit).to(beFalse())
        }
        it("should check if contains letters") {
            expect(faker.lorem.paragraph().isContainsLetters).to(beTrue())
            expect(faker.phoneNumber.cellPhone().isContainsLetters).to(beFalse())
        }
        it("should check if contains digit only") {
            expect("1239877654".isDigitOnly).to(beTrue())
            expect(faker.lorem.paragraph().isDigitOnly).to(beFalse())
        }
        it("should check if contains letters only") {
            expect(faker.lorem.word().isLettersOnly).to(beTrue())
            expect("abc1239gfh877654xyz".isLettersOnly).to(beFalse())
        }
        it("should check if contains letters only") {
            expect("abc1239gfh877654xyz".isAlphanumeric).to(beTrue())
            expect(faker.lorem.paragraph().isAlphanumeric).to(beFalse())
        }
        it("should check if valid email") {
            expect(faker.internet.email().isValidEmail).to(beTrue())
            expect(faker.internet.username().isValidEmail).to(beFalse())
        }
        it("should check if valid email using regex") {
            expect(faker.internet.email() ~= String.emailRegEx).to(beTrue())
            expect(faker.internet.username() ~= String.emailRegEx).to(beFalse())
        }
        it("should check if valid url using regex") {
            expect(faker.internet.url() ~= String.urlRegEx).to(beTrue())
            expect(faker.internet.username() ~= String.urlRegEx).to(beFalse())
        }
        it("should check if valid url using regex") {
            expect(faker.internet.ipV4Address() ~= String.ipV4RegEx).to(beTrue())
            expect(faker.internet.username() ~= String.ipV4RegEx).to(beFalse())
        }
        it("should check if valid url using regex") {
            expect(faker.internet.ipV6Address() ~= String.ipV6RegEx).to(beTrue())
            expect(faker.internet.username() ~= String.ipV4RegEx).to(beFalse())
        }
        context("JSON") {
            let userName = faker.internet.username()
            let email = faker.internet.email()
            let name = faker.name.name()
            let age = faker.number.randomInt()
            let dictionary: [String: Any] = [
                "userName": userName,
                "email": email,
                "name": name,
                "age": age
            ]
            let jsonString = "{\"userName\":\"\(userName)\",\"email\":\"\(email)\",\"name\":\"\(name)\",\"age\":\(age)}"
            let jsonArrayString = "[{\"userName\":\"\(userName)\",\"email\":\"\(email)\",\"name\":\"\(name)\",\"age\":\(age)}]"
            it("should create string from json object") {
                expect { try String.init(jsonObject: dictionary) }.toNot(throwError())
                expect { try String.init(jsonObject: [dictionary, dictionary]) }.toNot(throwError())
                expect { try String.init(jsonObject: faker.number.randomBool()) }.toNot(throwError())
            }
            it("should generate dictionary") {
                do {
                    let dict = try jsonString.jsonToDictionary()
                    expect(dict.count).to(equal(dictionary.count))
                    expect(dict["userName"] as? String).to(equal(dictionary["userName"] as? String))
                    expect(dict["email"] as? String).to(equal(dictionary["email"] as? String))
                    expect(dict["name"] as? String).to(equal(dictionary["name"] as? String))
                    expect(dict["age"] as? Int).to(equal(dictionary["age"] as? Int))
                } catch {
                    fail()
                }
            }
            it("should generate array") {
                do {
                    let array = try jsonArrayString.jsonToArray()
                    expect(array.count).to(equal(1))
                    // swiftlint:disable:next force_cast
                    let dict = array[0] as! [String: Any]
                    expect(dict.count).to(equal(dictionary.count))
                    expect(dict["userName"] as? String).to(equal(dictionary["userName"] as? String))
                    expect(dict["email"] as? String).to(equal(dictionary["email"] as? String))
                    expect(dict["name"] as? String).to(equal(dictionary["name"] as? String))
                    expect(dict["age"] as? Int).to(equal(dictionary["age"] as? Int))
                } catch {
                    fail()
                }
            }
        }
    }
    // swiftlint:enable function_body_length
}
