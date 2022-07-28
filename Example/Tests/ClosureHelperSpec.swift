//
//  ClosureHelperSpec.swift
//  Gizmo_Tests
//
//  Created by Nayanda Haberty on 28/07/22.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import Foundation
import Quick
import Nimble
import Gizmo

class ClosureHelperSpec: QuickSpec {
    
    override func spec() {
        context("void closure") {
            var source: VoidMethodSource!
            var voidMethod: VoidClosure!
            var voidMethod1: Closure<Int>!
            var voidMethod2: BiArgsClosure<Int, String>!
            var voidMethod3: TriArgsClosure<Int, String, Int>!
            var voidMethod4: QuadArgsClosure<Int, String, Int, String>!
            beforeEach {
                voidMethodCalled = false
                voidMethod1ParamCalled = nil
                voidMethodParam2Called = nil
                voidMethodParam3Called = nil
                voidMethodParam4Called = nil
                source = VoidMethodSource()
                voidMethod = methodOf(source, VoidMethodSource.voidMethod)
                voidMethod1 = methodOf(source, VoidMethodSource.voidMethod1)
                voidMethod2 = methodOf(source, VoidMethodSource.voidMethod2)
                voidMethod3 = methodOf(source, VoidMethodSource.voidMethod3)
                voidMethod4 = methodOf(source, VoidMethodSource.voidMethod4)
            }
            it("should call an actual method") {
                voidMethod()
                expect(voidMethodCalled).to(beTrue())
                
                let param1 = Int.random(in: -128..<128)
                voidMethod1(param1)
                expect(voidMethod1ParamCalled).to(equal(param1))
                
                let param2 = UUID().uuidString
                voidMethod2(param1, param2)
                guard let params2 = voidMethodParam2Called else {
                    fail("method did not called")
                    return
                }
                expect(params2.0).to(equal(param1))
                expect(params2.1).to(equal(param2))
                
                let param3 = Int.random(in: -128..<128)
                voidMethod3(param1, param2, param3)
                guard let params3 = voidMethodParam3Called else {
                    fail("method did not called")
                    return
                }
                expect(params3.0).to(equal(param1))
                expect(params3.1).to(equal(param2))
                expect(params3.2).to(equal(param3))
                
                let param4 = UUID().uuidString
                voidMethod4(param1, param2, param3, param4)
                guard let params4 = voidMethodParam4Called else {
                    fail("method did not called")
                    return
                }
                expect(params4.0).to(equal(param1))
                expect(params4.1).to(equal(param2))
                expect(params4.2).to(equal(param3))
                expect(params4.3).to(equal(param4))
            }
            it("should ignore an actual method if object released") {
                source = nil
                voidMethod()
                expect(voidMethodCalled).to(beFalse())
                
                let param1 = Int.random(in: -128..<128)
                voidMethod1(param1)
                expect(voidMethod1ParamCalled).to(beNil())
                
                let param2 = UUID().uuidString
                voidMethod2(param1, param2)
                expect(voidMethodParam2Called).to(beNil())
                
                let param3 = Int.random(in: -128..<128)
                voidMethod3(param1, param2, param3)
                expect(voidMethodParam3Called).to(beNil())
                
                let param4 = UUID().uuidString
                voidMethod4(param1, param2, param3, param4)
                expect(voidMethodParam4Called).to(beNil())
            }
        }
        context("return closure") {
            var source: ReturnMethodSource!
            var returnMethod: ReturnClosure<Int?>!
            var returnMethod1: ReturnSingleArgClosure<Int, Int?>!
            var returnMethod2: ReturnBiArgsClosure<Int, Int, Int?>!
            var returnMethod3: ReturnTriArgsClosure<Int, Int, Int, Int?>!
            var returnMethod4: ReturnQuadArgsClosure<Int, Int, Int, Int, Int?>!
            beforeEach {
                source = ReturnMethodSource()
                returnMethod = methodOf(source, ReturnMethodSource.returnMethod)
                returnMethod1 = methodOf(source, ReturnMethodSource.returnMethod1)
                returnMethod2 = methodOf(source, ReturnMethodSource.returnMethod2)
                returnMethod3 = methodOf(source, ReturnMethodSource.returnMethod3)
                returnMethod4 = methodOf(source, ReturnMethodSource.returnMethod4)
            }
            it("should call an actual method") {
                expect(returnMethod()).to(equal(0))
                expect(returnMethod1(1)).to(equal(1))
                expect(returnMethod2(2, 3)).to(equal(5))
                expect(returnMethod3(4, 5, 6)).to(equal(15))
                expect(returnMethod4(7, 8, 9, 10)).to(equal(34))
            }
            it("should ignore an actual method if object released") {
                source = nil
                expect(returnMethod()).to(beNil())
                expect(returnMethod1(1)).to(beNil())
                expect(returnMethod2(2, 3)).to(beNil())
                expect(returnMethod3(4, 5, 6)).to(beNil())
                expect(returnMethod4(7, 8, 9, 10)).to(beNil())
            }
        }
        context("return closure with default") {
            var source: ReturnMethodSource!
            var returnMethod: ReturnClosure<Int>!
            var returnMethod1: ReturnSingleArgClosure<Int, Int>!
            var returnMethod2: ReturnBiArgsClosure<Int, Int, Int>!
            var returnMethod3: ReturnTriArgsClosure<Int, Int, Int, Int>!
            var returnMethod4: ReturnQuadArgsClosure<Int, Int, Int, Int, Int>!
            beforeEach {
                source = ReturnMethodSource()
                returnMethod = methodOf(source, ReturnMethodSource.returnMethod, ifObjectReleasedThenReturn: -1)
                returnMethod1 = methodOf(source, ReturnMethodSource.returnMethod1, ifObjectReleasedThenReturn: -1)
                returnMethod2 = methodOf(source, ReturnMethodSource.returnMethod2, ifObjectReleasedThenReturn: -1)
                returnMethod3 = methodOf(source, ReturnMethodSource.returnMethod3, ifObjectReleasedThenReturn: -1)
                returnMethod4 = methodOf(source, ReturnMethodSource.returnMethod4, ifObjectReleasedThenReturn: -1)
            }
            it("should call an actual method") {
                expect(returnMethod()).to(equal(0))
                expect(returnMethod1(1)).to(equal(1))
                expect(returnMethod2(2, 3)).to(equal(5))
                expect(returnMethod3(4, 5, 6)).to(equal(15))
                expect(returnMethod4(7, 8, 9, 10)).to(equal(34))
            }
            it("should ignore an actual method if object released") {
                source = nil
                expect(returnMethod()).to(equal(-1))
                expect(returnMethod1(1)).to(equal(-1))
                expect(returnMethod2(2, 3)).to(equal(-1))
                expect(returnMethod3(4, 5, 6)).to(equal(-1))
                expect(returnMethod4(7, 8, 9, 10)).to(equal(-1))
            }
        }
        context("return optional closure") {
            var source: OptionalReturnMethodSource!
            var returnMethod: ReturnClosure<Int?>!
            var returnMethod1: ReturnSingleArgClosure<Int, Int?>!
            var returnMethod2: ReturnBiArgsClosure<Int, Int, Int?>!
            var returnMethod3: ReturnTriArgsClosure<Int, Int, Int, Int?>!
            var returnMethod4: ReturnQuadArgsClosure<Int, Int, Int, Int, Int?>!
            beforeEach {
                source = OptionalReturnMethodSource()
                returnMethod = methodOf(source, OptionalReturnMethodSource.returnMethod)
                returnMethod1 = methodOf(source, OptionalReturnMethodSource.returnMethod1)
                returnMethod2 = methodOf(source, OptionalReturnMethodSource.returnMethod2)
                returnMethod3 = methodOf(source, OptionalReturnMethodSource.returnMethod3)
                returnMethod4 = methodOf(source, OptionalReturnMethodSource.returnMethod4)
            }
            it("should call an actual method") {
                expect(returnMethod()).to(equal(0))
                expect(returnMethod1(1)).to(equal(1))
                expect(returnMethod2(2, 3)).to(equal(5))
                expect(returnMethod3(4, 5, 6)).to(equal(15))
                expect(returnMethod4(7, 8, 9, 10)).to(equal(34))
            }
            it("should ignore an actual method if object released") {
                source = nil
                expect(returnMethod()).to(beNil())
                expect(returnMethod1(1)).to(beNil())
                expect(returnMethod2(2, 3)).to(beNil())
                expect(returnMethod3(4, 5, 6)).to(beNil())
                expect(returnMethod4(7, 8, 9, 10)).to(beNil())
            }
        }
    }
}

var voidMethodCalled: Bool = false
var voidMethod1ParamCalled: Int?
var voidMethodParam2Called: (Int, String)?
var voidMethodParam3Called: (Int, String, Int)?
var voidMethodParam4Called: (Int, String, Int, String)?

fileprivate class VoidMethodSource {
    func voidMethod() {
        voidMethodCalled = true
    }
    
    func voidMethod1(param: Int) {
        voidMethod1ParamCalled = param
    }
    
    func voidMethod2(param1: Int, param2: String) {
        voidMethodParam2Called = (param1, param2)
    }
    
    func voidMethod3(param1: Int, param2: String, param3: Int) {
        voidMethodParam3Called = (param1, param2, param3)
    }
    
    func voidMethod4(param1: Int, param2: String, param3: Int, param4: String) {
        voidMethodParam4Called = (param1, param2, param3, param4)
    }
}

fileprivate class ReturnMethodSource {
    
    func returnMethod() -> Int {
        0
    }
    
    func returnMethod1(param: Int) -> Int {
        param
    }
    
    func returnMethod2(param1: Int, param2: Int) -> Int {
        param1 + param2
    }
    
    func returnMethod3(param1: Int, param2: Int, param3: Int) -> Int {
        param1 + param2 + param3
    }
    
    func returnMethod4(param1: Int, param2: Int, param3: Int, param4: Int) -> Int {
        param1 + param2 + param3 + param4
    }
}

fileprivate class OptionalReturnMethodSource {
    
    func returnMethod() -> Int? {
        0
    }
    
    func returnMethod1(param: Int) -> Int? {
        param
    }
    
    func returnMethod2(param1: Int, param2: Int) -> Int? {
        param1 + param2
    }
    
    func returnMethod3(param1: Int, param2: Int, param3: Int) -> Int? {
        param1 + param2 + param3
    }
    
    func returnMethod4(param1: Int, param2: Int, param3: Int, param4: Int) -> Int {
        param1 + param2 + param3 + param4
    }
}
