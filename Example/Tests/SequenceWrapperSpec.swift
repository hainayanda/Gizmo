//
//  SequenceWrapperSpec.swift
//  Gizmo_Tests
//
//  Created by Nayanda Haberty on 03/09/22.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import Foundation
import Quick
import Nimble
import Gizmo

class SequenceWrapperSpec: QuickSpec {
    
    override func spec() {
        it("should run early process") {
            let first: [DummyEquatable] = .dummies(count: Int.random(in: 10..<50))
            let second: [DummyEquatable] = .dummies(count: Int.random(in: 10..<50))
            let expected = first + second
            let combined = first.combined(with: second)
            combined.earlyProcess()
            var count = 0
            combined.enumerated().forEach { index, id in
                expect(id).to(equal(expected[index]))
                count += 1
            }
            expect(count).to(equal(expected.count))
            expect(combined.earlyProcess()).to(equal(expected))
        }
    }
}
