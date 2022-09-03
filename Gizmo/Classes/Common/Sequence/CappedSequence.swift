//
//  CappedSequence.swift
//  Gizmo
//
//  Created by Nayanda Haberty on 03/09/22.
//

import Foundation

// MARK: Sequence + Extensions

public extension Sequence {
    
    /// Capped the sequence iteration to a given maximum iteration count
    /// This will create a new SequenceWrapper that will only iterate the original sequence maximum at a given maximum iteration count
    /// - Complexity: O(1) on creation, when iterating O (*n*) at if iteration count is less than given maximum iteration and O (*m*) if iteration count is more than given maximum iteration, where *n* is the original sequence iterator iteration count, and *m* is given maximum iteration count
    /// - Parameter maxIteration: Number of maximum iteration that will be performed by returned sequence
    /// - Returns: SequenceWrapper that will only do iterating until given maximum iteration count or until iteration is finished
    @inlinable func capped(atMaxIteration count: Int) -> SequenceWrapper<Element> {
        capped { index, _ in
            index >= count
        }
    }
    
    /// Capped the sequence iteration until certain condition is met
    /// This will create a new SequenceWrapper that will only iterate the original sequence until certain condition is met or until iteration is finished
    /// - Complexity: O (*n*) at maximum and O (*m*) at minimum, where *n* is the original sequence iterator iteration count, and *m* is iteration count until condition is met
    /// - Parameter untilFound: Closure that accept index and element for each iteration and return Bool that indicate the iteration must stop
    /// - Returns: SequenceWrapper that will only do iterating until certain condition is met or until iteration is finished
    func capped(untilFound: @escaping (Int, Element) -> Bool) -> SequenceWrapper<Element> {
        SequenceWrapper(iterator: CappedSequenceIteratorWrapper(iterator: makeIterator(), stopCondition: untilFound))
    }
}

// MARK: CappedSequenceIteratorWrapper

class CappedSequenceIteratorWrapper<Wrapped: IteratorProtocol>: SequenceWrapperIterator<Wrapped.Element> {
    let stopCondition: (Int, Element) -> Bool
    var shouldStop: Bool = false
    var iteration: Int = 0
    var iterator: Wrapped
    
    init(iterator: Wrapped, stopCondition: @escaping (Int, Element) -> Bool) {
        self.stopCondition = stopCondition
        self.iterator = iterator
    }
    
    override func next() -> Element? {
        guard !shouldStop else { return nil }
        defer { iteration += 1 }
        guard let next = iterator.next() else {
            shouldStop = true
            return nil
        }
        shouldStop = stopCondition(iteration, next)
        return next
    }
}
