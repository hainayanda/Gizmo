//
//  CombinationSequenceSpec.swift
//  Gizmo_Tests
//
//  Created by Nayanda Haberty on 03/09/22.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import Foundation
import Quick
import Nimble
import Gizmo

class CombinationSequenceSpec: QuickSpec {
    
    override func spec() {
        it("should combine sequences") {
            let first: [DummyEquatable] = .dummies(count: Int.random(in: 10..<50))
            let second: [DummyEquatable] = .dummies(count: Int.random(in: 10..<50))
            let expected = first + second
            expect(first.combinedToArray(with: second)).to(equal(expected))
        }
    }
}
