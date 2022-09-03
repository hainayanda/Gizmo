//
//  DoublyLinkedList.swift
//  Gizmo
//
//  Created by Nayanda Haberty on 03/09/22.
//

import Foundation

// MARK: DoublyLinkedList

/// Doubly Linked List
/// Use this instead of regular array if you need to do many mutable manipulation.
/// This generally will have less time complexity for most of manipulation task
/// Use array instead if you need to do many direct access to the element using index
/// This generally will have more time complexity for most of accessing task
final public class DoublyLinkedList<Element> {
    private var root: Node?
    private var tail: Node?
    private var populated: [Node: Void] = [:]
    
    /// First element in this DoublyLinkedList
    @inlinable public var first: Element? { firstNode?.element }
    
    /// Last element in this DoublyLinkedList
    @inlinable public var last: Element? { lastNode?.element }
    
    /// First node in this DoublyLinkedList
    public var firstNode: Node? { root }
    
    /// Last node in this DoublyLinkedList
    public var lastNode: Node? { tail }
    
    /// Number of element in this DoublyLinkedList
    public var count: Int { populated.count }
    
    public init<S>(_ sequence: S) where S : Sequence, Element == S.Element {
        append(contentsOf: sequence)
    }
    
    public init() { }
    
    /// Get Node at a given index
    /// - Complexity: O (*n*) or O (*m*) which one is less, where *n* is the given index - 1 and *m* is count - index - 1
    /// - Parameter index: Index of Node
    /// - Returns: Node at a given index. `nil` if the index is out of bounds
    public func node(at index: Int) -> Node? {
        if index < 0 || index > count { return nil }
        let reverseIndex = count - index - 1
        return index < reverseIndex ? root?.nextNode(for: index) : tail?.previousNode(for: reverseIndex)
    }
    
    /// Check whether this sequence have a given node or not.
    /// This will use the Node object identifier to search, so it will ignore the element inside the node.
    /// - Complexity: O (1) on average
    /// - Parameter node: Node to search
    /// - Returns: `True` if the node is found and `False` if not
    public func contains(node: Node) -> Bool {
        populated[node] != nil
    }
    
    /// Append a node to this DoublyLinkedList
    /// It will search for the existing Node and move it to the last if found
    /// - Complexity: O (1) on average
    /// - Parameter node: node appended at the last of this sequence
    public func append(node: Node) {
        if contains(node: node) {
            naiveRemove(node: node)
        }
        naiveAppend(node: node)
    }
    
    /// Append a new element to this sequence
    /// - Complexity: O (1)
    /// - Parameter newElement: New element that will be added at the last of this sequence
    public func append(_ newElement: Element) {
        naiveAppend(node: Node(element: newElement))
    }
    
    /// Append a new elements to this sequence
    /// - Complexity: O (*n*) where *n* is the length of new elements
    /// - Parameter newElements: New elements that will be added at the last of this sequence
    public func append<S>(contentsOf newElements: S) where S : Sequence, Element == S.Element {
        guard let nodes = prepareForInsert(contentsOf: newElements) else {
            return
        }
        if root == nil {
            root = nodes.root
            tail = nodes.tail
            return
        }
        self.tail?.next = nodes.root
        nodes.root.previous = self.tail
        self.tail = nodes.tail
    }
    
    /// Inset a node to this DoublyLinkedList
    /// It will search for the existing Node and move it to the given index if found
    /// If the index is same as this sequence count, it will just do append
    /// If the index is out of bounds it throw fatal error
    /// - Complexity: O (1) on average
    /// - Parameters:
    ///   - node: Node inserted
    ///   - index: Index of node
    public func insert(node: Node, at index: Int) {
        if contains(node: node) {
            naiveRemove(node: node)
        }
        guard index == count else {
            naiveAppend(node: node)
            return
        }
        guard index >= 0 && index < count else {
            fatalError("Index should be greater than zero and less than sequence count")
        }
        let nodeAtIndex = self.node(at: index)
        nodeAtIndex?.previous?.next = node
        node.previous = nodeAtIndex?.previous
        nodeAtIndex?.previous = node
        node.next = nodeAtIndex
        populated[node] = ()
    }
    
    /// Inset a new element to this DoublyLinkedList
    /// If the index is same as this sequence count, it will just do append
    /// If the index is out of bounds it throw fatal error
    /// - Complexity: O (1) on average
    /// - Parameters:
    ///   - newElement: New element inserted
    ///   - index: Index of the new element
    public func insert(_ newElement: Element, at index: Int) {
        insert(node: Node(element: newElement), at: index)
    }
    
    /// Inset a new elements to this DoublyLinkedList
    /// If the index is same as this sequence count, it will just do append
    /// If the index is out of bounds it throw fatal error
    /// - Complexity: O (*n*) where *n* is the length of new elements
    /// - Parameters:
    ///   - newElements: New elements inserted
    ///   - index: Index of the new elements
    public func insert<S>(contentsOf newElements: S, at index: Int) where S : Sequence, Element == S.Element {
        guard index < count else {
            append(contentsOf: newElements)
            return
        }
        guard let nodes = prepareForInsert(contentsOf: newElements) else {
            return
        }
        let nodeAtIndex = self.node(at: index)
        nodeAtIndex?.previous?.next = nodes.root
        nodes.root.previous = nodeAtIndex?.previous
        nodeAtIndex?.previous = nodes.tail
        nodes.tail.next = nodeAtIndex
    }
    
    @discardableResult
    /// Remove a node from this sequence
    /// - Complexity: O (1) on average
    /// - Parameter node: Node to be removed
    /// - Returns: `True` if Node is exist in this sequence and removed, otherwise it will return `False`
    public func remove(node: Node) -> Bool {
        guard contains(node: node) else {
            return false
        }
        naiveRemove(node: node)
        return true
    }
    
    @discardableResult
    /// Remove element at a given position
    /// - Complexity: O (*n*) or O (*m*) which one is less, where *n* is the given position - 1 and *m* is count - position - 1
    /// - Parameter position: Position of the element
    /// - Returns: Element removed, it will be nil if the position is out of bounds
    public func remove(at position: Int) -> Element? {
        guard let node = self.node(at: position) else {
            return nil
        }
        naiveRemove(node: node)
        return node.element
    }
    
    @discardableResult
    /// Remove first element from this sequence
    /// - Complexity: O (1) on average
    /// - Returns: Element removed, it will be nil if the sequence is empty
    public func removeFirst() -> Element? {
        guard let node = firstNode else { return nil }
        naiveRemove(node: node)
        return node.element
    }
    
    @discardableResult
    /// Remove last element from this sequence
    /// - Complexity: O (1) on average
    /// - Returns: Element removed, it will be nil if the sequence is empty
    public func removeLast() -> Element? {
        guard let node = lastNode else { return nil }
        naiveRemove(node: node)
        return node.element
    }
    
    /// Remove all element that matched by the given closure
    /// - Complexity: O(*n*), where *n* is the length of this sequence
    /// - Parameter shouldBeRemoved: Array that accept the element and return Bool indicating the element should be removed or not
    public func removeAll(where shouldBeRemoved: (Element) throws -> Bool) rethrows {
        try populated.keys.forEach {
            guard try shouldBeRemoved($0.element) else { return }
            naiveRemove(node: $0)
        }
    }
    
    /// Remove all elements from this sequence
    /// - Complexity: O (1)
    public func removeAll() {
        root = nil
        tail = nil
    }
}

// MARK: DoublyLinkedList Internal

extension DoublyLinkedList {
    
    func naiveAppend(node: Node) {
        defer { populated[node] = () }
        if self.root == nil {
            root = node
            tail = node
            return
        }
        node.previous = tail
        tail?.next = node
        tail = node.mostNext
    }
    
    func naiveRemove(node: Node) {
        defer { populated[node] = nil }
        if root === node {
            let newRoot = node.next
            newRoot?.previous = nil
            root = newRoot
        }
        if tail === node {
            let newTail = node.previous
            newTail?.next = nil
            tail = newTail
        }
        node.previous?.next = node.next
        node.next?.previous = node.previous
    }
    
    func prepareForInsert<S>(contentsOf newElements: S) -> (root: Node, tail: Node)? where S : Sequence, Element == S.Element {
        newElements.reduce(nil) { partialResult, element in
            let node = Node(element: element)
            populated[node] = ()
            guard let nodes = partialResult else { return (node, node) }
            nodes.tail.next = node
            node.previous = nodes.tail
            return (nodes.root, node)
        }
    }
}

// MARK: DoublyLinkedList Node

extension DoublyLinkedList {
    /// Node of DoubleLinkedList
    public class Node {
        /// Element stored in this Node
        public var element: Element
        var previous: Node?
        var next: Node?
        
        init(element: Element, previous: Node? = nil, next: Node? = nil) {
            self.element = element
            self.previous = previous
            self.next = next
        }
    }
}

// MARK: DoublyLinkedList Node Internal

extension DoublyLinkedList.Node {
    
    var mostNext: DoublyLinkedList<Element>.Node {
        next?.mostNext ?? self
    }
    
    var mostPrevious: DoublyLinkedList<Element>.Node {
        previous?.mostPrevious ?? self
    }
    
    func nextNode(for count: Int) -> DoublyLinkedList<Element>.Node? {
        count == 0 ? self: next?.nextNode(for: count - 1)
    }
    
    func previousNode(for count: Int) -> DoublyLinkedList<Element>.Node? {
        count == 0 ? self: previous?.previousNode(for: count - 1)
    }
}

// MARK: DoublyLinkedList Node + Hashable

extension DoublyLinkedList.Node: Hashable {
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(ObjectIdentifier(self))
    }
    
    public static func == (lhs: DoublyLinkedList<Element>.Node, rhs: DoublyLinkedList<Element>.Node) -> Bool {
        ObjectIdentifier(lhs) == ObjectIdentifier(rhs)
    }
}

// MARK: DoublyLinkedList + Sequence

extension DoublyLinkedList: Sequence {
    public typealias Iterator = DoublyLinkedListIterator<Element>
    
    public func makeIterator() -> DoublyLinkedListIterator<Element> {
        DoublyLinkedListIterator(root: root)
    }
    
    /// Create a SequenceWrapper of Node that will iterate the Nodes of this DoublyLinkedList instead of the elements
    /// - Returns: a new SequenceWrapper
    public func nodeSequence() -> SequenceWrapper<Node> {
        let iterator = DoublyLinkedListNodeIterator(root: root)
        return SequenceWrapper(iterator: iterator)
    }
}

// MARK: DoublyLinkedList + Collection

extension DoublyLinkedList: Collection {
    
    public typealias Index = Int
    
    public subscript(position: Int) -> Element {
        get {
            node(at: position)!.element
        }
        set {
            node(at: position)!.element = newValue
        }
    }
    
    public func index(after index: Int) -> Int { index + 1 }
    
    public var startIndex: Int { 0 }
    
    public var endIndex: Int { count }
}

// MARK: DoublyLinkedList + ExpressibleByArrayLiteral

extension DoublyLinkedList: ExpressibleByArrayLiteral {
    public typealias ArrayLiteralElement = Element
    
    public convenience init(arrayLiteral elements: Element...) {
        self.init(elements)
    }
}

// MARK: DoublyLinkedListIterator

public struct DoublyLinkedListIterator<Element>: IteratorProtocol {
    
    private var currentNode: DoublyLinkedList<Element>.Node?
    
    init(root: DoublyLinkedList<Element>.Node?) {
        self.currentNode = root
    }
    
    public mutating func next() -> Element? {
        defer { currentNode = currentNode?.next }
        return currentNode?.element
    }
}

// MARK: DoublyLinkedListNodeIterator

class DoublyLinkedListNodeIterator<Element>: SequenceWrapperIterator<DoublyLinkedList<Element>.Node> {
    
    private var currentNode: DoublyLinkedList<Element>.Node?
    
    init(root: DoublyLinkedList<Element>.Node?) {
        self.currentNode = root
    }
    
    override func next() -> DoublyLinkedList<Element>.Node? {
        defer { currentNode = currentNode?.next }
        return currentNode
    }
}
