//
//  CGRectExtensionsSpec.swift
//  Gizmo_Tests
//
//  Created by Nayanda Haberty on 28/07/22.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import Foundation
#if canImport(UIKit)
import UIKit
import Quick
import Nimble
import Gizmo

class CGRectExtensionsSpec: QuickSpec {
    
    override func spec() {
        it("should calculate center") {
            let rect = CGRect(origin: .zero, size: CGSize(sides: 4))
            expect(rect.center).to(equal(CGPoint(x: 2, y: 2)))
        }
        it("should calculate centered frame") {
            let rect = CGRect(origin: .zero, size: CGSize(sides: 4))
            let targetSize = CGSize(sides: 2)
            expect(rect.centeredFrame(withSize: targetSize)).to(equal(CGRect(origin: CGPoint(x: 1, y: 1), size: targetSize)))
        }
        it("should calculate outer insets") {
            let rect = CGRect(origin: .zero, size: CGSize(sides: 4))
            let targetSize = CGSize(sides: 2)
            let innerRect = CGRect(origin: CGPoint(x: 1, y: 1), size: targetSize)
            expect(innerRect.insets(to: rect)).to(equal(UIEdgeInsets(insets: 1)))
        }
        it("should calculate inner insets") {
            let rect = CGRect(origin: .zero, size: CGSize(sides: 4))
            let targetSize = CGSize(sides: 2)
            let innerRect = CGRect(origin: CGPoint(x: 1, y: 1), size: targetSize)
            expect(rect.insets(of: innerRect)).to(equal(UIEdgeInsets(insets: 1)))
        }
        it("should calculate inner frame") {
            let rect = CGRect(origin: .zero, size: CGSize(sides: 4))
            let targetInsets = UIEdgeInsets(insets: 1)
            let targetSize = CGSize(sides: 2)
            expect(rect.innerFrame(insetedBy: targetInsets)).to(equal(CGRect(origin: CGPoint(x: 1, y: 1), size: targetSize)))
        }
        it("should calculate outer frame") {
            let rect = CGRect(origin: CGPoint(x: 1, y: 1), size: CGSize(sides: 2))
            let targetOffsets = UIEdgeInsets(insets: 1)
            expect(rect.enlarged(by: targetOffsets)).to(equal(CGRect(origin: .zero, size: CGSize(sides: 4))))
        }
    }
}
#endif
