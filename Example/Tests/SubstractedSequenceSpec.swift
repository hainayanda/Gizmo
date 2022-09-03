//
//  SubstractedSequenceSpec.swift
//  Gizmo_Tests
//
//  Created by Nayanda Haberty on 03/09/22.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import Foundation
import Quick
import Nimble
import Gizmo

class SubstractedSequenceSpec: QuickSpec {
    
    override func spec() {
        it("should substract based on projection") {
            let left: [Dummy] = .dummies(count: Int.random(in: 20..<50))
            let expected: [Dummy] = Array(left[0..<15])
            let right: [Dummy] = Array(left[15..<left.count]) + [Dummy].dummies(count: Int.random(in: 10 ..< 20))
            let substracted = left.substractedToArray(by: right) { $0.id }
            expect(substracted.compactMap { $0.id }).to(equal(expected.compactMap { $0.id }))
        }
        it("should substract equatables") {
            let left: [DummyEquatable] = .dummies(count: Int.random(in: 20..<50))
            let expected: [DummyEquatable] = Array(left[0..<15])
            let right: [DummyEquatable] = Array(left[15..<left.count]) + [DummyEquatable].dummies(count: Int.random(in: 10 ..< 20))
            let substracted = left.substractedToArray(by: right)
            expect(substracted).to(equal(expected))
        }
        it("should substract hashables") {
            let left: [DummyHashable] = .dummies(count: Int.random(in: 20..<50))
            let expected: [DummyHashable] = Array(left[0..<15])
            let right: [DummyHashable] = Array(left[15..<left.count]) + [DummyHashable].dummies(count: Int.random(in: 10 ..< 20))
            let substracted = left.substractedToArray(by: right)
            expect(substracted).to(equal(expected))
        }
        it("should substract objects") {
            let left: [DummyObject] = .dummies(count: Int.random(in: 20..<50))
            let expected: [DummyObject] = Array(left[0..<15])
            let right: [DummyObject] = Array(left[15..<left.count]) + [DummyObject].dummies(count: Int.random(in: 10 ..< 20))
            let substracted = left.objectsSubstractedToArray(by: right)
            expect(substracted.compactMap { $0.id }).to(equal(expected.compactMap { $0.id }))
        }
    }
}
