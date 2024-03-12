//
//  234_回文链表.swift
//  Algorithms
//
//  Created by sheng on 2022/9/20.
//

import Foundation

// https://leetcode.cn/problems/palindrome-linked-list/

// 相同题目
// https://leetcode.cn/problems/palindrome-linked-list-lcci/

class PalindromeLinkedList: Runnable {
    func run() {
        let head = ListNode(1)
        head.next = ListNode(2)
        head.next?.next = ListNode(3)
        head.next?.next?.next = ListNode(2)
        head.next?.next?.next?.next = ListNode(1)
        print(head)
        print(isPalindrome(head))
        print(head)
    }
    
    func isPalindrome(_ head: ListNode?) -> Bool {
        // 1. 先找出中间节点
        var slow = head
        var fast = head
        
        while fast != nil && fast?.next != nil {
            slow = slow?.next
            fast = fast?.next?.next
        }
        
        // 如果 fast 指针没有指向 null，说明链表长度为奇数，slow 还要再前进一步
        if fast != nil {
            slow = slow?.next
        }
        
        // 2. 翻转中间节点后的链表
        var left = head
        var right = reverseList(slow)
        
        while right != nil {
            if left!.val != right!.val {
                return false
            }
            left = left?.next
            right = right?.next
        }
        
        // 这里代表右边指向空了
        #warning("根据题目要求是否要恢复链表")
        return true
    }
    
    
    func isPalindrome2(_ head: ListNode?) -> Bool {
        if head == nil || head?.next == nil {
            return true
        }
        
        if head?.next?.next == nil {
            return head?.val == head?.next?.val
        }
        
        // 求出中间节点
        let mid = middleNode(head)
        var rHead = reverseList(mid?.next)
        var lHead = head
        let rOldHead = rHead
        var result = true
        while rHead != nil {
            if lHead?.val != rHead?.val {
                result = false
                break
            }
            rHead = rHead?.next
            lHead = lHead?.next
        }
        
        // 恢复右半部分
        reverseList(rOldHead)
        return result
    }
    
    
    // 根据快慢指针求出中间节点(必须默写出来)
    func middleNode(_ head: ListNode?) -> ListNode? {
        var fast = head
        var slow = head
        while fast != nil && fast?.next != nil {
            slow = slow?.next
            fast = fast?.next?.next
        }
        return slow
    }
    
    // 翻转链表(必须默写出来)
    @discardableResult
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
