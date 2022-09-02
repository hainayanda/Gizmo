//
//  CompactMappedSequence.swift
//  Gizmo
//
//  Created by Nayanda Haberty on 31/8/22.
//

import Foundation

// MARK: Sequence + Extensions

public extension Sequence {
    
    /// Create a sequence wrapper that will map each element during iterator iteration. It will then ignore error and nil from the iteration.
    /// Since it will only map when in iteration, the time complexity for the creation of this sequence is O(1) and the iteration time complexity will be the same as the original sequence iteration.
    /// ```
    /// // this operation below will have overall time complexity around O(n + 2m)
    /// // compactMap itself have time complexity O(n + m) which caused by mapping iteration and creating an array with sized m
    /// // The forEach iteration will have time complexity of O(m).
    /// // So then overall time complexity will be O(n + m) + O(m) which is O(n + 2m)
    /// myArray.compactMap { transform($0) }.forEach {
    ///     print($0)
    /// }
    ///
    /// // this operation below will have time complexity around O(n) since it will do the transform operation in the iteration itself
    /// myArray.compactMapped { transform($0) }.forEach {
    ///     print($0)
    /// }
    /// ```
    /// - Complexity: Executing this code will have complexity of O(1). Iterating it will have complexity of O(*n*) where *n* number of iteration performed by the original sequence
    /// - Parameter transform: A closure that accepts an element of this sequence as its argument and returns an optional value.
    /// - Returns: SequenceWrapper that will run the transformation during its iterator iteration
    func compactMapped<Mapped>(_ transform: @escaping (Element) throws -> Mapped?) -> SequenceWrapper<Mapped> {
        SequenceWrapper(iterator: CompactMappedSequenceIterator(sequence: self, mapper: transform))
    }
    
    /// Create a sequence wrapper that will map each element during iterator iteration. It will then ignore error from the iteration.
    /// Since it will only map when in iteration, the time complexity for the creation of this sequence is O(1) and the iteration time complexity will be the same as the original sequence iteration.
    /// ```
    /// // this operation below will have overall time complexity around O(n + 2m)
    /// // compactMap itself have time complexity O(n + m) which caused by mapping iteration and creating an array with sized m
    /// // The forEach iteration will have time complexity of O(m).
    /// // So then overall time complexity will be O(n + m) + O(m) which is O(n + 2m)
    /// myArray.map { transform($0) }.forEach {
    ///     print($0)
    /// }
    ///
    /// // this operation below will have time complexity around O(n) since it will do the transform operation in the iteration itself
    /// myArray.mapped { transform($0) }.forEach {
    ///     print($0)
    /// }
    /// ```
    /// - Complexity: Executing this code will have complexity of O(1). Iterating it will have complexity of O(*n*) where *n* number of iteration performed by the original sequence
    /// - Parameter transform: A closure that accepts an element of this sequence as its argument and returns mapped value.
    /// - Returns: SequenceWrapper that will run the transformation during its iterator iteration
    func mapped<Mapped>(_ transform: @escaping (Element) throws -> Mapped) -> SequenceWrapper<Mapped> {
        SequenceWrapper(iterator: MappedSequenceIterator(sequence: self, mapper: transform))
    }
}

public extension Sequence where Element: OptionalElement {
    
    /// Simply just shortcut to `compactMapped { $0 }`
    /// - Complexity: Executing this code will have complexity of O(1). Iterating it will have complexity of O(*n*) where *n* is the original sequence iteration count.
    /// - Returns: SequenceWrapper that will ignore nil during its iterator iteration
    func compacted() -> SequenceWrapper<Element.Wrapped> {
        self.compactMapped { try $0.unwrapped() }
    }
    
    /// Simply just shortcut to to `compacted().asArray`
    var compactArray: [Element.Wrapped] {
        compacted().asArray
    }
}

// MARK: OptionalElement

public protocol OptionalElement {
    associatedtype Wrapped
    
    func unwrapped() throws -> Wrapped
}

extension Optional: OptionalElement {
    public func unwrapped() throws -> Wrapped {
        guard let value = self else {
            throw GizmoError.failToUnwrappingOptional(type: Self.self)
        }
        return value
    }
}

// MARK: MappedSequenceIterator

class MappedSequenceIterator<BaseSequence: Sequence, Mapped>: SequenceWrapperIterator<Mapped> {
    typealias Mapper = (BaseSequence.Element) throws -> Mapped
    typealias BaseIterator = BaseSequence.Iterator
    
    var iterator: BaseIterator
    let mapper: Mapper
    
    init(sequence: BaseSequence, mapper: @escaping Mapper) {
        iterator = sequence.makeIterator()
        self.mapper = mapper
    }
    
    override func next() -> Element? {
        guard let nextIteration = iterator.next() else {
            return nil
        }
        do {
            return try mapper(nextIteration)
        } catch {
            return next()
        }
    }
}

// MARK: CompactMappedSequenceIterator

class CompactMappedSequenceIterator<BaseSequence: Sequence, Mapped>: SequenceWrapperIterator<Mapped> {
    typealias Mapper = (BaseSequence.Element) throws -> Mapped?
    typealias BaseIterator = BaseSequence.Iterator
    
    var iterator: BaseIterator
    let mapper: Mapper
    
    init(sequence: BaseSequence, mapper: @escaping Mapper) {
        iterator = sequence.makeIterator()
        self.mapper = mapper
    }
    
    override func next() -> Element? {
        guard let nextIteration = iterator.next() else {
            return nil
        }
        do {
            return try mapper(nextIteration) ?? next()
        } catch {
            return next()
        }
    }
}
