//
//  UIEdgeInsets+Extenison.swift
//  Gizmo
//
//  Created by Nayanda Haberty on 27/.zero7/22.
//

import Foundation
#if canImport(UIKit)
import UIKit

// MARK: Init

public extension UIEdgeInsets {
    init(vertical: CGFloat) {
        self.init(top: vertical, left: .zero, bottom: vertical, right: .zero)
    }
    
    init(horizontal: CGFloat) {
        self.init(top: .zero, left: horizontal, bottom: .zero, right: horizontal)
    }
    
    init(vertical: CGFloat, horizontal: CGFloat) {
        self.init(top: vertical, left: horizontal, bottom: vertical, right: horizontal)
    }
    
    init(insets: CGFloat) {
        self.init(top: insets, left: insets, bottom: insets, right: insets)
    }
}

// MARK: Common

public extension UIEdgeInsets {
    
    func increased(by insets: UIEdgeInsets) -> UIEdgeInsets {
        self + insets
    }
    
    func increased(by insets: CGFloat) -> UIEdgeInsets {
        self + insets
    }
    
    func decreased(by insets: UIEdgeInsets) -> UIEdgeInsets {
        self - insets
    }
    
    func decreased(by insets: CGFloat) -> UIEdgeInsets {
        self - insets
    }
}

// MARK: Operator

public func +(_ lhs: UIEdgeInsets, _ rhs: UIEdgeInsets) -> UIEdgeInsets {
    UIEdgeInsets(
        top: lhs.top + rhs.top,
        left: lhs.left + rhs.left,
        bottom: lhs.bottom + rhs.bottom,
        right: lhs.right + rhs.right
    )
}

public func -(_ lhs: UIEdgeInsets, _ rhs: UIEdgeInsets) -> UIEdgeInsets {
    UIEdgeInsets(
        top: lhs.top - rhs.top,
        left: lhs.left - rhs.left,
        bottom: lhs.bottom - rhs.bottom,
        right: lhs.right - rhs.right
    )
}

public func +(_ lhs: UIEdgeInsets, _ rhs: CGFloat) -> UIEdgeInsets {
    UIEdgeInsets(
        top: lhs.top + rhs,
        left: lhs.left + rhs,
        bottom: lhs.bottom + rhs,
        right: lhs.right + rhs
    )
}

public func -(_ lhs: UIEdgeInsets, _ rhs: CGFloat) -> UIEdgeInsets {
    UIEdgeInsets(
        top: lhs.top - rhs,
        left: lhs.left - rhs,
        bottom: lhs.bottom - rhs,
        right: lhs.right - rhs
    )
}

public func *(_ lhs: UIEdgeInsets, _ rhs: CGFloat) -> UIEdgeInsets {
    UIEdgeInsets(
        top: lhs.top * rhs,
        left: lhs.left * rhs,
        bottom: lhs.bottom * rhs,
        right: lhs.right * rhs
    )
}

public func /(_ lhs: UIEdgeInsets, _ rhs: CGFloat) -> UIEdgeInsets {
    UIEdgeInsets(
        top: lhs.top / rhs,
        left: lhs.left / rhs,
        bottom: lhs.bottom / rhs,
        right: lhs.right / rhs
    )
}
#endif
