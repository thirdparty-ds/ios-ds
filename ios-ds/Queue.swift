//
//  Queue.swift
//  ios-ds
//
//  Created by Vasista Vovveti on 9/23/20.
//

import Foundation

class Queue<T> : LinkedList<T> {
    
    func enqueue(_ value: T) {
        self.append(value)
    }
    
    func dequeue() -> T? {
        self.popFirst()
    }
    
    func dequeueToArray() -> [T] {
        var array: [T] = []
        while let value = self.popLast() {
            array.append(value)
        }
        return array
    }
    
}
