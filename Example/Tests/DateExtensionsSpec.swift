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
            expect(Date().isToday()).to(beTrue())
            expect(24.hours.sinceNow.isTomorrow()).to(beTrue())
            expect(24.hours.ago.isYesterday()).to(beTrue())
            expect(Int.random(in: 1..<1000).days.ago.isPast).to(beTrue())
            expect(Int.random(in: 1..<1000).days.sinceNow.isFuture).to(beTrue())
            expect(Date().isNow).to(beTrue())
        }
        it("should false if date is not right") {
            let pastWeeks = Int.random(in: 1..<10).weeks.ago
            let nextWeeks = Int.random(in: 1..<10).weeks.sinceNow
            expect(pastWeeks.isToday()).to(beFalse())
            expect(nextWeeks.isToday()).to(beFalse())
            expect(pastWeeks.isYesterday()).to(beFalse())
            expect(nextWeeks.isYesterday()).to(beFalse())
            expect(pastWeeks.isTomorrow()).to(beFalse())
            expect(nextWeeks.isTomorrow()).to(beFalse())
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
            let date = 673833600.seconds.since1970
            expect(date.dateString("dd MMM yyyy", timeZone: .gmt)).to(equal("10 May 1991"))
        }
        it("should create date from string") {
            guard let date = Date("10 May 1991", format: "dd MMM yyyy") else {
                fail("fail to create date")
                return
            }
            expect(date.timeIntervalSince1970).to(equal(673808400))
        }
        it("should return right second") {
            let unixSeconds = 673833600
            
            for addedSeconds in 0 ..< 60 {
                expect((unixSeconds + addedSeconds).seconds.since1970.clockSecond(timeZone: .gmt)).to(equal(addedSeconds))
            }
        }
        it("should return right minutes") {
            let unixSeconds = 673833600
            
            for addedMinutes in 0 ..< 60 {
                expect((unixSeconds.seconds + addedMinutes.minutes).since1970.clockMinute(timeZone: .gmt)).to(equal(addedMinutes))
            }
        }
        it("should return right hours") {
            let unixSeconds = 673833600
            
            for addedHours in 0 ..< 24 {
                expect((unixSeconds.seconds + addedHours.hours).since1970.clockHour(timeZone: .gmt)).to(equal(addedHours))
            }
        }
        it("should return right 12 format hours") {
            let unixSeconds = 673833600
            
            for addedHours in 0 ..< 12 {
                expect((unixSeconds.seconds + addedHours.hours).since1970.clockHour12(timeZone: .gmt)).to(equal(.am(addedHours)))
            }
            expect((unixSeconds.seconds + 12.hours).since1970.clockHour12(timeZone: .gmt)).to(equal(.pm(12)))
            for addedHours in 13 ..< 24 {
                expect((unixSeconds.seconds + addedHours.hours).since1970.clockHour12(timeZone: .gmt)).to(equal(.pm(addedHours - 12)))
            }
        }
        it("should return right date") {
            let unixSeconds = 673056000
            
            for addedDate in 0 ..< 30 {
                let expectedDate = addedDate + 1
                expect((unixSeconds.seconds + addedDate.days).since1970.calendarDate(timeZone: .gmt)).to(equal(expectedDate))
            }
        }
        it("should return right day") {
            let unixSeconds = 674006400
            expect(unixSeconds.seconds.since1970.calendarDay(timeZone: .gmt)).to(equal(.sunday))
            expect((unixSeconds.seconds + 1.days).since1970.calendarDay(timeZone: .gmt)).to(equal(.monday))
            expect((unixSeconds.seconds + 2.days).since1970.calendarDay(timeZone: .gmt)).to(equal(.tuesday))
            expect((unixSeconds.seconds + 3.days).since1970.calendarDay(timeZone: .gmt)).to(equal(.wednesday))
            expect((unixSeconds.seconds + 4.days).since1970.calendarDay(timeZone: .gmt)).to(equal(.thursday))
            expect((unixSeconds.seconds + 5.days).since1970.calendarDay(timeZone: .gmt)).to(equal(.friday))
            expect((unixSeconds.seconds + 6.days).since1970.calendarDay(timeZone: .gmt)).to(equal(.saturday))
        }
        it("should return right month") {
            let unixSeconds = 662688000
            expect(unixSeconds.seconds.since1970.calendarMonth(timeZone: .gmt)).to(equal(.january))
            expect((unixSeconds.seconds + 31.days).since1970.calendarMonth(timeZone: .gmt)).to(equal(.february))
            expect((unixSeconds.seconds + 59.days).since1970.calendarMonth(timeZone: .gmt)).to(equal(.march))
            expect((unixSeconds.seconds + 90.days).since1970.calendarMonth(timeZone: .gmt)).to(equal(.april))
            expect((unixSeconds.seconds + 120.days).since1970.calendarMonth(timeZone: .gmt)).to(equal(.may))
            expect((unixSeconds.seconds + 151.days).since1970.calendarMonth(timeZone: .gmt)).to(equal(.june))
            expect((unixSeconds.seconds + 181.days).since1970.calendarMonth(timeZone: .gmt)).to(equal(.july))
            expect((unixSeconds.seconds + 212.days).since1970.calendarMonth(timeZone: .gmt)).to(equal(.august))
            expect((unixSeconds.seconds + 243.days).since1970.calendarMonth(timeZone: .gmt)).to(equal(.september))
            expect((unixSeconds.seconds + 273.days).since1970.calendarMonth(timeZone: .gmt)).to(equal(.october))
            expect((unixSeconds.seconds + 304.days).since1970.calendarMonth(timeZone: .gmt)).to(equal(.november))
            expect((unixSeconds.seconds + 334.days).since1970.calendarMonth(timeZone: .gmt)).to(equal(.december))
        }
        it("should return right year") {
            var unixSeconds = 631152000.seconds
            var expectedYear = 1990
            for _ in 0 ..< 1000 {
                unixSeconds += unixSeconds.since1970.isGregorianLeapYear() ? 366.days : 365.days
                expectedYear += 1
                expect(unixSeconds.since1970.calendarYear(timeZone: .gmt)).to(equal(expectedYear))
            }
        }
    }
}
