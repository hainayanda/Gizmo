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
            _ = TimeZone.gmt
            TimeZone.Africa.allCases.forEach {
                _ = TimeZone.africa($0)
            }
            TimeZone.America.allCases.forEach {
                _ = TimeZone.america($0)
            }
            TimeZone.Argentina.allCases.forEach {
                _ = TimeZone.america(argentina: $0)
            }
            TimeZone.Indiana.allCases.forEach {
                _ = TimeZone.america(indiana: $0)
            }
            TimeZone.Kentucky.allCases.forEach {
                _ = TimeZone.america(kentucky: $0)
            }
            TimeZone.NorthDakota.allCases.forEach {
                _ = TimeZone.america(northDakota: $0)
            }
            TimeZone.Antarctica.allCases.forEach {
                _ = TimeZone.antarctica($0)
            }
            TimeZone.Arctic.allCases.forEach {
                _ = TimeZone.arctic($0)
            }
            TimeZone.Asia.allCases.forEach {
                _ = TimeZone.asia($0)
            }
            TimeZone.Atlantic.allCases.forEach {
                _ = TimeZone.atlantic($0)
            }
            TimeZone.Australia.allCases.forEach {
                _ = TimeZone.australia($0)
            }
            TimeZone.Europe.allCases.forEach {
                _ = TimeZone.europe($0)
            }
            TimeZone.Europe.allCases.forEach {
                _ = TimeZone.europe($0)
            }
            TimeZone.Indian.allCases.forEach {
                _ = TimeZone.indian($0)
            }
            TimeZone.Pacific.allCases.forEach {
                _ = TimeZone.pacific($0)
            }
        }
    }
}
