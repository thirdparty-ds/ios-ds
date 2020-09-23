//
//  Queue.swift
//  ios-ds
//
//  Created by Vasista Vovveti on 9/23/20.
//

import Foundation

class Queue<T> {
    private var linkedList: LinkedList<T>
    
    init() {
        linkedList = LinkedList<T>()
    }
    
    var count: Int {
        linkedList.count
    }
    
    var isEmpty: Bool {
        linkedList.isEmpty
    }
    
    func enqueue(_ value: T) {
        linkedList.append(value)
    }
    
    func dequeue() -> T? {
        linkedList.popFirst()
    }
    
    func dequeueToArray() -> [T] {
        var array: [T] = []
        while let value = linkedList.popLast() {
            array.append(value)
        }
        return array
    }
    
}
