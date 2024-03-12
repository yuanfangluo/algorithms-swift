//
//  单链表的中点.swift
//  Algorithms
//
//  Created by sheng on 2022/10/28.
//

import Foundation

class MiddleInList {
    func middle(_ head: ListNode?) -> ListNode? {
        
        var slow = head
        var fast = head
        
        while fast != nil && fast?.next != nil {
            slow = slow?.next
            fast = fast?.next?.next
        }
        
        return slow
    }
}
