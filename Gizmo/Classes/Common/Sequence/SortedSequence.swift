//
//  SortedSequence.swift
//  Gizmo
//
//  Created by Nayanda Haberty on 03/09/22.
//

import Foundation

// MARK: Sequence + Extensions

public extension Sequence {
    /// Create a new SequenceWrapper that will iterate this sequence ordered using a given Closure
    /// - Complexity: O(1) on creation and O (*n* log *n*) when iterating, where *n* is the original sequence iterator iteration count
    /// - Parameter areInIncreasingOrder: A predicate that returns `true` if its first argument should be ordered before its second argument, otherwise, `false`.
    /// - Returns: SequenceWrapper that will iterate this sequence ordered using a given Closure
    func sortedSequence(_ areInIncreasingOrder: @escaping (Element, Element) -> Bool) -> SequenceWrapper<Element> {
        SequenceWrapper(iterator: SortedSequenceIterator(sequence: self, comparator: areInIncreasingOrder))
    }
}

// MARK: Comparable Sequence + Extensions

public extension Sequence where Element: Comparable {
    /// Create a new SequenceWrapper that will iterate this sequence ordered using Comparable
    /// - Complexity: O(1) on creation and O (*n* log *n*) when iterating, where *n* is the original sequence iterator iteration count
    /// - Returns: SequenceWrapper that will iterate this sequence ordered using Comparable
    @inlinable func sortedSequence() -> SequenceWrapper<Element> {
        sortedSequence(<=)
    }
}

// MARK: SortedSequenceIterator

class SortedSequenceIterator<BaseSequence: Sequence>: SequenceWrapperIterator<BaseSequence.Element> {
    typealias Comparator = (Element, Element) -> Bool
    typealias Node = DoublyLinkedList<Element>.Node
    
    var started: Bool = false
    let baseSequence: BaseSequence
    let linkedList: DoublyLinkedList<Element> = []
    let comparator: Comparator
    
    init(sequence: BaseSequence, comparator: @escaping Comparator) {
        self.baseSequence = sequence
        self.comparator = comparator
    }
    
    override func next() -> BaseSequence.Element? {
        defer { started = true }
        return started ? nextFromLinkedList(): nextFromSequence()
    }
    
    private func nextFromSequence() -> BaseSequence.Element? {
        let found: Element? = baseSequence.reduce(nil) { partialResult, element in
            guard let smallest = partialResult else { return element }
            if comparator(smallest, element) {
                linkedList.append(element)
                return smallest
            } else {
                linkedList.append(smallest)
                return element
            }
        }
        guard let found = found else { return nil }
        return found
    }
    
    private func nextFromLinkedList() -> BaseSequence.Element? {
        let found: Node? = linkedList.nodeSequence().reduce(nil) { partialResult, node in
            guard let smallest = partialResult else { return node }
            return comparator(smallest.element, node.element) ? smallest : node
        }
        guard let found = found else { return nil }
        linkedList.remove(node: found)
        return found.element
    }
}
