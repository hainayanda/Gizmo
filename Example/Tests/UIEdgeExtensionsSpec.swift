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
            expect(UIEdgeInsets(insets: 10)).to(equal(UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)))
        }
        it("should increase insets by insets") {
            let increased = UIEdgeInsets(insets: 10).increased(by: UIEdgeInsets(insets: 5))
            expect(increased).to(equal(UIEdgeInsets(insets: 15)))
        }
        it("should increase insets by insets") {
            let increased = UIEdgeInsets(insets: 10).increased(by: 5)
            expect(increased).to(equal(UIEdgeInsets(insets: 15)))
        }
        it("should increase insets by insets") {
            let decreased = UIEdgeInsets(insets: 10).decreased(by: UIEdgeInsets(insets: 5))
            expect(decreased).to(equal(UIEdgeInsets(insets: 5)))
        }
        it("should increase insets by insets") {
            let decreased = UIEdgeInsets(insets: 10).decreased(by: 5)
            expect(decreased).to(equal(UIEdgeInsets(insets: 5)))
        }
        it("should do arithmatics operation with two insets") {
            let added = UIEdgeInsets(insets: 10) + UIEdgeInsets(insets: 20)
            let substracted = UIEdgeInsets(insets: 20) - UIEdgeInsets(insets: 10)
            expect(added).to(equal(UIEdgeInsets(insets: 30)))
            expect(substracted).to(equal(UIEdgeInsets(insets: 10)))
        }
        it("should do arithmatics operation with cgfloat") {
            let added = UIEdgeInsets(insets: 10) + 20
            let substracted = UIEdgeInsets(insets: 20) - 10
            let multiplied = UIEdgeInsets(insets: 10) * 2
            let divided = UIEdgeInsets(insets: 20) / 10
            expect(added).to(equal(UIEdgeInsets(insets: 30)))
            expect(substracted).to(equal(UIEdgeInsets(insets: 10)))
            expect(multiplied).to(equal(UIEdgeInsets(insets: 20)))
            expect(divided).to(equal(UIEdgeInsets(insets: 2)))
        }
    }
}
#endif
