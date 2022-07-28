//
//  DateExtensionSpec.swift
//  Gizmo_Tests
//
//  Created by Nayanda Haberty on 27/07/22.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import Foundation
import Quick
import Nimble
import Gizmo

class DateExtensionSpec: QuickSpec {
    
    override func spec() {
        it("should true if date is right") {
            expect(Date().isToday).to(beTrue())
            expect(Date(timeIntervalSinceNow: 24.hours).isTomorrow).to(beTrue())
            expect(Date(timeIntervalSinceNow: -24.hours).isYesterday).to(beTrue())
            expect(Date.distantPast.isPast).to(beTrue())
            expect(Date.distantFuture.isFuture).to(beTrue())
            expect(Date().isNow).to(beTrue())
        }
        it("should false if date is not right") {
            expect(Date.distantPast.isToday).to(beFalse())
            expect(Date.distantFuture.isToday).to(beFalse())
            expect(Date.distantPast.isYesterday).to(beFalse())
            expect(Date.distantFuture.isYesterday).to(beFalse())
            expect(Date.distantPast.isTomorrow).to(beFalse())
            expect(Date.distantFuture.isTomorrow).to(beFalse())
            expect(Date.distantPast.isNow).to(beFalse())
            expect(Date.distantFuture.isNow).to(beFalse())
            expect(Date.distantPast.isFuture).to(beFalse())
            expect(Date.distantFuture.isPast).to(beFalse())
        }
        it("should return timeleft to other date right") {
            let now = Date()
            let timeLeft = TimeInterval.random(in: -1000..<1000)
            let date = Date(timeInterval: timeLeft, since: now)
            expect(now.timeLeft(to: date) - timeLeft).to(beLessThan(1.microSeconds))
        }
        it("should format date to string") {
            let date = Date(timeIntervalSince1970: 673808400)
            expect(date.dateString("dd MMM yyyy")).to(equal("10 May 1991"))
        }
        it("should create date from string") {
            guard let date = Date("10 May 1991", format: "dd MMM yyyy") else {
                fail("fail to create date")
                return
            }
            expect(date.timeIntervalSince1970).to(equal(673808400))
        }
    }
}
