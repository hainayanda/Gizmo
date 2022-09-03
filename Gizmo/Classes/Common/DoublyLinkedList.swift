//
//  DoublyLinkedList.swift
//  Gizmo
//
//  Created by Nayanda Haberty on 03/09/22.
//

import Foundation

// MARK: DoublyLinkedList

/// <#Description#>
final public class DoublyLinkedList<Element> {
    private var root: Node?
    private var tail: Node?
    private var populated: [Node: Void] = [:]
    
    /// <#Description#>
    @inlinable public var first: Element? { firstNode?.element }
    
    /// <#Description#>
    @inlinable public var last: Element? { lastNode?.element }
    
    /// <#Description#>
    public var firstNode: Node? { root }
    
    /// <#Description#>
    public var lastNode: Node? { tail }
    
    /// <#Description#>
    public var count: Int { populated.count }
    
    public init<S>(_ sequence: S) where S : Sequence, Element == S.Element {
        append(contentsOf: sequence)
    }
    
    public init() { }
    
    /// <#Description#>
    /// - Parameter index: <#index description#>
    /// - Returns: <#description#>
    public func node(at index: Int) -> Node? {
        if index < 0 || index > count { return nil }
        let reverseIndex = count - index - 1
        return index < reverseIndex ? root?.nextNode(for: index) : tail?.previousNode(for: reverseIndex)
    }
    
    /// <#Description#>
    /// - Parameter node: <#node description#>
    /// - Returns: <#description#>
    public func contains(node: Node) -> Bool {
        populated[node] != nil
    }
    
    /// <#Description#>
    /// - Parameter node: <#node description#>
    public func append(node: Node) {
        if contains(node: node) {
            naiveRemove(node: node)
        }
        naiveAppend(node: node)
    }
    
    /// <#Description#>
    /// - Parameter newElement: <#newElement description#>
    public func append(_ newElement: Element) {
        naiveAppend(node: Node(element: newElement))
    }
    
    /// <#Description#>
    /// - Parameter newElements: <#newElements description#>
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
    
    /// <#Description#>
    /// - Parameters:
    ///   - node: <#node description#>
    ///   - index: <#index description#>
    public func insert(node: Node, at index: Int) {
        if contains(node: node) {
            naiveRemove(node: node)
        }
        guard index < count else {
            naiveAppend(node: node)
            return
        }
        let nodeAtIndex = self.node(at: index)
        nodeAtIndex?.previous?.next = node
        node.previous = nodeAtIndex?.previous
        nodeAtIndex?.previous = node
        node.next = nodeAtIndex
        populated[node] = ()
    }
    
    /// <#Description#>
    /// - Parameters:
    ///   - newElement: <#newElement description#>
    ///   - index: <#index description#>
    public func insert(_ newElement: Element, at index: Int) {
        insert(node: Node(element: newElement), at: index)
    }
    
    /// <#Description#>
    /// - Parameters:
    ///   - newElements: <#newElements description#>
    ///   - index: <#index description#>
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
    /// <#Description#>
    /// - Parameter node: <#node description#>
    /// - Returns: <#description#>
    public func remove(node: Node) -> Bool {
        guard contains(node: node) else {
            return false
        }
        naiveRemove(node: node)
        return true
    }
    
    @discardableResult
    /// <#Description#>
    /// - Parameter position: <#position description#>
    /// - Returns: <#description#>
    public func remove(at position: Int) -> Element? {
        guard let node = self.node(at: position) else {
            return nil
        }
        naiveRemove(node: node)
        return node.element
    }
    
    @discardableResult
    /// <#Description#>
    /// - Returns: <#description#>
    public func removeFirst() -> Element? {
        guard let node = firstNode else { return nil }
        naiveRemove(node: node)
        return node.element
    }
    
    @discardableResult
    /// <#Description#>
    /// - Returns: <#description#>
    public func removeLast() -> Element? {
        guard let node = lastNode else { return nil }
        naiveRemove(node: node)
        return node.element
    }
    
    /// <#Description#>
    /// - Parameter shouldBeRemoved: <#shouldBeRemoved description#>
    public func removeAll(where shouldBeRemoved: (Element) throws -> Bool) rethrows {
        try populated.keys.forEach {
            guard try shouldBeRemoved($0.element) else { return }
            naiveRemove(node: $0)
        }
    }
    
    /// <#Description#>
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
    /// <#Description#>
    public class Node {
        /// <#Description#>
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
    
    /// <#Description#>
    /// - Returns: <#description#>
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
