//
//  CGRect+Extensions.swift
//  Gizmo
//
//  Created by Nayanda Haberty on 27/07/22.
//

import Foundation
#if canImport(UIKit)
import UIKit

public extension CGRect {
    
    var center: CGPoint {
        let centerX = minX + ((maxX - minX) / 2)
        let centerY = minY + ((maxY - minY) / 2)
        return CGPoint(x: centerX, y: centerY)
    }
    
    func centeredFrame(withSize size: CGSize) -> CGRect {
        let halfSize = size / 2
        let origin = CGPoint(x: center.x - halfSize.width, y: center.y - halfSize.height)
        return CGRect(origin: origin, size: size)
    }
    
    func insets(to outerFrame: CGRect) -> UIEdgeInsets {
        outerFrame.insets(of: self)
    }
    
    func insets(of innerFrame: CGRect) -> UIEdgeInsets {
        let topInset = innerFrame.origin.y
        let leftInset = innerFrame.origin.x
        let maxX = topInset + innerFrame.size.height
        let bottomInset = size.height - maxX
        let maxY = leftInset + innerFrame.size.width
        let rightInset = size.width - maxY
        return UIEdgeInsets(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
    }
    
    func innerFrame(insetedBy insets: UIEdgeInsets) -> CGRect {
        let origin = CGPoint(x: insets.left, y: insets.top)
        let size = self.size.reduced(by: insets)
        return CGRect(origin: origin, size: size)
    }
    
    func enlarged(by offsets: UIEdgeInsets) -> CGRect {
        let origin = CGPoint(x: origin.x - offsets.left, y: origin.y - offsets.top)
        let size = self.size.enlarged(by: offsets)
        return CGRect(origin: origin, size: size)
    }
}
#endif
