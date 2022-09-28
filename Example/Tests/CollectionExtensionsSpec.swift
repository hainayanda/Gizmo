//
//  CollectionExtensionsSpec.swift
//  Gizmo_Tests
//
//  Created by Nayanda Haberty on 26/07/22.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import Foundation
import Quick
import Nimble
import Gizmo

class CollectionExtensionsSpec: QuickSpec {
    
    override func spec() {
        it("should still return value if index in bounds") {
            let array = [1, 2, 3, 4, 5]
            for index in 0 ..< 5 {
                expect(array[safe: index]).to(equal(index + 1))
            }
        }
        it("should return nil if index out of bounds") {
            let array = [1, 2, 3, 4, 5]
            expect(array[safe: 5]).to(beNil())
            expect(array[safe: -1]).to(beNil())
        }
        it("should return not empty") {
            expect([1, 2, 3].isNotEmpty).to(beTrue())
        }
        it("should return empty") {
            expect([].isNotEmpty).to(beFalse())
        }
    }
}
