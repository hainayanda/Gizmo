//
//  DictionaryExtensionsSpec.swift
//  Gizmo_Tests
//
//  Created by Nayanda Haberty on 28/07/22.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import Foundation
import Quick
import Nimble
import Gizmo

class DictionaryExtensionsSpec: QuickSpec {
    
    override func spec() {
        let dictionary = [1: "one", 2: "two", 3: "three", 4: "four", 5: "five"]
        it("should map dictionary keys") {
            let newDictionary = dictionary.mapKeys { "\($0)" }
            expect(newDictionary).to(equal(["1": "one", "2": "two", "3": "three", "4": "four", "5": "five"]))
        }
        it("should compact map dictionary keys") {
            let newDictionary = dictionary.compactMapKeys { $0 < 5 ? "\($0)": nil }
            expect(newDictionary).to(equal(["1": "one", "2": "two", "3": "three", "4": "four"]))
        }
        it("should map dictionary keys and value") {
            let newDictionary = dictionary.mapKeyValues { ($1, $0) }
            expect(newDictionary).to(equal(["one": 1, "two": 2, "three": 3, "four": 4, "five": 5]))
        }
        it("should compact map dictionary keys and value") {
            let newDictionary = dictionary.compactMapKeyValues { $0 < 5 ? ($1, $0): nil }
            expect(newDictionary).to(equal(["one": 1, "two": 2, "three": 3, "four": 4]))
        }
    }
}
