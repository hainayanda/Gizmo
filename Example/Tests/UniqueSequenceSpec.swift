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
            it("should iterate uniquely for hashable") {
                var expectation = MyHashable(number: 0)
                source.uniqued.forEach { number in
                    expect(number).to(equal(expectation))
                    expectation = MyHashable(number: expectation.number + 1)
                }
            }
        }
        context("equatable") {
            let source = [
                MyEquatable(number: 0), MyEquatable(number: 1), MyEquatable(number: 2),
                MyEquatable(number: 3), MyEquatable(number: 3), MyEquatable(number: 2),
                MyEquatable(number: 1), MyEquatable(number: 4), MyEquatable(number: 5),
                MyEquatable(number: 5)
            ]
            it("should iterate uniquely for equatable") {
                var expectation = MyEquatable(number: 0)
                source.uniqued.forEach { number in
                    expect(number).to(equal(expectation))
                    expectation = MyEquatable(number: expectation.number + 1)
                }
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
