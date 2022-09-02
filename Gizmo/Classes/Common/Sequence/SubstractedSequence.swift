//
//  SubstractedSequence.swift
//  Gizmo
//
//  Created by Nayanda Haberty on 1/9/22.
//

import Foundation

// MARK: Sequence + Extensions

public extension Sequence {
    
    /// Simply just shortcut to `substracted(by: otherSequence, projection).asArray`
    /// Keep in mind this will automatically run the iterator iteration when creating an new Array.
    /// If you just need to iterate the element uniquely, consider using `substracted` instead
    /// ```
    /// // this will have time complexity O(k + l + m) where k is myArray length, l is otherArray length and m is intersection array length
    /// myArray.substractedToArray(by: otherArray) { projecting($0) }.forEach {
    ///     print($0)
    /// }
    ///
    /// // this will have time complexity O(k + l) since the intersection check will be executed while iterating forEach
    /// myArray.substracted(by: otherArray) { projecting($0) }.forEach {
    ///     print($0)
    /// }
    /// ```
    /// - Complexity: O(*n* + *m*) on average, where *n* is the original sequence iterator iteration count, and *m* is the substracting sequence iterator iteration count
    /// - Parameters:
    ///   - otherSequence: A sequence to substract this sequence
    ///   - projection: A closure that accepts an element of this sequence as its argument and returns an hashable value.
    /// - Returns: Array of element from this sequence substracted by given sequence
    @inlinable func substractedToArray<S: Sequence, Projection: Hashable>(
        by otherSequence: S,
        _ projection: @escaping (Element) -> Projection) -> [Element]
    where S.Element == Element {
        substracted(by: otherSequence, projection).asArray
    }
    
    /// Create a sequence wrapper that will only iterate elements substracted between two sequence
    /// Since it will only check substracted elements when in iteration, the time complexity for the creation of this sequence is O(1)
    /// - Complexity: Executing this code will have complexity of O(1). Iterating it will have average complexity of O(*n* + *m*) where *n* is the original sequence iterator iteration count, and *m* is the substracting sequence iterator iteration count
    /// - Parameters:
    ///   - otherSequence: A sequence to substract this sequence
    ///   - projection: A closure that accepts an element of this sequence as its argument and returns an hashable value.
    /// - Returns: SequenceWrapper that will check substracted element during its iterator iteration
    func substracted<S: Sequence, Projection: Hashable>(
        by otherSequence: S,
        _ projection: @escaping (Element) -> Projection) -> SequenceWrapper<Element>
    where S.Element == Element {
        SequenceWrapper(
            iterator: SubstractedProjectionSequenceIterator(
                sequence: self,
                substractedBy: otherSequence,
                projection: projection
            )
        )
    }
}

// MARK: Equatable Sequence + Extensions

public extension Sequence where Element: Equatable {
    
    /// Simply just shortcut to `substracted(by: otherSequence).asArray`
    /// Keep in mind this will automatically run the iterator iteration when creating an new Array.
    /// If you just need to iterate the element uniquely, consider using `substracted` instead
    /// ```
    /// // this will have time complexity O(k + l + m) where k is myArray length, l is otherArray length and m is intersection array length
    /// myArray.substractedToArray(by: otherArray).forEach {
    ///     print($0)
    /// }
    ///
    /// // this will have time complexity O(k + l) since the intersection check will be executed while iterating forEach
    /// myArray.substracted(by: otherArray).forEach {
    ///     print($0)
    /// }
    /// ```
    /// - Complexity: O(*n* *m*) on average, where *n* is the original sequence iterator iteration count, and *m* is the substracting sequence iterator iteration count
    /// - Parameter otherSequence: A sequence to substract this sequence
    /// - Returns: Array of element from this sequence substracted by given sequence
    @inlinable func substractedToArray<S: Sequence>(by otherSequence: S) -> [Element]
    where S.Element == Element {
        substracted(by: otherSequence).asArray
    }
    
    /// Create a sequence wrapper that will only iterate elements substracted between two sequence
    /// Since it will only check substracted elements when in iteration, the time complexity for the creation of this sequence is O(1)
    /// - Complexity: Executing this code will have complexity of O(1). Iterating it will have average complexity of O(*n* *m*) where *n* is the original sequence iterator iteration count, and *m* is the substracting sequence iterator iteration count
    /// - Parameter otherSequence: A sequence to substract this sequence
    /// - Returns: SequenceWrapper that will check substracted element during its iterator iteration
    func substracted<S: Sequence>(by otherSequence: S) -> SequenceWrapper<Element>
    where S.Element == Element {
        SequenceWrapper(iterator: SubstractedEquatableSequenceIterator(sequence: self, substractedBy: otherSequence))
    }
}

// MARK: Hashable Sequence + Extensions

public extension Sequence where Element: Hashable {
    
    /// Simply just shortcut to `substracted(by: otherSequence).asArray`
    /// Keep in mind this will automatically run the iterator iteration when creating an new Array.
    /// If you just need to iterate the element uniquely, consider using `substracted` instead
    /// ```
    /// // this will have time complexity O(k + l + m) where k is myArray length, l is otherArray length and m is intersection array length
    /// myArray.substractedToArray(by: otherArray).forEach {
    ///     print($0)
    /// }
    ///
    /// // this will have time complexity O(k + l) since the intersection check will be executed while iterating forEach
    /// myArray.substracted(by: otherArray).forEach {
    ///     print($0)
    /// }
    /// ```
    /// - Complexity: O(*n* + *m*) on average, where *n* is the original sequence iterator iteration count, and *m* is the substracting sequence iterator iteration count
    /// - Parameter otherSequence: A sequence to substract this sequence
    /// - Returns: Array of element from this sequence substracted by given sequence
    @inlinable func substractedToArray<S: Sequence>(by otherSequence: S) -> [Element]
    where S.Element == Element {
        substracted(by: otherSequence).asArray
    }
    
    /// Create a sequence wrapper that will only iterate elements substracted between two sequence
    /// Since it will only check substracted elements when in iteration, the time complexity for the creation of this sequence is O(1)
    /// - Complexity: Executing this code will have complexity of O(1). Iterating it will have average complexity of O(*n* + *m*) where *n* is the original sequence iterator iteration count, and *m* is the substracting sequence iterator iteration count
    /// - Parameter otherSequence: A sequence to substract this sequence
    /// - Returns: SequenceWrapper that will check substracted element during its iterator iteration
    func substracted<S: Sequence>(by otherSequence: S) -> SequenceWrapper<Element>
    where S.Element == Element {
        SequenceWrapper(iterator: SubstractedHashableSequenceIterator(sequence: self, substractedBy: otherSequence))
    }
}

// MARK: AnyObject Sequence + Extensions

public extension Sequence where Element: AnyObject {
    
    /// Simply just shortcut to `objectsSubstracted(by: otherSequence).asArray`
    /// Keep in mind this will automatically run the iterator iteration when creating an new Array.
    /// If you just need to iterate the element uniquely, consider using `substracted` instead
    /// ```
    /// // this will have time complexity O(k + l + m) where k is myArray length, l is otherArray length and m is intersection array length
    /// myArray.objectsSubstractedToArray(by: otherArray).forEach {
    ///     print($0)
    /// }
    ///
    /// // this will have time complexity O(k + l) since the intersection check will be executed while iterating forEach
    /// myArray.objectsSubstracted(by: otherArray).forEach {
    ///     print($0)
    /// }
    /// ```
    /// - Complexity: O(*n* + *m*) on average, where *n* is the original sequence iterator iteration count, and *m* is the substracting sequence iterator iteration count
    /// - Parameter otherSequence: A sequence to substract this sequence
    /// - Returns: Array of object from this sequence substracted by given sequence
    @inlinable func objectsSubstractedToArray<S: Sequence>(by otherSequence: S) -> [Element]
    where S.Element == Element {
        objectsSubstracted(by: otherSequence).asArray
    }
    
    /// Create a sequence wrapper that will only iterate objects substracted between two sequence
    /// Since it will only check substracted objects when in iteration, the time complexity for the creation of this sequence is O(1)
    /// - Complexity: Executing this code will have complexity of O(1). Iterating it will have average complexity of O(*n* + *m*) where *n* is the original sequence iterator iteration count, and *m* is the substracting sequence iterator iteration count
    /// - Parameter otherSequence: A sequence to substract this sequence
    /// - Returns: SequenceWrapper that will check substracted object during its iterator iteration
    @inlinable func objectsSubstracted<S: Sequence>(by otherSequence: S) -> SequenceWrapper<Element>
    where S.Element == Element {
        substracted(by: otherSequence) { ObjectIdentifier($0) }
    }
}

// MARK: SubstractedSequenceIterator

class SubstractedSequenceIterator<BaseSequence: Sequence, SubstractSequence: Sequence>:  SequenceWrapperIterator<BaseSequence.Element>
where SubstractSequence.Element == BaseSequence.Element {
    
    typealias BaseIterator = BaseSequence.Iterator
    
    var iterator: BaseIterator
    
    init(sequence: BaseSequence) {
        self.iterator = sequence.makeIterator()
    }
    
    public override func next() -> Element? {
        guard let nextIteration = iterator.next() else {
            return nil
        }
        guard nextIfAppearsInSubstractor(for: nextIteration) else {
            return nextIteration
        }
        return next()
    }
    
    func nextIfAppearsInSubstractor(for element: Element) -> Bool {
        fatalError("this method should be overriden")
    }
}

// MARK: SubstractedEquatableSequenceIterator

class SubstractedEquatableSequenceIterator<BaseSequence: Sequence, SubstractSequence: Sequence>: SubstractedSequenceIterator<BaseSequence, SubstractSequence>
where BaseSequence.Element: Equatable,
      SubstractSequence.Element == BaseSequence.Element {
    
    let substractor: SubstractSequence
    
    init(sequence: BaseSequence, substractedBy substractor: SubstractSequence) {
        self.substractor = substractor
        super.init(sequence: sequence)
    }
    
    override func nextIfAppearsInSubstractor(for element: Element) -> Bool {
        substractor.contains(element)
    }
}

// MARK: SubstractedHashableSequenceIterator

class SubstractedHashableSequenceIterator<BaseSequence: Sequence, SubstractSequence: Sequence>: SubstractedSequenceIterator<BaseSequence, SubstractSequence>
where BaseSequence.Element: Hashable,
      SubstractSequence.Element == BaseSequence.Element {
    
    typealias SubstractIterator = SubstractSequence.Iterator
    
    var substractIterator: SubstractIterator
    var populated: [Element: Void] = [:]
    
    init(sequence: BaseSequence, substractedBy substractor: SubstractSequence) {
        self.substractIterator = substractor.makeIterator()
        super.init(sequence: sequence)
    }
    
    override func nextIfAppearsInSubstractor(for element: Element) -> Bool {
        guard populated[element] == nil else {
            return true
        }
        while let next = substractIterator.next() {
            populated[next] = ()
            if next == element {
                return true
            }
        }
        return false
    }
}

// MARK: SubstractedProjectionSequenceIterator

class SubstractedProjectionSequenceIterator<BaseSequence: Sequence, SubstractSequence: Sequence, Projection: Hashable>: SubstractedSequenceIterator<BaseSequence, SubstractSequence>
where SubstractSequence.Element == BaseSequence.Element {
    
    typealias SubstractIterator = SubstractSequence.Iterator
    typealias HashProjection = (Element) -> Projection
    
    var substractIterator: SubstractIterator
    var populated: [Projection: Void] = [:]
    let hashProjection: HashProjection
    
    init(sequence: BaseSequence, substractedBy substractor: SubstractSequence, projection: @escaping HashProjection) {
        self.hashProjection = projection
        self.substractIterator = substractor.makeIterator()
        super.init(sequence: sequence)
    }
    
    override func nextIfAppearsInSubstractor(for element: SubstractedSequenceIterator<BaseSequence, SubstractSequence>.Element) -> Bool {
        let projection = hashProjection(element)
        guard populated[projection] == nil else {
            return true
        }
        while let next = substractIterator.next() {
            let nextProjection = hashProjection(next)
            populated[nextProjection] = ()
            if nextProjection == projection {
                return true
            }
        }
        return false
    }
}
