//
//  LinkedList.swift
//  ios-ds
//
//  Created by Vasista Vovveti on 9/23/20.
//

import Foundation

public class LinkedListNode<T> {
    var value: T
    var next: LinkedListNode?
    weak var prev: LinkedListNode?
    
    public init(_ value: T) {
        self.value = value
    }
}

class LinkedList<T> {

    
    internal var head: LinkedListNode<T>?
    internal var tail: LinkedListNode<T>?
    internal var _count: Int = 0
    
    var isEmpty: Bool {
        _count == 0
        // head == nil
    }
    
    var count: Int {
        _count
    }

    var first: T? {
        head?.value
    }
    
    var last: T? {
        tail?.value ?? first
    }
    
    func append(_ value: T) {
        let node = LinkedListNode(value)
        
        tail?.next = node
        node.prev = tail
        tail = node
    
        if head == nil {
            head = node
        }
        
        _count += 1
    }
    
    func insert(_ value: T, at: Int) {

        if at == count {
            append(value)
            return
        }
        
        if at == 0 {
            let node = LinkedListNode(value)
            node.next = head
            head?.prev = node
            head = node
            _count += 1
            return
        }
        
        if at < count {
            var curr = head
            
            for _ in 1..<at {
                curr = curr?.next
            }
            
            let node = LinkedListNode(value)
            node.next = curr?.next
            curr?.next?.prev = node
            curr?.next = node
            node.prev = curr
            _count += 1
            
        }
    }
    
    
    func popFirst() -> T? {
        let v = head?.value
        head = head?.next
        head?.prev = nil
        _count -= 1
        
        return v
    }
    
    func popLast() -> T? {
        let v = tail?.value
        tail = tail?.prev
        tail?.next = nil
        _count -= 1
        
        return v
    }
    
    func removeFirst() {
        _ = popFirst()
    }
    
    func removeLast() {
        _ = popLast()
    }
    

    
}

extension LinkedList : Sequence {
    func makeIterator() -> LinkedListIterator<T> {
        return LinkedListIterator(self)
    }
}

extension LinkedList: Collection {
    typealias Index = Int
    var startIndex: Int {
        0
    }
    
    var endIndex: Int {
        self.count
    }
    
    func index(after i: Int) -> Int {
        i + 1
    }
    
    subscript(position: Int) -> T {
        var curr = head
        
        for _ in 0..<position {
            curr = curr!.next
        }
        
        return curr!.value
        
    }
    
}

extension LinkedList: BidirectionalCollection {
    func index(before i: Int) -> Int {
        i - 1
    }
}

extension LinkedList: RandomAccessCollection {
    
}

extension LinkedList: Equatable {
    static func == (lhs: LinkedList<T>, rhs: LinkedList<T>) -> Bool {
        lhs === rhs &&
        lhs.head === rhs.head &&
        lhs.tail === rhs.tail &&
        lhs.count == rhs.count
    }
}

struct LinkedListIterator<T>: IteratorProtocol {
    var curr_node: LinkedListNode<T>?
    
    init(_ linkedList: LinkedList<T>) {
        curr_node = linkedList.head
    }
    
    mutating func next() -> T? {
        defer { curr_node = curr_node?.next }
        return curr_node?.value
    }
    
}
