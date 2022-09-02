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
        it("should create unique array") {
            let array = [1, 1, 2, 3, 4, 4, 5, 5, 5, 6]
            expect(array.uniquedArray).to(equal([1, 2, 3, 4, 5, 6]))
        }
        it("should create unique array from hash") {
            let array = [1, 1, 2, 3, 4, 4, 5, 5, 5, 6]
            expect(array.uniquedArray { $0 }).to(equal([1, 2, 3, 4, 5, 6]))
        }
        it("should removed elements instance found") {
            let object1 = MyObject()
            let object2 = MyObject()
            let object3 = MyObject()
            let object4 = MyObject()
            let array = [object1, object1, object2, object3, object3, object3, object4]
            expect(array.uniquedObjectsArray).to(equal([object1, object2, object3, object4]))
        }
        it("should create symetric difference with another array") {
            let array1 = [1, 2, 3, 4, 5, 6]
            let array2 = [4, 5, 6, 7, 8, 9]
            expect(array1.symetricDifferencedArray(from: array2)).to(equal([1, 2, 3, 7, 8, 9]))
            expect(array2.symetricDifferencedArray(from: array1)).to(equal([7, 8, 9, 1, 2, 3]))
        }
        it("should substract array with another array") {
            let array1 = [1, 2, 3, 4, 5, 6]
            let array2 = [4, 5, 6, 7, 8, 9]
            expect(array1.substractedToArray(by: array2)).to(equal([1, 2, 3]))
            expect(array2.substractedToArray(by: array1)).to(equal([7, 8, 9]))
        }
        it("should intersect array with another array") {
            let array1 = [1, 2, 3, 4, 5, 6]
            let array2 = [4, 5, 6, 7, 8, 9]
            expect(array1.intersection(with: array2)).to(equal([4, 5, 6]))
            expect(array1.intersection(with: array2)).to(equal([4, 5, 6]))
        }
        it("should create symetric difference with another array") {
            let array1 = [1, 2, 3, 4, 5, 6]
            let array2 = [4, 5, 6, 7, 8, 9]
            expect(array1.symetricDifferencedArray(from: array2) { $0 }).to(equal([1, 2, 3, 7, 8, 9]))
            expect(array2.symetricDifferencedArray(from: array1) { $0 }).to(equal([7, 8, 9, 1, 2, 3]))
        }
        it("should substract array with another array") {
            let array1 = [1, 2, 3, 4, 5, 6]
            let array2 = [4, 5, 6, 7, 8, 9]
            expect(array1.substractedToArray(by: array2) { $0 }).to(equal([1, 2, 3]))
            expect(array2.substractedToArray(by: array1) { $0 }).to(equal([7, 8, 9]))
        }
        it("should intersect array with another array") {
            let array1 = [1, 2, 3, 4, 5, 6]
            let array2 = [4, 5, 6, 7, 8, 9]
            expect(array1.intersection(with: array2) { $0 }).to(equal([4, 5, 6]))
            expect(array1.intersection(with: array2) { $0 }).to(equal([4, 5, 6]))
        }
        it("should create symetric difference with another array") {
            let object1 = MyObject()
            let object2 = MyObject()
            let object3 = MyObject()
            let object4 = MyObject()
            let object5 = MyObject()
            let object6 = MyObject()
            let array1 = [object1, object2, object3, object4]
            let array2 = [object3, object4, object5, object6]
            expect(array1.objectsSymetricDifference(from: array2)).to(equal([object1, object2, object5, object6]))
            expect(array2.objectsSymetricDifference(from: array1)).to(equal([object5, object6, object1, object2]))
        }
        it("should substract array with another array") {
            let object1 = MyObject()
            let object2 = MyObject()
            let object3 = MyObject()
            let object4 = MyObject()
            let object5 = MyObject()
            let object6 = MyObject()
            let array1 = [object1, object2, object3, object4]
            let array2 = [object3, object4, object5, object6]
            expect(array1.objectsSubstractedToArray(by: array2)).to(equal([object1, object2]))
            expect(array2.objectsSubstractedToArray(by: array1)).to(equal([object5, object6]))
        }
        it("should intersect array with another array") {
            let object1 = MyObject()
            let object2 = MyObject()
            let object3 = MyObject()
            let object4 = MyObject()
            let object5 = MyObject()
            let object6 = MyObject()
            let array1 = [object1, object2, object3, object4]
            let array2 = [object3, object4, object5, object6]
            expect(array1.objectsIntersection(with: array2)).to(equal([object3, object4]))
            expect(array1.objectsIntersection(with: array2)).to(equal([object3, object4]))
        }
    }
}

fileprivate class MyObject: Equatable {
    let id: String = UUID().uuidString
    
    static func == (lhs: MyObject, rhs: MyObject) -> Bool {
        lhs.id == rhs.id
    }
}
