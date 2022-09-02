//
//  UniqueSequence.swift
//  Gizmo
//
//  Created by Nayanda Haberty on 31/8/22.
//

import Foundation

// MARK: Sequence + Extensions

public extension Sequence {
    
    /// Simply just shortcut to `uniqued(projection).asArray`
    /// Keep in mind this will automatically run the iterator iteration when creating an new Array.
    /// If you just need to iterate the element uniquely, consider using `uniqued` instead
    /// ```
    /// // this will have time complexity O(2n)
    /// // O(n) when in uniqueArray and another O(n) when do forEach operation
    /// myArray.uniquedArray { projecting($0) }.forEach {
    ///     print($0)
    /// }
    ///
    /// // this will have time complexity O(n) since the filtering will be executed while iterating forEach
    /// myArray.uniqued { projecting($0) }.forEach {
    ///     print($0)
    /// }
    /// ```
    /// - Complexity: O(*n*) on average, where *n* is the original sequence iterator iteration count
    /// - Parameter projection: A closure that accepts an element of this sequence as its argument and returns an hashable value.
    /// - Returns: New Array with unique element coming from the original sequence with its order
    @inlinable func uniquedArray<Projection: Hashable>(_ projection: @escaping (Element) -> Projection) -> [Element] {
        uniqued(projection).asArray
    }
    
    /// Create a sequence wrapper that will filter out repeating elements during iterator iteration.
    /// Since it will only filtering when in iteration, the time complexity for the creation of this sequence is O(1).
    /// Filtering duplicates will be using a hash, so on average time complexity for iterating this sequence will be around O(n) or on worst case will be O(log n)
    /// - Complexity: Executing this code will have complexity of O(1). Iterating it will have complexity of O(*n*) on average where *n* is the original sequence iterator iteration count
    /// - Parameter projection: A closure that accepts an element of this sequence as its argument and returns an hashable value.
    /// - Returns: SequenceWrapper that will filtering out repeating elements during its iterator iteration
    func uniqued<Projection: Hashable>(_ projection: @escaping (Element) -> Projection) -> SequenceWrapper<Element> {
        SequenceWrapper(iterator: UniqueProjectionSequenceIterator(sequence: self, projection: projection))
    }
}

// MARK: Equatable Sequence + Extensions

public extension Sequence where Element: Equatable {
    
    /// Simply just shortcut to `uniqued.asArray`
    /// Keep in mind this will automatically run the iterator iteration when creating an new Array.
    /// If you just need to iterate the element uniquely, consider using `uniqued` instead
    /// ```
    /// // this will have time complexity O(n^2 + n)
    /// // O(n^2) when in uniquedArray and another O(n) when do forEach operation
    /// myArray.uniquedArray.forEach {
    ///     print($0)
    /// }
    ///
    /// // this will have time complexity O(n^2) since the filtering will be executed while iterating forEach
    /// myArray.uniqued.forEach {
    ///     print($0)
    /// }
    /// ```
    /// - Complexity: O(*n*^2) on average, where *n* is the original sequence iterator iteration count
    @inlinable var uniquedArray: [Element] {
        uniqued.asArray
    }
    
    /// Create a sequence wrapper that will filter out repeating elements during iterator iteration.
    /// Since it will only filtering when in iteration, the time complexity for the creation of this sequence is O(1).
    /// - Complexity: Executing this code will have complexity of O(1). Iterating it will have complexity of O(*n*^2) on average where *n* is the original sequence iterator iteration count
    var uniqued: SequenceWrapper<Element> {
        SequenceWrapper(iterator: UniqueEquatableSequenceIterator(sequence: self))
    }
}

// MARK: Hashable Sequence + Extensions

public extension Sequence where Element: Hashable {
    
    /// Simply just shortcut to `uniqued.asArray`
    /// Keep in mind this will automatically run the iterator iteration when creating an new Array.
    /// If you just need to iterate the element uniquely, consider using `uniqued` instead
    /// ```
    /// // this will have time complexity O(2n)
    /// // O(n) when in uniquedArray and another O(n) when do forEach operation
    /// myArray.uniquedArray.forEach {
    ///     print($0)
    /// }
    ///
    /// // this will have time complexity O(n) since the filtering will be executed while iterating forEach
    /// myArray.uniqued.forEach {
    ///     print($0)
    /// }
    /// ```
    /// - Complexity: O(*n*) on average, where *n* is the original sequence iterator iteration count
    @inlinable var uniquedArray: [Element] {
        uniqued.asArray
    }
    
    /// Create a sequence wrapper that will filter out repeating elements during iterator iteration.
    /// Since it will only filtering when in iteration, the time complexity for the creation of this sequence is O(1).
    /// Filtering duplicates will be using a hash, so on average time complexity for iterating this sequence will be around O(n) or on worst case will be O(log n)
    /// - Complexity: Executing this code will have complexity of O(1). Iterating it will have complexity of O(*n*) on average where *n* is the original sequence iterator iteration count
    var uniqued: SequenceWrapper<Element> {
        SequenceWrapper(iterator: UniqueHashableSequenceIterator(sequence: self))
    }
}

// MARK: AnyObject Sequence + Extensions

public extension Sequence where Element: AnyObject {
    
    /// Simply just shortcut to `uniquedObjects.asArray`
    /// Keep in mind this will automatically run the iterator iteration when creating an new Array.
    /// If you just need to iterate the element uniquely, consider using `uniquedObjects` instead
    /// ```
    /// // this will have time complexity O(2n)
    /// // O(n) when in uniquedObjectsArray and another O(n) when do forEach operation
    /// myArray.uniquedObjectsArray.forEach {
    ///     print($0)
    /// }
    ///
    /// // this will have time complexity O(n) since the filtering will be executed while iterating forEach
    /// myArray.uniquedObjects.forEach {
    ///     print($0)
    /// }
    /// ```
    /// - Complexity: O(*n*) on average, where *n* is the original sequence iterator iteration count
    @inlinable var uniquedObjectsArray: [Element] {
        uniquedObjects.asArray
    }
    
    /// Create a sequence wrapper that will filter out repeating elements during iterator iteration.
    /// Since it will only filtering when in iteration, the time complexity for the creation of this sequence is O(1).
    /// Filtering duplicates will be using a hash, so on average time complexity for iterating this sequence will be around O(n) or on worst case will be O(log n)
    /// - Complexity: Executing this code will have complexity of O(1). Iterating it will have complexity of O(*n*) on average where *n* is the original sequence iterator iteration count
    @inlinable var uniquedObjects: SequenceWrapper<Element> {
        uniqued { ObjectIdentifier($0) }
    }
}

// MARK: UniqueSequenceIterator

class UniqueSequenceIterator<BaseSequence: Sequence>: SequenceWrapperIterator<BaseSequence.Element> {
    
    typealias BaseIterator = BaseSequence.Iterator
    
    var iterator: BaseIterator
    
    init(sequence: BaseSequence) {
        iterator = sequence.makeIterator()
    }
    
    override func next() -> Element? {
        guard let nextIteration = iterator.next() else {
            return nil
        }
        return nextIfRepeated(for: nextIteration) ? next() : nextIteration
    }
    
    func nextIfRepeated(for element: Element) -> Bool {
        fatalError("this method should be overriden")
    }
}

// MARK: UniqueEquatableSequenceIterator

class UniqueEquatableSequenceIterator<BaseSequence: Sequence>: UniqueSequenceIterator<BaseSequence> where BaseSequence.Element: Equatable {
    
    var iterated: [Element] = []
    
    override func nextIfRepeated(for element: UniqueSequenceIterator<BaseSequence>.Element) -> Bool {
        guard !iterated.contains(element) else {
            return true
        }
        iterated.append(element)
        return false
    }
}

// MARK: UniqueHashableSequenceIterator

class UniqueHashableSequenceIterator<BaseSequence: Sequence>: UniqueSequenceIterator<BaseSequence> where BaseSequence.Element: Hashable {
    
    var iterated: [Element: Void] = [:]
    
    override func nextIfRepeated(for element: UniqueSequenceIterator<BaseSequence>.Element) -> Bool {
        guard iterated[element] == nil else {
            return true
        }
        iterated[element] = ()
        return false
    }
}

// MARK: UniqueProjectionSequenceIterator

class UniqueProjectionSequenceIterator<BaseSequence: Sequence, Projection: Hashable>: UniqueSequenceIterator<BaseSequence> {
    
    typealias HashProjection = (Element) -> Projection
    
    let hashProjection: HashProjection
    var iterated: [Projection: Void] = [:]
    
    init(sequence: BaseSequence, projection: @escaping HashProjection) {
        self.hashProjection = projection
        super.init(sequence: sequence)
    }
    
    override func nextIfRepeated(for element: UniqueSequenceIterator<BaseSequence>.Element) -> Bool {
        let identifier = hashProjection(element)
        guard iterated[identifier] == nil else {
            return true
        }
        iterated[identifier] = ()
        return false
    }
}
