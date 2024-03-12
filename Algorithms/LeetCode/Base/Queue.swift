//
//  Queue.swift
//  Algorithms
//
//  Created by sheng on 2022/10/24.
//

import Foundation

class Queue<E> {
    
    var isEmpty: Bool {
        elements.isEmpty
    }
    
    var count: Int {
      return elements.count
    }
    
    var elements: [E] = []
    
    // 入队
    func enqueue(_ e: E) {
        elements.append(e)
    }
    
    // 出队
    func dequeue() -> E? {
        elements.removeFirst()
    }
    
    // 队头
    var head: E? {
        elements.first
    }
    
    // 队尾
    var tail: E? {
        elements.last
    }
    
}

