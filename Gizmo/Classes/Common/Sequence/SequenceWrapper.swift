//
//  SequenceWrapper.swift
//  Gizmo
//
//  Created by Nayanda Haberty on 1/9/22.
//

import Foundation

// MARK: SequenceWrapper

/// SequenceWrapper object to allow custom iterator for iterating the sequence wrapped
open class SequenceWrapper<Element>: Sequence {
    public typealias Iterator = SequenceWrapperIterator<Element>
    
    let iteratorFactory: () -> Iterator
    private var array: [Element]?
    
    /// Simply just a shortcut to `earlyProcess()` which will create a new array if needed or used previously created array if have any
    public var asArray: [Element] {
        array ?? earlyProcess()
    }
    
    public init(iterator: @escaping @autoclosure () -> Iterator) {
        self.iteratorFactory = iterator
    }
    
    public init(iteratorFactory: @escaping @autoclosure () -> Iterator) {
        self.iteratorFactory = iteratorFactory
    }
    
    public func makeIterator() -> Iterator {
        guard let array = array else {
            return iteratorFactory()
        }
        return EarlyProcessSequenceWrapperIterator(advanceIterator: array.makeIterator())
    }
    
    @discardableResult
    /// - Complexity: Executing this code once will have complexity same as its iterating complexity, after that it will always be O(1) because it will then stores the array and reused it
    /// ```
    /// // this will have time complexity O(1)
    /// let compact = myArray.compacted()
    ///
    /// // this will have time complexity O(n) where n is length of myArray
    /// compact.forEach {
    ///     print($0)
    /// }
    ///
    /// // running this over and over will have same time complexity O(n)
    /// compact.forEach {
    ///     print($0)
    /// }
    ///
    /// // this will have time complexity O(n) where n is length of myArray
    /// compact.earlyProcess()
    ///
    /// // this will have time complexity O(m) where m is length of myArray compacted, which is less than n
    /// compact.forEach {
    ///     print($0)
    /// }
    ///
    /// // running this over and over will have same time complexity O(m)
    /// compact.forEach {
    ///     print($0)
    /// }
    ///
    /// // this will have time complexity O(1), since the array already created when calling earlyProcess()
    /// let compactedArray = compact.asArray
    /// ```
    /// Create an internal array that will be used as iterator maker.
    public func earlyProcess() -> [Element] {
        guard let array = array else {
            let newArray = Array(self)
            self.array = newArray
            return newArray
        }
        return array
    }
}

// MARK: SequenceWrapperIterator

/// Compatible Iterator for `SequenceWrapper`
open class SequenceWrapperIterator<Element>: IteratorProtocol {
    
    open func next() -> Element? {
        fatalError("this method should be overriden")
    }
}

// MARK: EarlyProcessSequenceWrapperIterator

class EarlyProcessSequenceWrapperIterator<Element>: SequenceWrapperIterator<Element> {
    var advanceIterator: IndexingIterator<[Element]>
    
    init(advanceIterator: IndexingIterator<[Element]>) {
        self.advanceIterator = advanceIterator
    }
    
    override func next() -> Element? {
        advanceIterator.next()
    }
    
}
