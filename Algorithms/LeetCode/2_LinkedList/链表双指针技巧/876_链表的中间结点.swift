//
//  876_链表的中间结点.swift
//  Algorithms
//
//  Created by sheng on 2022/10/28.
//

import Foundation
// https://leetcode.cn/problems/middle-of-the-linked-list/

class MiddleOfList {
    func middleNode(_ head: ListNode?) -> ListNode? {
        var slow = head
        var fast = head
        
        while fast != nil && fast?.next != nil {
            slow = slow?.next
            fast = fast?.next?.next
        }
        
        return slow
    }
}
