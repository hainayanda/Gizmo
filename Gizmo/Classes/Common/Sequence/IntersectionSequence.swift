//
//  IntersectionSequence.swift
//  Gizmo
//
//  Created by Nayanda Haberty on 1/9/22.
//

import Foundation

// MARK: Sequence + Extensions

public extension Sequence  {
    
    /// Simply just shortcut to `intersectioned(with: otherSequence, projection).asArray`
    /// Keep in mind this will automatically run the iterator iteration when creating an new Array.
    /// If you just need to iterate the element uniquely, consider using `intersectioned` instead
    /// ```
    /// // this will have time complexity O(k + l + m) where k is myArray length, l is otherArray length and m is intersection array length
    /// myArray.intersection(with: otherArray) { projecting($0) }.forEach {
    ///     print($0)
    /// }
    ///
    /// // this will have time complexity O(k + l) since the intersection check will be executed while iterating forEach
    /// myArray.intersectioned(with: otherArray) { projecting($0) }.forEach {
    ///     print($0)
    /// }
    /// ```
    /// - Complexity: O(*n* + *m*) on average, where *n* is the original sequence iterator iteration count, and *m* is the intersecting sequence iterator iteration count
    /// - Parameters:
    ///   - otherSequence: A sequence to intersect with this sequence
    ///   - projection: A closure that accepts an element of this sequence as its argument and returns an hashable value.
    /// - Returns: Array of element intersecting with this sequence and given sequence
    @inlinable func intersection<S: Sequence, Projection: Hashable>(
        with otherSequence: S,
        _ projection: @escaping (Element) -> Projection) -> [Element]
    where S.Element == Element {
        intersectioned(with: otherSequence, projection).asArray
    }
    
    /// Create a sequence wrapper that will only iterate elements intersecting between two sequence
    /// Since it will only check intersecting elements when in iteration, the time complexity for the creation of this sequence is O(1)
    /// - Complexity: Executing this code will have complexity of O(1). Iterating it will have average complexity of O(*n* + *m*) where *n* is the original sequence iterator iteration count, and *m* is the intersecting sequence iterator iteration count
    /// - Parameters:
    ///   - otherSequence: A sequence to intersect with this sequence
    ///   - projection: A closure that accepts an element of this sequence as its argument and returns an hashable value.
    /// - Returns: SequenceWrapper that will check intersecting element during its iterator iteration
    func intersectioned<S: Sequence,  Projection: Hashable>(
        with otherSequence: S,
        _ projection: @escaping (Element) -> Projection) -> SequenceWrapper<Element>
    where S.Element == Element {
        SequenceWrapper(
            iterator: IntersectionProjectionSequenceIterator(
                sequence: self,
                intersectedBy: otherSequence,
                projection: projection
            )
        )
    }
}

// MARK: Equatable Sequence + Extensions

public extension Sequence where Element: Equatable {
    
    /// Simply just shortcut to `intersectioned(with: otherSequence).asArray`
    /// Keep in mind this will automatically run the iterator iteration when creating an new Array.
    /// If you just need to iterate the element uniquely, consider using `intersectioned` instead
    /// ```
    /// // this will have time complexity O((k * l) + m) where k is myArray length, l is otherArray length and m is intersection array length
    /// myArray.intersection(with: otherArray).forEach {
    ///     print($0)
    /// }
    ///
    /// // this will have time complexity O(k * l) since the intersection check will be executed while iterating forEach
    /// myArray.intersectioned(with: otherArray).forEach {
    ///     print($0)
    /// }
    /// ```
    /// - Complexity: O(*n* *m*) on average, where *n* is the original sequence iterator iteration count, and *m* is the intersecting sequence iterator iteration count
    /// - Parameter otherSequence: A sequence to intersect with this sequence
    /// - Returns: Array of element intersecting with this sequence and given sequence
    @inlinable func intersection<S: Sequence>(with otherSequence: S) -> [Element]
    where S.Element == Element {
        intersectioned(with: otherSequence).asArray
    }
    
    /// Create a sequence wrapper that will only iterate elements intersecting between two sequence
    /// Since it will only check intersecting elements when in iteration, the time complexity for the creation of this sequence is O(1)
    /// - Complexity: Executing this code will have complexity of O(1). Iterating it will have average complexity of O(*n* *m*) where *n* is the original sequence iterator iteration count, and *m* is the intersecting sequence iterator iteration count
    /// - Parameter otherSequence: A sequence to intersect with this sequence
    /// - Returns: SequenceWrapper that will check intersecting element during its iterator iteration
    func intersectioned<S: Sequence>(with otherSequence: S) -> SequenceWrapper<Element>
    where S.Element == Element {
        SequenceWrapper(iterator: IntersectionEquatableSequenceIterator(sequence: self, intersectedBy: otherSequence))
    }
}

// MARK: Hashable Sequence + Extensions

public extension Sequence where Element: Hashable {
    
    /// Simply just shortcut to `intersectioned(with: otherSequence).asArray`
    /// Keep in mind this will automatically run the iterator iteration when creating an new Array.
    /// If you just need to iterate the element uniquely, consider using `intersectioned` instead
    /// ```
    /// // this will have time complexity O(k + l + m) where k is myArray length, l is otherArray length and m is intersection array length
    /// myArray.intersection(with: otherArray).forEach {
    ///     print($0)
    /// }
    ///
    /// // this will have time complexity O(k + l) since the intersection check will be executed while iterating forEach
    /// myArray.intersectioned(with: otherArray).forEach {
    ///     print($0)
    /// }
    /// ```
    /// - Complexity: O(*n* + *m*) on average, where *n* is the original sequence iterator iteration count, and *m* is the intersecting sequence iterator iteration count
    /// - Parameter otherSequence: A sequence to intersect with this sequence
    /// - Returns: Array of element intersecting with this sequence and given sequence
    @inlinable func intersection<S: Sequence>(with otherSequence: S) -> [Element]
    where S.Element == Element {
        intersectioned(with: otherSequence).asArray
    }
    
    /// Create a sequence wrapper that will only iterate elements intersecting between two sequence
    /// Since it will only check intersecting elements when in iteration, the time complexity for the creation of this sequence is O(1)
    /// - Complexity: Executing this code will have complexity of O(1). Iterating it will have average complexity of O(*n* + *m*) where *n* is the original sequence iterator iteration count, and *m* is the intersecting sequence iterator iteration count
    /// - Parameter otherSequence: A sequence to intersect with this sequence
    /// - Returns: SequenceWrapper that will check intersecting element during its iterator iteration
    func intersectioned<S: Sequence>(with otherSequence: S) -> SequenceWrapper<Element>
    where S.Element == Element {
        SequenceWrapper(iterator: IntersectionHashableSequenceIterator(sequence: self, intersectedBy: otherSequence))
    }
}

// MARK: AnyObject Sequence + Extensions

public extension Sequence where Element: AnyObject {
    
    /// Simply just shortcut to `objectIntersectioned(with: otherSequence).asArray`
    /// Keep in mind this will automatically run the iterator iteration when creating an new Array.
    /// If you just need to iterate the element uniquely, consider using `intersectioned` instead
    /// ```
    /// // this will have time complexity O(k + l + m) where k is myArray length, l is otherArray length and m is intersection array length
    /// myArray.objectsIntersection(with: otherArray).forEach {
    ///     print($0)
    /// }
    ///
    /// // this will have time complexity O(k + l) since the intersection check will be executed while iterating forEach
    /// myArray.objectIntersectioned(with: otherArray).forEach {
    ///     print($0)
    /// }
    /// ```
    /// - Complexity: O(*n* + *m*) on average, where *n* is the original sequence iterator iteration count, and *m* is the intersecting sequence iterator iteration count
    /// - Parameter otherSequence: A sequence to intersect with this sequence
    /// - Returns: Array of objects intersecting with this sequence and given sequence
    @inlinable func objectsIntersection<S: Sequence>(with otherSequence: S) -> [Element]
    where S.Element == Element {
        objectIntersectioned(with: otherSequence).asArray
    }
    
    /// Create a sequence wrapper that will only iterate objects intersecting between two sequence
    /// Since it will only check intersecting objects when in iteration, the time complexity for the creation of this sequence is O(1)
    /// - Complexity: Executing this code will have complexity of O(1). Iterating it will have average complexity of O(*n* + *m*) where *n* is the original sequence iterator iteration count, and *m* is the intersecting sequence iterator iteration count
    /// - Parameter otherSequence: A sequence to intersect with this sequence
    /// - Returns: SequenceWrapper that will check intersecting objects during its iterator iteration
    @inlinable func objectIntersectioned<S: Sequence>(with otherSequence: S) -> SequenceWrapper<Element>
    where S.Element == Element {
        intersectioned(with: otherSequence) { ObjectIdentifier($0) }
    }
}

// MARK: IntersectionSequenceIterator

class IntersectionSequenceIterator<BaseSequence: Sequence, IntersectSequence: Sequence>: SequenceWrapperIterator<BaseSequence.Element>
where IntersectSequence.Element == BaseSequence.Element {
    
    typealias BaseIterator = BaseSequence.Iterator
    
    var iterator: BaseIterator
    
    init(sequence: BaseSequence) {
        self.iterator = sequence.makeIterator()
    }
    
    public override func next() -> Element? {
        guard let nextIteration = iterator.next() else {
            return nil
        }
        guard nextIfNotAppearsInIntersector(for: nextIteration) else {
            return nextIteration
        }
        return next()
    }
    
    func nextIfNotAppearsInIntersector(for element: Element) -> Bool {
        fatalError("this method should be overriden")
    }
}

// MARK: IntersectionEquatableSequenceIterator

class IntersectionEquatableSequenceIterator<BaseSequence: Sequence, IntersectSequence: Sequence>: IntersectionSequenceIterator<BaseSequence, IntersectSequence>
where BaseSequence.Element: Equatable,
      IntersectSequence.Element == BaseSequence.Element {
    
    let intersector: IntersectSequence
    
    init(sequence: BaseSequence, intersectedBy intersector: IntersectSequence) {
        self.intersector = intersector
        super.init(sequence: sequence)
    }
    
    override func nextIfNotAppearsInIntersector(for element: IntersectionSequenceIterator<BaseSequence, IntersectSequence>.Element) -> Bool {
        !intersector.contains(element)
    }
}

// MARK: IntersectionHashableSequenceIterator

class IntersectionHashableSequenceIterator<BaseSequence: Sequence, IntersectSequence: Sequence>: IntersectionSequenceIterator<BaseSequence, IntersectSequence>
where BaseSequence.Element: Hashable,
        IntersectSequence.Element == BaseSequence.Element {
    
    typealias IntersectIterator = IntersectSequence.Iterator
    
    var intersectIterator: IntersectIterator
    var populated: [Element: Void] = [:]
    
    init(sequence: BaseSequence, intersectedBy intersector: IntersectSequence) {
        self.intersectIterator = intersector.makeIterator()
        super.init(sequence: sequence)
    }
    
    override func nextIfNotAppearsInIntersector(for element: IntersectionSequenceIterator<BaseSequence, IntersectSequence>.Element) -> Bool {
        guard populated[element] == nil else {
            return false
        }
        while let next = intersectIterator.next() {
            populated[next] = ()
            if next == element {
                return false
            }
        }
        return true
    }
}

// MARK: IntersectionProjectionSequenceIterator

class IntersectionProjectionSequenceIterator<BaseSequence: Sequence, IntersectSequence: Sequence, Projection: Hashable>: IntersectionSequenceIterator<BaseSequence, IntersectSequence>
where IntersectSequence.Element == BaseSequence.Element {
    
    typealias IntersectIterator = IntersectSequence.Iterator
    typealias HashProjection = (Element) -> Projection
    
    var intersectIterator: IntersectIterator
    var populated: [Projection: Void] = [:]
    let hashProjection: HashProjection
    
    init(sequence: BaseSequence, intersectedBy intersector: IntersectSequence, projection: @escaping HashProjection) {
        self.hashProjection = projection
        self.intersectIterator = intersector.makeIterator()
        super.init(sequence: sequence)
    }
    
    override func nextIfNotAppearsInIntersector(for element: Element) -> Bool {
        let projection = hashProjection(element)
        guard populated[projection] == nil else {
            return false
        }
        while let next = intersectIterator.next() {
            let nextProjection = hashProjection(next)
            populated[nextProjection] = ()
            if nextProjection == projection {
                return false
            }
        }
        return true
    }
}
