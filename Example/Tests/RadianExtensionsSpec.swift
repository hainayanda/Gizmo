//
//  RadianExtensionsSpec.swift
//  Gizmo_Tests
//
//  Created by Nayanda Haberty on 28/07/22.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import Foundation
import Quick
import Nimble
import Gizmo

class RadianExtensionsSpec: QuickSpec {
    
    override func spec() {
        it("should convert int angle to radian") {
            let degree90 = 90.angleDegree
            let degree60 = 60.angleDegree
            let degree45 = 45.angleDegree
            let degree30 = 30.angleDegree
            
            expect(abs(degree90 - Radian.pi/2)).to(beLessThan(0.000001))
            expect(abs(degree60 - Radian.pi/3)).to(beLessThan(0.000001))
            expect(abs(degree45 - Radian.pi/4)).to(beLessThan(0.000001))
            expect(abs(degree30 - Radian.pi/6)).to(beLessThan(0.000001))
        }
        it("should convert double angle to radian") {
            let degree90 = 90.0.angleDegree
            let degree60 = 60.0.angleDegree
            let degree45 = 45.0.angleDegree
            let degree30 = 30.0.angleDegree
            
            expect(abs(degree90 - Radian.pi/2)).to(beLessThan(0.000001))
            expect(abs(degree60 - Radian.pi/3)).to(beLessThan(0.000001))
            expect(abs(degree45 - Radian.pi/4)).to(beLessThan(0.000001))
            expect(abs(degree30 - Radian.pi/6)).to(beLessThan(0.000001))
        }
    }
}
