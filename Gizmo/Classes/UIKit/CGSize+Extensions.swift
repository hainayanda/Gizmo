//
//  CGSize+Extensions.swift
//  Gizmo
//
//  Created by Nayanda Haberty on 27/07/22.
//

import Foundation
#if canImport(UIKit)
import UIKit

// MARK: Common

public extension CGSize {
    var area: CGFloat { width * height }
    
    var maxCornerRadius: CGFloat { min(width, height) / 2 }
    
    func reduced(by inset: UIEdgeInsets) -> CGSize {
        return .init(
            width: width - inset.left - inset.right,
            height: height - inset.top - inset.bottom
        )
    }
    
    func enlarged(by inset: UIEdgeInsets) -> CGSize {
        return .init(
            width: width + inset.left + inset.right,
            height: height + inset.top + inset.bottom
        )
    }
}

// MARK: Init

public extension CGSize {
    init(sides: CGFloat) {
        self.init(width: sides, height: sides)
    }
}

// MARK: Operator

public func +(_ lhs: CGSize, _ rhs: CGSize) -> CGSize {
    CGSize(
        width: lhs.width + rhs.width,
        height: lhs.height + rhs.height
    )
}

public func -(_ lhs: CGSize, _ rhs: CGSize) -> CGSize {
    CGSize(
        width: lhs.width - rhs.width,
        height: lhs.height - rhs.height
    )
}

public func +(_ lhs: CGSize, _ rhs: CGFloat) -> CGSize {
    CGSize(
        width: lhs.width + rhs,
        height: lhs.height + rhs
    )
}

public func -(_ lhs: CGSize, _ rhs: CGFloat) -> CGSize {
    CGSize(
        width: lhs.width - rhs,
        height: lhs.height - rhs
    )
}

public func *(_ lhs: CGSize, _ rhs: CGFloat) -> CGSize {
    CGSize(
        width: lhs.width * rhs,
        height: lhs.height * rhs
    )
}

public func /(_ lhs: CGSize, _ rhs: CGFloat) -> CGSize {
    CGSize(
        width: lhs.width / rhs,
        height: lhs.height / rhs
    )
}
#endif
