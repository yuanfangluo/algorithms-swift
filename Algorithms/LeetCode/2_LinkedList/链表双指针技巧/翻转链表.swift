//
//  翻转链表.swift
//  Algorithms
//
//  Created by sheng on 2022/10/29.
//

import Foundation

class ReverseList {
    func reverseList(_ head: ListNode?) -> ListNode? {
        var oldHead = head
        var newHead: ListNode? = nil
        while oldHead != nil {
            let tmp = oldHead?.next
            oldHead?.next = newHead
            newHead = oldHead
            oldHead = tmp
        }
        return  newHead
    }
}
