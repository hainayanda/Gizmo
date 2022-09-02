//
//  Array+Extensions.swift
//  Gizmo
//
//  Created by Nayanda Haberty on 27/07/22.
//

import Foundation

// MARK: Functional mutation add

public extension Array {
    
    /// Create new array added with given element at the end of the array
    /// - Complexity: O(1)
    /// - Parameter element: Element added
    /// - Returns: New array with added element
    @inlinable func added(with element: Element) -> [Element] {
        mutatingWithNewArray { $0.append(element) }
    }
    
    /// Create new array added with given contents of the sequence at the end of the array
    /// - Complexity: O(*m*) on average, where *m* is the length of sequence
    /// - Parameter sequence: Sequence of the elements
    /// - Returns: New array with added sequence
    @inlinable func added<S: Sequence>(withContentsOf sequence: S) -> [Element] where S.Element == Element {
        mutatingWithNewArray { $0.append(contentsOf: sequence) }
    }
    
    /// Create new array added with given elements at the end of the array
    /// - Complexity: O(*m*) on average, where *m* is the length of elements
    /// - Parameter elements: Elements added
    /// - Returns: New array with added elements
    @inlinable func added(with elements: Element...) -> [Element] {
        added(withContentsOf: elements)
    }
    
    /// Create new array added with given elements at the given index
    /// - Complexity: O(*n*), where *n* is the length of arrays
    /// - Parameters:
    ///   - index: Index of the new element
    ///   - element: Element added
    /// - Returns: New array with added element
    @inlinable func added(at index: Index, with element: Element) -> [Element] {
        mutatingWithNewArray { $0.insert(element, at: index)}
    }
    
    /// Create new array added with given contents of the collection at the given index
    /// - Complexity: O(*n* + *m*), where *n* is the length of arrays and *m* is length of collection
    /// - Parameters:
    ///   - index: Index of the new element
    ///   - collection: Collection of the elements
    /// - Returns: New array with added collection
    @inlinable func added<C: Collection>(at index: Index, withContentsOf collection: C) -> [Element] where C.Element == Element {
        mutatingWithNewArray { $0.insert(contentsOf: collection, at: index)}
    }
    
    /// Create new array added with given elements at the given index
    /// - Complexity: O(*n* + *m*), where *n* is the length of arrays and *m* is length of elements
    /// - Parameters:
    ///   - index: Index of the new elements
    ///   - elements: Elements added
    /// - Returns: New array with added elements
    @inlinable func added(at index: Index, with elements: Element...) -> [Element] {
        added(at: index, withContentsOf: elements)
    }
}

public extension Array where Element: Equatable {
    
    /// Create new array added with given element at the end of the array if the element is not present in this array
    /// - Complexity: O(*n*), where *n* is the length of arrays
    /// - Parameter element: Element added
    /// - Returns: New array with added element
    @inlinable func addedIfUnique(with element: Element) -> [Element] {
        guard !contains(element) else { return self }
        return added(with: element)
    }
    
    /// Create new array added with given contents of the sequence at the end of the array if the content is not present in this array
    /// - Complexity: O(*n* *m*), where *n* is the length of arrays and *m* is length of elements
    /// - Parameter sequence: Sequence of the elements
    /// - Returns: New array with added sequence
    @inlinable func addedIfUnique<S: Sequence>(withContentsOf sequence: S) -> [Element] where S.Element == Element {
        sequence.reduce(self) { partialResult, element in
            partialResult.addedIfUnique(with: element)
        }
    }
    
    /// Create new array added with given elements at the end of the array if the element is not present in this array
    /// - Complexity: O(*n* *m*), where *n* is the length of arrays and *m* is length of elements
    /// - Parameter elements: Elements added
    /// - Returns: New array with added elements
    @inlinable func addedIfUnique(with elements: Element...) -> [Element] {
        addedIfUnique(withContentsOf: elements)
    }
    
    /// Create new array added with given elements at the given index if the element is not present in this array
    /// - Complexity: O(*n*^2), where *n* is the length of arrays
    /// - Parameters:
    ///   - index: Index of the new element
    ///   - element: Element added
    /// - Returns: New array with added element
    @inlinable func addedIfUnique(at index: Index, with element: Element) -> [Element] {
        guard !contains(element) else { return self }
        return added(at: index, with: element)
    }
    
    /// Create new array added with given contents of the collection at the given index if the content is not present in this array
    /// - Complexity: O(*n*(2*n* + *m*)) at worst, where *n* is the length of arrays and *m* is length of collection
    /// - Parameters:
    ///   - index: Index of the new element
    ///   - collection: Collection of the elements
    /// - Returns: New array with added collection
    @inlinable func addedIfUnique<C: Collection>(at index: Index, withContentsOf collection: C) -> [Element] where C.Element == Element {
        var currentIndex = index
        return collection.reduce(self) { partialResult, element in
            guard !partialResult.contains(element) else { return partialResult }
            defer { currentIndex += 1 }
            return partialResult.added(at: currentIndex, with: element)
        }
    }
    
    /// Create new array added with given elements at the given index if the element is not present in this array
    /// - Complexity: O(*n*(2*n* + *m*)) at worst, where *n* is the length of arrays and *m* is length of collection
    /// - Parameters:
    ///   - index: Index of the new elements
    ///   - elements: Elements added
    /// - Returns: New array with added elements
    @inlinable func addedIfUnique(at index: Index, with elements: Element...) -> [Element] {
        addedIfUnique(at: index, withContentsOf: elements)
    }
}

public extension Array where Element: AnyObject {
    
    /// Create new array added with given element at the end of the array if the element instance is not present in this array
    /// - Complexity: O(*n*) where *n* is the length of arrays
    /// - Parameter element: Element added
    /// - Returns: New array with added element
    @inlinable func addedIfUniqueInstance(with element: Element) -> [Element] {
        guard !contains(where: { $0 === element }) else { return self }
        return added(with: element)
    }
    
    /// Create new array added with given contents of the sequence at the end of the array if the content instance is not present in this array
    /// - Complexity: O(*n* + *m*) at average, where *n* is the length of arrays and *m* is length of sequence
    /// - Parameter sequence: Sequence of the elements
    /// - Returns: New array with added sequence
    @inlinable func addedIfUniqueInstance<S: Sequence>(withContentsOf sequence: S) -> [Element] where S.Element == Element {
        var mappedIdentifier: [ObjectIdentifier: Void] = [:]
        forEach { element in
            let identifier = ObjectIdentifier(element)
            mappedIdentifier[identifier] = ()
        }
        return sequence.reduce(self) { partialResult, element in
            let identifier = ObjectIdentifier(element)
            guard mappedIdentifier[identifier] == nil else {
                return partialResult
            }
            return partialResult.added(with: element)
        }
    }
    
    /// Create new array added with given elements at the end of the array if the element instance is not present in this array
    /// - Complexity: O(*n* + *m*) at average, where *n* is the length of arrays and *m* is length of sequence
    /// - Parameter elements: Elements added
    /// - Returns: New array with added elements
    @inlinable func addedIfUniqueInstance(with elements: Element...) -> [Element] {
        addedIfUniqueInstance(withContentsOf: elements)
    }
    
    /// Create new array added with given elements at the given index if the element instance is not present in this array
    /// - Complexity: O(2*n* + *m*) at average, where *n* is the length of arrays and *m* is length of elements
    /// - Parameters:
    ///   - index: Index of the new element
    ///   - element: Element added
    /// - Returns: New array with added element
    @inlinable func addedIfUniqueInstance(at index: Index, with element: Element) -> [Element] {
        guard !contains(where: { $0 === element }) else { return self }
        return added(at: index, with: element)
    }
    
    /// Create new array added with given contents of the collection at the given index if the content instance is not present in this array
    /// - Complexity: O(2*n* + *m*) at average, where *n* is the length of arrays and *m* is length of collection
    /// - Parameters:
    ///   - index: Index of the new element
    ///   - collection: Collection of the elements
    /// - Returns: New array with added collection
    @inlinable func addedIfUniqueInstance<C: Collection>(at index: Index, withContentsOf collection: C) -> [Element] where C.Element == Element {
        var currentIndex = index
        var mappedIdentifier: [ObjectIdentifier: Void] = [:]
        forEach { element in
            let identifier = ObjectIdentifier(element)
            mappedIdentifier[identifier] = ()
        }
        return collection.reduce(self) { partialResult, element in
            let identifier = ObjectIdentifier(element)
            guard mappedIdentifier[identifier] == nil else {
                return partialResult
            }
            defer { currentIndex += 1 }
            return partialResult.added(at: currentIndex, with: element)
        }
    }
    
    /// Create new array added with given elements at the given index if the element instance is not present in this array
    /// - Complexity: O(2*n* + *m*) at average, where *n* is the length of arrays and *m* is length of elements
    /// - Parameters:
    ///   - index: Index of the new elements
    ///   - elements: Elements added
    /// - Returns: New array with added elements
    @inlinable func addedIfUniqueInstance(at index: Index, with elements: Element...) -> [Element] {
        addedIfUniqueInstance(at: index, withContentsOf: elements)
    }
}

// MARK: Functional mutation remove

public extension Array {
    
    /// Create new array with removed element at given index
    /// - Complexity: O(*n*) where *n* is the length of arrays
    /// - Parameter index: Index to remove
    /// - Returns: New array with removed element
    func removed(at index: Index) -> [Element] {
        whenIndexIsSafe(for: index) {
            mutatingWithNewArray { $0.remove(at: index) }
        } ?? self
    }
    
    /// Create new array with removed element when element found
    /// - Complexity: O(*n*) where *n* is the length of arrays
    /// - Parameter found: Closure to check element needs to be removed
    /// - Returns: New array with removed element
    @inlinable func removed(ifFound found: (Element) -> Bool) -> [Element] {
        mutatingWithNewArray { $0.removeAll(where: found) }
    }
    
}

public extension Array where Element: Equatable {
    
    /// Create new array with removed element when same element found
    /// - Complexity: O(*n*) where *n* is the length of arrays
    /// - Parameter element: element to be removed
    /// - Returns: New array with removed element
    @inlinable func removed(_ element: Element) -> [Element] {
        removed { $0 == element }
    }
    
    /// Create new array with removed element when same element found
    /// - Complexity: O(*n* *m*) where *n* is the length of arrays and *m* is length of sequence
    /// - Parameter elements: elements to be removed
    /// - Returns: New array with removed element
    @inlinable func removed(_ elements: [Element]) -> [Element] {
        removed { elements.contains($0) }
    }
    
    /// Create new array with removed element when same element found
    /// - Complexity: O(*n* *m*) where *n* is the length of arrays and *m* is length of sequence
    /// - Parameter elements: elements to be removed
    /// - Returns: New array with removed element
    @inlinable func removed(_ elements: Element...) -> [Element] {
        removed(elements)
    }
}

public extension Array where Element: AnyObject {
    
    /// Create new array with removed element when same element instance found
    /// - Complexity: O(*n*) where *n* is the length of arrays
    /// - Parameter element: element to be removed
    /// - Returns: New array with removed element
    @inlinable func removedSameInstance(_ element: Element) -> [Element] {
        removed { $0 === element }
    }
    
    /// Create new array with removed element when same element instance found
    /// - Complexity: O(*n* + *m*) at average, where *n* is the length of arrays and *m* is length of sequence
    /// - Parameter elements: elements to be removed
    /// - Returns: New array with removed element
    @inlinable func removedSameInstance(in elements: [Element]) -> [Element] {
        var seen: [ObjectIdentifier: Void] = [:]
        for element in elements {
            let identifier = ObjectIdentifier(element)
            seen[identifier] = ()
        }
        return removed { element in
            seen[ObjectIdentifier(element)] != nil
        }
    }
    
    /// Create new array with removed element when same element instance found
    /// - Complexity: O(*n* + *m*) at average, where *n* is the length of arrays and *m* is length of sequence
    /// - Parameter elements: elements to be removed
    /// - Returns: New array with removed element
    @inlinable func removedSameInstance(_ elements: Element...) -> [Element] {
        removedSameInstance(in: elements)
    }
}

public extension Array {
    
    /// Append new element to array until it reaches target count
    /// It will remove the last element if the array count is greater than target count
    /// - Complexity: O(*k*) if array count is greater that target count and O(*m*) if array count is less than target count, where *k* is array count minus target count and *m* is target count minus array count
    /// - Parameters:
    ///   - targetCount: Target size of the array
    ///   - adder: Closure that will called if its need element on certain index
    mutating func appendOrRemove(untilReachCount targetCount: Int, adder: (Int) -> Element) {
        guard count < targetCount else {
            removeLast(count - targetCount)
            return
        }
        while count < targetCount {
            append(adder(count))
        }
    }
    
    /// Append new element to array until it reaches target count
    /// It will remove the last element if the array count is greater than target count
    /// - Complexity: O(*k*) if array count is greater that target count and O(*m*) if array count is less than target count, where *k* is array count minus target count and *m* is target count minus array count
    /// - Parameters:
    ///   - targetCount: Target size of the array
    ///   - addingElement: Element that will be added if needed
    mutating func appendOrRemove(untilReachCount targetCount: Int, addingElement: Element) {
        appendOrRemove(untilReachCount: targetCount, adder: { _ in addingElement })
    }
    
    /// Create new duplicated array and add new element to that array until it reaches target count
    /// It will remove the last element if the array count is greater than target count
    /// - Complexity: O(*k*) if array count is greater that target count and O(*m*) if array count is less than target count, where *k* is array count minus target count and *m* is target count minus array count
    /// - Parameters:
    ///   - targetCount: Target size of the array
    ///   - adder: Closure that will called if its need element on certain index
    /// - Returns: New array
    func addedOrRemoved(untilReachCount targetCount: Int, adder: (Int) -> Element) -> [Element] {
        mutatingWithNewArray { $0.appendOrRemove(untilReachCount: targetCount, adder: adder) }
    }
    
    /// Create new duplicated array and add new element to that array until it reaches target count
    /// It will remove the last element if the array count is greater than target count
    /// - Complexity: O(*k*) if array count is greater that target count and O(*m*) if array count is less than target count, where *k* is array count minus target count and *m* is target count minus array count
    /// - Parameters:
    ///   - targetCount: Target size of the array
    ///   - addingElement: Element that will be added if needed
    /// - Returns: New array
    func addedOrRemoved(untilReachCount targetCount: Int, addingElement: Element) -> [Element] {
        mutatingWithNewArray { $0.appendOrRemove(untilReachCount: targetCount, addingElement: addingElement) }
    }
}

extension Array {
    
    @inlinable func mutatingWithNewArray(_ mutator: (inout [Element]) -> Void) -> [Element] {
        var newArray = self
        mutator(&newArray)
        return newArray
    }
}
