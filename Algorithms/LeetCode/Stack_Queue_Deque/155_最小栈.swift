//
//  155_最小栈.swift
//  Algorithms
//
//  Created by sheng on 2022/9/20.
//

import Foundation
// https://leetcode.cn/problems/min-stack/
// https://leetcode.cn/problems/min-stack-lcci/

// 使用两个栈

class MinStack {
    
    var stack: [Int] = []
    var minStack: [Int] = []
    
    init() {

    }
    
    func push(_ val: Int) {
        stack.append(val)
        if minStack.isEmpty {
            minStack.append(val)
        } else {
            minStack.append(min(val, minStack.last!))
        }
    }

    func pop() {
        if let _ = stack.popLast() {
            
        }
        
        if let _ = minStack.popLast() {
            
        }
    }
    
    func top() -> Int {
        stack.last!
    }
    
    func getMin() -> Int {
        minStack.last!
    }
}

// 链表
class MinStack2 {
    
    var head: Node

    init() {
        head = Node(val: 0, min: Int.max)
    }
    
    func push(_ val: Int) {
        head = Node(val: val, min: min(val, head.min), next: head)
    }
    
    func pop() {
        if head.next != nil {
            head = head.next!
        }
    }
    
    func top() -> Int {
        head.val
    }
    
    func getMin() -> Int {
        head.min
    }
    
    class Node {
        var val: Int
        var min: Int
        var next: Node?
        init(val: Int, min: Int, next: Node? = nil) {
            self.val = val
            self.min = min
            self.next = next
        }
    }
}
