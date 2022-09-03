//
//  FilteredSequenceSpec.swift
//  Gizmo_Tests
//
//  Created by Nayanda Haberty on 03/09/22.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import Foundation
import Quick
import Nimble
import Gizmo

class FilteredSequenceSpec: QuickSpec {
    
    override func spec() {
        it("should filter iteration") {
            let source: [DummyEquatable?] = .dummies(count: Int.random(in: 10..<50))
            let expected = source.filter { $0 != nil }
            var count = 0
            source.filtered { $0 != nil }.enumerated().forEach { index, id in
                expect(id).to(equal(expected[index]))
                count += 1
            }
            expect(count).to(equal(expected.count))
        }
    }
}
