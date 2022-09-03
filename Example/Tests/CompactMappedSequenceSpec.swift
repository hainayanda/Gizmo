//
//  CompactMappedSequenceSpec.swift
//  Gizmo_Tests
//
//  Created by Nayanda Haberty on 03/09/22.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import Foundation
import Quick
import Nimble
import Gizmo

class CompactMappedSequenceSpec: QuickSpec {
    
    override func spec() {
        it("should compactMapped iteration") {
            let source: [DummyEquatable?] = .dummies(count: Int.random(in: 10..<50))
            let expected = source.compactMap { $0 }
            expect(source.compactArray).to(equal(expected))
        }
        it("should mapped iteration") {
            let source: [DummyEquatable] = .dummies(count: Int.random(in: 10..<50))
            let expected = source.map { $0.id }
            var count = 0
            source.mapped { $0.id }.enumerated().forEach { index, id in
                expect(id).to(equal(expected[index]))
                count += 1
            }
            expect(count).to(equal(expected.count))
        }
    }
}
