//
//  141_环形链表.swift
//  Algorithms
//
//  Created by sheng on 2022/9/20.
//

import Foundation

// https://leetcode.cn/problems/linked-list-cycle/

class LinkedListCycle {
    func hasCycle(_ head: ListNode?) -> Bool {
        
        var slow = head
        var fast = head
        
        while fast != nil && fast?.next != nil {
            slow = slow?.next
            fast = fast?.next?.next
            
            if slow === fast {
                return true
            }
        }
        
        return false
    }
}
