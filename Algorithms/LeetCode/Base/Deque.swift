//
//  Deque.swift
//  Algorithms
//
//  Created by sheng on 2022/11/3.
//

import Foundation

// 双端队列
class Deque<E>: Queue<E> {
    
    func enqueueFirst(_ element: E) {
        elements.insert(element, at: 0)
    }
    
    func dequeueLast() -> E? {
        if isEmpty {
            return nil
        } else {
            return elements.removeLast()
        }
    }
}
