//
//  ArrayExtensionsSpec.swift
//  Gizmo_Tests
//
//  Created by Nayanda Haberty on 28/07/22.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import Foundation
import Quick
import Nimble
import Gizmo

class ArrayExtensionsSpec: QuickSpec {
    
    override func spec() {
        it("should create new array with added element") {
            let array = [1, 2]
            expect(array.added(with: 3)).to(equal([1, 2, 3]))
        }
        it("should create new array with added elements") {
            let array = [1, 2]
            expect(array.added(with: 3, 4, 5)).to(equal([1, 2, 3, 4, 5]))
        }
        it("should create new array with added elements") {
            let array = [1, 2]
            expect(array.added(withContentsOf: [3, 4, 5])).to(equal([1, 2, 3, 4, 5]))
        }
        it("should create new array with added element at given index") {
            let array = [1, 2]
            expect(array.added(at: 0, with: 3)).to(equal([3, 1, 2]))
        }
        it("should create new array with added elements at given index") {
            let array = [1, 2]
            expect(array.added(at: 0, with: 3, 4, 5)).to(equal([3, 4, 5, 1, 2]))
        }
        it("should create new array with added elements at given index") {
            let array = [1, 2]
            expect(array.added(at: 0, withContentsOf: [3, 4, 5])).to(equal([3, 4, 5, 1, 2]))
        }
        it("should create new array with added unique element") {
            let array = [1, 2]
            expect(array.addedIfUnique(with: 3)).to(equal([1, 2, 3]))
            expect(array.addedIfUnique(with: 2)).to(equal([1, 2]))
        }
        it("should create new array with added unique elements") {
            let array = [1, 2]
            expect(array.addedIfUnique(with: 2, 3, 4, 5)).to(equal([1, 2, 3, 4, 5]))
        }
        it("should create new array with added unique elements") {
            let array = [1, 2]
            expect(array.addedIfUnique(withContentsOf: [2, 3, 4, 5])).to(equal([1, 2, 3, 4, 5]))
        }
        it("should create new array with added unique element at given index") {
            let array = [1, 2]
            expect(array.addedIfUnique(at: 0, with: 3)).to(equal([3, 1, 2]))
            expect(array.addedIfUnique(at: 0, with: 1)).to(equal([1, 2]))
        }
        it("should create new array with added unique elements at given index") {
            let array = [1, 2]
            expect(array.addedIfUnique(at: 0, with: 2, 3, 4, 5)).to(equal([3, 4, 5, 1, 2]))
        }
        it("should create new array with added unique elements at given index") {
            let array = [1, 2]
            expect(array.addedIfUnique(at: 0, withContentsOf: [2, 3, 4, 5])).to(equal([3, 4, 5, 1, 2]))
        }
        it("should create new array with added unique object") {
            let object1 = MyObject()
            let object2 = MyObject()
            let array = [object1]
            expect(array.addedIfUniqueInstance(with: object2)).to(equal([object1, object2]))
            expect(array.addedIfUniqueInstance(with: object1)).to(equal([object1]))
        }
        it("should create new array with added unique objects") {
            let object1 = MyObject()
            let object2 = MyObject()
            let object3 = MyObject()
            let object4 = MyObject()
            let array = [object1, object2]
            expect(array.addedIfUniqueInstance(with: object2, object2, object3, object3, object4)).to(equal([object1, object2, object3, object3, object4]))
        }
        it("should create new array with added unique objects") {
            let object1 = MyObject()
            let object2 = MyObject()
            let object3 = MyObject()
            let object4 = MyObject()
            let array = [object1, object2]
            expect(array.addedIfUniqueInstance(withContentsOf: [object2, object2, object3, object3, object4])).to(equal([object1, object2, object3, object3, object4]))
        }
        it("should create new array with added unique object at given index") {
            let object1 = MyObject()
            let object2 = MyObject()
            let object3 = MyObject()
            let array = [object1, object2]
            expect(array.addedIfUniqueInstance(at: 0, with: object3)).to(equal([object3, object1, object2]))
            expect(array.addedIfUniqueInstance(at: 0, with: object2)).to(equal([object1, object2]))
        }
        it("should create new array with added unique objects at given index") {
            let object1 = MyObject()
            let object2 = MyObject()
            let object3 = MyObject()
            let object4 = MyObject()
            let array = [object1, object2]
            expect(array.addedIfUniqueInstance(at: 0, with: object2, object2, object3, object3, object4)).to(equal([object3, object3, object4, object1, object2]))
        }
        it("should create new array with added unique objects at given index") {
            let object1 = MyObject()
            let object2 = MyObject()
            let object3 = MyObject()
            let object4 = MyObject()
            let array = [object1, object2]
            expect(array.addedIfUniqueInstance(at: 0, withContentsOf: [object2, object2, object3, object3, object4])).to(equal([object3, object3, object4, object1, object2]))
        }
        it("should removed element at given index") {
            let array = [1, 2, 3]
            expect(array.removed(at: 1)).to(equal([1, 3]))
            expect(array.removed(at: 3)).to(equal([1, 2, 3]))
        }
        it("should removed element found") {
            let array = [1, 2, 3]
            expect(array.removed(2)).to(equal([1, 3]))
            expect(array.removed(4)).to(equal([1, 2, 3]))
        }
        it("should removed elements found") {
            let array = [1, 2, 3, 4, 5]
            expect(array.removed(4, 5, 6)).to(equal([1, 2, 3]))
        }
        it("should removed elements found") {
            let array = [1, 2, 3, 4, 5]
            expect(array.removed([4, 5, 6])).to(equal([1, 2, 3]))
        }
        it("should removed element instance found") {
            let object1 = MyObject()
            let object2 = MyObject()
            let object3 = MyObject()
            let object4 = MyObject()
            let array = [object1, object2, object3]
            expect(array.removedSameInstance(object2)).to(equal([object1, object3]))
            expect(array.removedSameInstance(object4)).to(equal([object1, object2, object3]))
        }
        it("should removed elements instance found") {
            let object1 = MyObject()
            let object2 = MyObject()
            let object3 = MyObject()
            let object4 = MyObject()
            let array = [object1, object2, object3]
            expect(array.removedSameInstance(object3, object4)).to(equal([object1, object2]))
        }
        it("should removed elements instance found") {
            let object1 = MyObject()
            let object2 = MyObject()
            let object3 = MyObject()
            let object4 = MyObject()
            let array = [object1, object2, object3]
            expect(array.removedSameInstance(in: [object3, object4])).to(equal([object1, object2]))
        }
        it("should create array with target count") {
            let targetCount = Int.random(in: 20..<50)
            let array: [Int] = .init(targetCount: targetCount, indexedElement: { $0 })
            var content = 0
            array.forEach {
                expect($0).to(equal(content))
                content += 1
            }
            expect(content).to(equal(targetCount))
            expect(array.count).to(equal(targetCount))
        }
        it("should add array until reach count") {
            let targetCount = Int.random(in: 20..<50)
            var array: [DummyEquatable] = .dummies(count: Int.random(in: 0..<10))
            var count = array.count
            array.appendOrRemove(untilReachCount: targetCount) { index in
                expect(count).to(equal(index))
                count += 1
                return DummyEquatable()
            }
            expect(count).to(equal(targetCount))
            expect(count).to(equal(array.count))
        }
        it("should remove array until reach count") {
            let targetCount = Int.random(in: 0..<10)
            var array: [DummyEquatable] = .dummies(count: Int.random(in: 10..<50))
            array.appendOrRemove(untilReachCount: targetCount)  { _ in DummyEquatable() }
            expect(array.count).to(equal(targetCount))
        }
    }
}

fileprivate class MyObject: Equatable {
    let id: String = UUID().uuidString
    
    static func == (lhs: MyObject, rhs: MyObject) -> Bool {
        lhs.id == rhs.id
    }
}
