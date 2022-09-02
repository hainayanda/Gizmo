//
//  SequenceCombination.swift
//  Gizmo
//
//  Created by Nayanda Haberty on 31/8/22.
//

import Foundation

// MARK: Sequence + Extensions

public extension Sequence {
    
    /// Simply just shortcut to `combined(with: otherSequence).asArray`
    /// Just use this if the array result is final.
    /// If more sequences is needed, better use the *combinedSequence* method to reduce the time complexity.
    /// ```
    /// // this will have time complexity O(4j + 4k + 3l + 2m + n)
    /// let array = j.combinedToArray(with: k).combinedToArray(with: l).combinedToArray(with: m).combinedToArray(with: n)
    ///
    /// // this will have time complexity O(1)
    /// let sequence = j.combined(with: k).combined(with: l).combined(with: m).combined(with: n)
    /// // this will have time complexity O(j + k + l + m + n)
    /// let arrayCombined = Array(sequence)
    /// // this iteration will have time complexity O(j + k + l + m + n) too without creating a new array
    /// sequence.forEach { print($0) }
    /// ```
    /// - Complexity: O(*n* + *m*) where *n* is the length of original sequence, and *m* is the length of added sequence
    /// - Parameter otherSequence: Other sequence to be combined into one Array
    /// - Returns: New array containing all elements from combined sequences
    @inlinable func combinedToArray<S: Sequence>(with otherSequence: S) -> [Element]
    where S.Element == Element {
        combined(with: otherSequence).asArray
    }
    
    /// Create a combined sequence from two sequence.
    /// It will not recreate a new storage to store all elements, but simply just iterator factory for iterator that will iterate all of the element from the first sequence to the second sequence.
    /// This will reduce the time complexity needed to perform such actions especially if dealing with combining a lot of sequence
    /// ```
    /// // this will have time complexity O(4j + 4k + 3l + 2m + n)
    /// let array = j.combinedToArray(with: k).combinedToArray(with: l).combinedToArray(with: m).combinedToArray(with: n)
    ///
    /// // this will have time complexity O(1)
    /// let sequence = j.combined(with: k).combined(with: l).combined(with: m).combined(with: n)
    /// // this will have time complexity O(j + k + l + m + n)
    /// let arrayCombined = Array(sequence)
    /// // this iteration will have time complexity O(j + k + l + m + n) too without creating a new array
    /// sequence.forEach { print($0) }
    /// ```
    /// - Complexity: Executing this code will have complexity of O(1). Iterating it will have complexity of O(*n* + *m*) where *n* is the length of original sequence, and *m* is the length of added sequence
    /// - Parameter otherSequence: Other sequence to be combined into one sequence
    /// - Returns: SequenceWrapper that will run both of sequences iterator iteration sequentially
    func combined<S: Sequence>(with otherSequence: S) -> SequenceWrapper<Element>
    where S.Element == Element {
        SequenceWrapper(iterator: AddedSequenceIterator(sequence: self, secondarySequence: otherSequence))
    }
}

// MARK: AddedSequenceIterator

class AddedSequenceIterator<BaseSequence: Sequence, AddedSequence: Sequence>: SequenceWrapperIterator<BaseSequence.Element>
where AddedSequence.Element == BaseSequence.Element {
    var firstIterator: BaseSequence.Iterator
    var secondIterator: AddedSequence.Iterator
    
    init(sequence: BaseSequence, secondarySequence: AddedSequence) {
        self.firstIterator = sequence.makeIterator()
        self.secondIterator = secondarySequence.makeIterator()
    }
    
    override func next() -> Element? {
        firstIterator.next() ?? secondIterator.next()
    }
}