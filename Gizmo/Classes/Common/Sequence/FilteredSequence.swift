//
//  FilteredCollection.swift
//  Gizmo
//
//  Created by Nayanda Haberty on 31/8/22.
//

import Foundation

// MARK: Sequence + Extensions

public extension Sequence {
    
    /// Create a sequence wrapper that will filter each element during iterator iteration.
    /// Since it will only map when in iteration, the time complexity for the creation of this sequence is O(1) and the iteration time complexity will be the same as the original sequence iteration.
    /// ```
    /// // this operation below will have overall time complexity around O(n + m)
    /// // filter itself have time complexity O(n)
    /// // The forEach iteration will have time complexity of O(m) where m is length of filtered array.
    /// // So then overall time complexity will be O(n) + O(m) which is O(n + m)
    /// myArray.filter { shouldInclude($0) }.forEach {
    ///     print($0)
    /// }
    ///
    /// // this operation below will have time complexity around O(n) since it will do the filter operation in the iteration itself
    /// myArray.filtered { shouldInclude($0) }.forEach {
    ///     print($0)
    /// }
    /// ```
    /// - Complexity: Executing this code will have complexity of O(1). Iterating it will have complexity of O(*n*) where *n* is the length of original sequence
    /// - Parameter shouldInclude: A closure that takes an element of the sequence as its argument and returns a Boolean value indicating whether the element should be included in the iteration.
    /// - Returns: SequenceWrapper that will run the filtering during its iterator iteration
    func filtered(_ shouldInclude: @escaping (Element) -> Bool) -> SequenceWrapper<Element> {
        SequenceWrapper(iterator: FilteredSequenceIterator(sequence: self, filter: shouldInclude))
    }
}

// MARK: FilteredSequenceIterator

class FilteredSequenceIterator<BaseSequence: Sequence>: SequenceWrapperIterator<BaseSequence.Element> {
    typealias Filter = (Element) -> Bool
    typealias BaseIterator = BaseSequence.Iterator
    
    var iterator: BaseIterator
    let filter: Filter
    
    init(sequence: BaseSequence, filter: @escaping Filter) {
        iterator = sequence.makeIterator()
        self.filter = filter
    }
    
    override func next() -> Element? {
        guard let nextIteration = iterator.next() else {
            return nil
        }
        return filter(nextIteration) ? nextIteration : next()
    }
}
