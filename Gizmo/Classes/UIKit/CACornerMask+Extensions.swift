//
//  CACornerMask+Extensions.swift
//  Gizmo
//
//  Created by Nayanda Haberty on 27/07/22.
//

import Foundation
#if canImport(UIKit)
import UIKit

public extension CACornerMask {
    
    static var topLeft: CACornerMask { layerMinXMinYCorner }

    static var topRight: CACornerMask { layerMaxXMinYCorner }

    static var bottomLeft: CACornerMask { layerMinXMaxYCorner }

    static var bottomRight: CACornerMask { layerMaxXMaxYCorner }
    
    static var allTop: CACornerMask {
        [topLeft, topRight]
    }

    static var allLeft: CACornerMask {
        [topLeft, bottomLeft]
    }

    static var allRight: CACornerMask {
        [topRight, bottomRight]
    }

    static var allBottom: CACornerMask {
        [bottomLeft, bottomRight]
    }
    
    static var allButTopLeft: CACornerMask {
        [topRight, bottomLeft, bottomRight]
    }

    static var allButTopRight: CACornerMask {
        [topLeft, bottomLeft, bottomRight]
    }

    static var allButBottomLeft: CACornerMask {
        [topLeft, topRight, bottomRight]
    }

    static var allButBottomRight: CACornerMask {
        [topLeft, topRight, bottomLeft]
    }
    
    static var all: CACornerMask {
        [topLeft, topRight, bottomLeft, bottomRight]
    }

}
#endif
