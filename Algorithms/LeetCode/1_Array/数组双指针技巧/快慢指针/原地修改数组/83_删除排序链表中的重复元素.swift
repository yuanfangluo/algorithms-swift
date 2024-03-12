//
//  83_删除排序链表中的重复元素.swift
//  Algorithms
//
//  Created by sheng on 2022/11/1.
//

import Foundation
// https://leetcode.cn/problems/remove-duplicates-from-sorted-list/


class ListdeleteDuplicates {
    func deleteDuplicates(_ head: ListNode?) -> ListNode? {
        
        var slow = head
        var fast = head
        
        while fast != nil {
            if fast!.val != slow!.val {
                slow = slow?.next
                slow?.val = fast!.val
            }
            
            fast = fast?.next
        }
        
        if slow?.next != nil {
            slow?.next = nil
        }
        
        return head
    }
    
    // 优化:如果遇到重复的节点，不需要比较了
    func deleteDuplicates2(_ head: ListNode?) -> ListNode? {
        
        var slow = head
        var fast = head
        
        while fast != nil {
            if fast!.val != slow!.val {
                // 遇到重复的直接跳过
                slow?.next = fast
                slow = slow?.next
            }
            
            fast = fast?.next
        }
        
        if slow?.next != nil {
            slow?.next = nil
        }
        
        return head
    }
}
