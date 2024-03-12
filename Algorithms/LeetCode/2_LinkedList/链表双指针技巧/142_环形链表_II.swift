//
//  142_环形链表_II.swift
//  Algorithms
//
//  Created by sheng on 2022/10/28.
//

import Foundation
// https://leetcode.cn/problems/linked-list-cycle-ii/

class LinkedListCycleII {
    func detectCycle(_ head: ListNode?) -> ListNode? {
        
        var slow = head
        var fast = head
        
        while fast != nil && fast?.next != nil {
            slow = slow?.next
            fast = fast?.next?.next
            
            if slow === fast {
                break
            }
        }
        
        // 这里是不包含环的情况
        if fast == nil || fast?.next == nil {
            // fast 遇到空节点
            return nil
        }
        
        // 包含环的情况：
        /**
         思路：假设相遇的时候，慢指针走了k步，那么快指针走了2k步；
         假设环起点到相遇的地方是m，那么出发起点到环起点的距离是 k -m 步
         快指针多走的k步应该是环长度的整数倍，距离环起点有 k - m
         */
        
        // 重新将慢指针指向起点
        slow = head
        while slow !== fast {
            slow = slow?.next
            fast = fast?.next
        }
        // 到这里代表相遇在环起点
        return slow
    }
}
