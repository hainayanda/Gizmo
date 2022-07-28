//
//  DateExtensionsSpec.swift
//  Gizmo_Tests
//
//  Created by Nayanda Haberty on 27/07/22.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import Foundation
import Quick
import Nimble
import Gizmo

class DateExtensionsSpec: QuickSpec {
    
    override func spec() {
        it("should true if date is right") {
            expect(Date().isToday).to(beTrue())
            expect(24.hours.sinceNow.isTomorrow).to(beTrue())
            expect(24.hours.ago.isYesterday).to(beTrue())
            expect(Int.random(in: 1..<1000).days.ago.isPast).to(beTrue())
            expect(Int.random(in: 1..<1000).days.sinceNow.isFuture).to(beTrue())
            expect(Date().isNow).to(beTrue())
        }
        it("should false if date is not right") {
            let pastWeeks = Int.random(in: 1..<10).weeks.ago
            let nextWeeks = Int.random(in: 1..<10).weeks.sinceNow
            expect(pastWeeks.isToday).to(beFalse())
            expect(nextWeeks.isToday).to(beFalse())
            expect(pastWeeks.isYesterday).to(beFalse())
            expect(nextWeeks.isYesterday).to(beFalse())
            expect(pastWeeks.isTomorrow).to(beFalse())
            expect(nextWeeks.isTomorrow).to(beFalse())
            expect(pastWeeks.isNow).to(beFalse())
            expect(nextWeeks.isNow).to(beFalse())
            expect(pastWeeks.isFuture).to(beFalse())
            expect(nextWeeks.isPast).to(beFalse())
        }
        it("should return timeleft to other date right") {
            let now = Date()
            let timeLeft = TimeInterval.random(in: -1000..<1000)
            let date = Date(timeInterval: timeLeft, since: now)
            expect(now.timeLeft(to: date) - timeLeft).to(beLessThan(1.microSeconds))
        }
        it("should format date to string") {
            let date = 673808400.seconds.since1970
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
