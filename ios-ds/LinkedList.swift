//
//  LinkedList.swift
//  ios-ds
//
//  Created by Vasista Vovveti on 9/23/20.
//

import Foundation

public class Node<T> {
    var value: T
    var next: Node?
    weak var prev: Node?
    
    public init(_ value: T) {
        self.value = value
    }
}

public class LinkedList<T> {
    private var head: Node<T>?
    private var tail: Node<T>?
    private var _count: Int = 0
    
    var isEmpty: Bool {
        _count == 0
        // head == nil
    }
    
    var count: Int {
        _count
    }

    var first: Node<T>? {
        head
    }
    
    var last: Node<T>? {
        tail ?? head
    }
    
    func append(_ value: T) {
        let node = Node(value)
        
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
            let node = Node(value)
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
            
            let node = Node(value)
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
        popFirst()
    }
    
    func removeLast() {
        popLast()
    }
    
    
}
