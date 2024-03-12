//
//  206_反转链表.swift
//  Algorithms
//
//  Created by sheng on 2022/9/20.
//

import Foundation

// https://leetcode.cn/problems/reverse-linked-list/

// 相同题目
// https://leetcode.cn/problems/fan-zhuan-lian-biao-lcof/

class ReverseLinkedList {
    func reverseList(_ head: ListNode?) -> ListNode? {
        var oldHead = head
        var newHead: ListNode? = nil
        while oldHead != nil {
            let tmp = oldHead?.next
            oldHead?.next = newHead
            newHead = oldHead
            oldHead = tmp
        }
        return newHead
    }
}
