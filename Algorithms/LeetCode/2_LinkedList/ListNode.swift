//
//  ListNode.swift
//  Algorithms
//
//  Created by sheng on 2022/10/14.
//

import Foundation

class ListNode: CustomDebugStringConvertible {
    var val: Int
    var next: ListNode?
    init() {
        self.val = 0
        self.next = nil
    }
    init(val: Int, next: ListNode? = nil) {
        self.val = val
        self.next = next
    }
    init(_ val: Int) {
        self.val = val
        self.next = nil
    }
    
    var debugDescription: String {
        return "\(val)" + " -> " + (next?.debugDescription ?? "nil")
    }
}

class LinkedList { // 可以有迭代，也可以有递归
    // 迭代
    func traverse1(_ head: ListNode?) {
        var head = head
        while head != nil {
            print(head!.val)
            head = head?.next
        }
    }
    
    // 递归
    func traverse(_ head: ListNode?) {
        if head == nil {
            return
        }
        
        print(head!.val)
        traverse(head?.next)
    }
}
