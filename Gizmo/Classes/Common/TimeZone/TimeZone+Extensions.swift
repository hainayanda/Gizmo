//
//  TimeZone+Extensions.swift
//  Gizmo
//
//  Created by Nayanda Haberty on 13/08/22.
//

import Foundation

public extension TimeZone {
    @inlinable static var gmt: TimeZone {
        self.init(secondsFromGMT: .zero)!
    }
    
    @inlinable static func africa(_ timeZone: Africa) -> TimeZone {
        TimeZone(identifier: timeZone.rawValue)!
    }
    
    @inlinable static func america(_ timeZone: America) -> TimeZone {
        TimeZone(identifier: timeZone.rawValue)!
    }
    
    @inlinable static func america(argentina timeZone: Argentina) -> TimeZone {
        TimeZone(identifier: timeZone.rawValue)!
    }
    
    @inlinable static func america(indiana timeZone: Indiana) -> TimeZone {
        TimeZone(identifier: timeZone.rawValue)!
    }
    
    @inlinable static func america(kentucky timeZone: Kentucky) -> TimeZone {
        TimeZone(identifier: timeZone.rawValue)!
    }
    
    @inlinable static func america(northDakota timeZone: NorthDakota) -> TimeZone {
        TimeZone(identifier: timeZone.rawValue)!
    }
    
    @inlinable static func antarctica(_ timeZone: Antarctica) -> TimeZone {
        TimeZone(identifier: timeZone.rawValue)!
    }
    
    @inlinable static func arctic(_ timeZone: Arctic) -> TimeZone {
        TimeZone(identifier: timeZone.rawValue)!
    }
    
    @inlinable static func asia(_ timeZone: Asia) -> TimeZone {
        TimeZone(identifier: timeZone.rawValue)!
    }
    
    @inlinable static func atlantic(_ timeZone: Atlantic) -> TimeZone {
        TimeZone(identifier: timeZone.rawValue)!
    }
    
    @inlinable static func australia(_ timeZone: Australia) -> TimeZone {
        TimeZone(identifier: timeZone.rawValue)!
    }
    
    @inlinable static func europe(_ timeZone: Europe) -> TimeZone {
        TimeZone(identifier: timeZone.rawValue)!
    }
    
    @inlinable static func indian(_ timeZone: Indian) -> TimeZone {
        TimeZone(identifier: timeZone.rawValue)!
    }
    
    @inlinable static func pacific(_ timeZone: Pacific) -> TimeZone {
        TimeZone(identifier: timeZone.rawValue)!
    }
}
