//
//  UIEdgeExtensionsSpec.swift
//  Gizmo_Tests
//
//  Created by Nayanda Haberty on 29/07/22.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import Foundation
#if canImport(UIKit)
import UIKit
import Quick
import Nimble
import Gizmo

class UIEdgeExtensionsSpec: QuickSpec {
    
    override func spec() {
        it("should create UIEdgeInsets using verticals and horizontals") {
            expect(UIEdgeInsets(verticals: 10, horizontals: 20)).to(equal(UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)))
            expect(UIEdgeInsets(verticals: 10)).to(equal(UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)))
            expect(UIEdgeInsets(horizontals: 20)).to(equal(UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)))
        }
        it("should create UIEdgeInsets using one insets") {
            expect(UIEdgeInsets(edges: 10)).to(equal(UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)))
        }
        it("should increase insets by insets") {
            let increased = UIEdgeInsets(edges: 10).increased(by: UIEdgeInsets(edges: 5))
            expect(increased).to(equal(UIEdgeInsets(edges: 15)))
        }
        it("should increase insets by insets") {
            let increased = UIEdgeInsets(edges: 10).increased(by: 5)
            expect(increased).to(equal(UIEdgeInsets(edges: 15)))
        }
        it("should increase insets by insets") {
            let decreased = UIEdgeInsets(edges: 10).decreased(by: UIEdgeInsets(edges: 5))
            expect(decreased).to(equal(UIEdgeInsets(edges: 5)))
        }
        it("should increase insets by insets") {
            let decreased = UIEdgeInsets(edges: 10).decreased(by: 5)
            expect(decreased).to(equal(UIEdgeInsets(edges: 5)))
        }
        it("should do arithmatics operation with two insets") {
            let added = UIEdgeInsets(edges: 10) + UIEdgeInsets(edges: 20)
            let substractedAsArray = UIEdgeInsets(edges: 20) - UIEdgeInsets(edges: 10)
            expect(added).to(equal(UIEdgeInsets(edges: 30)))
            expect(substractedAsArray).to(equal(UIEdgeInsets(edges: 10)))
        }
        it("should do arithmatics operation with cgfloat") {
            let added = UIEdgeInsets(edges: 10) + 20
            let substractedAsArray = UIEdgeInsets(edges: 20) - 10
            let multiplied = UIEdgeInsets(edges: 10) * 2
            let divided = UIEdgeInsets(edges: 20) / 10
            expect(added).to(equal(UIEdgeInsets(edges: 30)))
            expect(substractedAsArray).to(equal(UIEdgeInsets(edges: 10)))
            expect(multiplied).to(equal(UIEdgeInsets(edges: 20)))
            expect(divided).to(equal(UIEdgeInsets(edges: 2)))
        }
    }
}
#endif
