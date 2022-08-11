//
//  UniqueSequenceSpec.swift
//  Gizmo_Tests
//
//  Created by Nayanda Haberty on 02/08/22.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import Foundation
import Quick
import Nimble
import Gizmo

class UniqueSequenceSpec: QuickSpec {
    
    override func spec() {
        context("hashable") {
            let source = [
                MyHashable(number: 0), MyHashable(number: 1), MyHashable(number: 2),
                MyHashable(number: 3), MyHashable(number: 3), MyHashable(number: 2),
                MyHashable(number: 1), MyHashable(number: 4), MyHashable(number: 5),
                MyHashable(number: 5)
            ]
            let expectations = [
                MyHashable(number: 0), MyHashable(number: 1), MyHashable(number: 2),
                MyHashable(number: 3), MyHashable(number: 4), MyHashable(number: 5)
            ]
            it("should iterate uniquely for hashable") {
                var expectation = MyHashable(number: 0)
                source.uniqueSequence().forEach { number in
                    expect(number).to(equal(expectation))
                    expectation = MyHashable(number: expectation.number + 1)
                }
            }
            it("should right count for hashable") {
                let sequence = source.uniqueSequence()
                expect(sequence.count).to(equal(6))
                expect(sequence.count).to(equal(6))
            }
            it("should same as expectation for hashable") {
                let sequence = source.uniqueSequence()
                for (index, element) in expectations.enumerated() {
                    expect(sequence[index]).to(equal(element))
                    expect(sequence[index]).to(equal(element))
                }
            }
            it("should same as expectation index for hashable") {
                let sequence = source.uniqueSequence()
                for (index, element) in expectations.enumerated() {
                    expect(sequence.indexOf(element: element)).to(equal(index))
                    expect(sequence.indexOf(element: element)).to(equal(index))
                }
            }
            it("should return nil if element index not found") {
                let sequence = source.uniqueSequence()
                expect(sequence.indexOf(element: MyHashable(number: 6))).to(beNil())
                expect(sequence.indexOf(element: MyHashable(number: 6))).to(beNil())
            }
            it("should return nil if element at index not found") {
                let sequence = source.uniqueSequence()
                expect(sequence[safe: 6]).to(beNil())
                expect(sequence[safe: 6]).to(beNil())
            }
        }
        context("equatable") {
            let source = [
                MyEquatable(number: 0), MyEquatable(number: 1), MyEquatable(number: 2),
                MyEquatable(number: 3), MyEquatable(number: 3), MyEquatable(number: 2),
                MyEquatable(number: 1), MyEquatable(number: 4), MyEquatable(number: 5),
                MyEquatable(number: 5)
            ]
            let expectations = [
                MyEquatable(number: 0), MyEquatable(number: 1), MyEquatable(number: 2),
                MyEquatable(number: 3), MyEquatable(number: 4), MyEquatable(number: 5)
            ]
            it("should iterate uniquely for equatable") {
                var expectation = MyEquatable(number: 0)
                source.uniqueSequence().forEach { number in
                    expect(number).to(equal(expectation))
                    expectation = MyEquatable(number: expectation.number + 1)
                }
            }
            it("should right count for equatable") {
                let sequence = source.uniqueSequence()
                expect(sequence.count).to(equal(6))
                expect(sequence.count).to(equal(6))
            }
            it("should same as expectation for equatable") {
                let sequence = source.uniqueSequence()
                for (index, element) in expectations.enumerated() {
                    expect(sequence[index]).to(equal(element))
                    expect(sequence[index]).to(equal(element))
                }
            }
            it("should same as expectation index for equatable") {
                let sequence = source.uniqueSequence()
                for (index, element) in expectations.enumerated() {
                    expect(sequence.indexOf(element: element)).to(equal(index))
                    expect(sequence.indexOf(element: element)).to(equal(index))
                }
            }
            it("should return nil if element index not found") {
                let sequence = source.uniqueSequence()
                expect(sequence.indexOf(element: MyEquatable(number: 6))).to(beNil())
                expect(sequence.indexOf(element: MyEquatable(number: 6))).to(beNil())
            }
            it("should return nil if element at index not found") {
                let sequence = source.uniqueSequence()
                expect(sequence[safe: 6]).to(beNil())
                expect(sequence[safe: 6]).to(beNil())
            }
        }
    }
}

fileprivate struct MyEquatable: Equatable {
    let number: Int
}

fileprivate struct MyHashable: Hashable {
    let number: Int
}
