//
//  TimeZoneSpec.swift
//  Gizmo_Tests
//
//  Created by Nayanda Haberty on 13/08/22.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import Foundation
import Quick
import Nimble
import Gizmo

class TimeZoneSpec: QuickSpec {
    
    override func spec() {
        it("should produce timezone without error") {
            let _ = TimeZone.gmt
            TimeZone.Africa.allCases.forEach {
                let _ = TimeZone.africa($0)
            }
            TimeZone.America.allCases.forEach {
                let _ = TimeZone.america($0)
            }
            TimeZone.Argentina.allCases.forEach {
                let _ = TimeZone.america(argentina: $0)
            }
            TimeZone.Indiana.allCases.forEach {
                let _ = TimeZone.america(indiana: $0)
            }
            TimeZone.Kentucky.allCases.forEach {
                let _ = TimeZone.america(kentucky: $0)
            }
            TimeZone.NorthDakota.allCases.forEach {
                let _ = TimeZone.america(northDakota: $0)
            }
            TimeZone.Antarctica.allCases.forEach {
                let _ = TimeZone.antarctica($0)
            }
            TimeZone.Arctic.allCases.forEach {
                let _ = TimeZone.arctic($0)
            }
            TimeZone.Asia.allCases.forEach {
                let _ = TimeZone.asia($0)
            }
            TimeZone.Atlantic.allCases.forEach {
                let _ = TimeZone.atlantic($0)
            }
            TimeZone.Australia.allCases.forEach {
                let _ = TimeZone.australia($0)
            }
            TimeZone.Europe.allCases.forEach {
                let _ = TimeZone.europe($0)
            }
            TimeZone.Europe.allCases.forEach {
                let _ = TimeZone.europe($0)
            }
            TimeZone.Indian.allCases.forEach {
                let _ = TimeZone.indian($0)
            }
            TimeZone.Pacific.allCases.forEach {
                let _ = TimeZone.pacific($0)
            }
        }
    }
}
