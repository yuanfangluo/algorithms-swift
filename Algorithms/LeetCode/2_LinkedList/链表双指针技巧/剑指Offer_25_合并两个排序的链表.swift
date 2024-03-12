//
//  剑指Offer_25_合并两个排序的链表.swift
//  Algorithms
//
//  Created by sheng on 2022/10/28.
//

import Foundation
// https://leetcode.cn/problems/he-bing-liang-ge-pai-xu-de-lian-biao-lcof/


class MergeTwoLists {
    
    // 思路1：迭代
    func mergeTwoLists1(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
        
        if l1 == nil {
            return l2
        }
        
        if l2 == nil {
            return l1
        }
        
        var l1 = l1
        var l2 = l2
        let dummy = ListNode()
        var cur = dummy
        
        while l1 != nil && l2 != nil {
            
            if l1!.val <= l2!.val {
                cur.next = l1 // 先将虚拟头节点的next指向 l1
                cur = l1! // 然后 将 游标节点指向 l1
                l1 = l1?.next // l1 节点往后进一步
            } else {
                cur.next = l2
                cur = l2!
                l2 = l2?.next
            }
            
        }
        
        if l1 == nil {
            cur.next = l2
        } else if (l2 == nil) {
            cur.next = l1
        }
        
        return dummy.next
    }
    
    // 思路2：递归
    // 递归函数定义：合并两个有序链表
    func mergeTwoLists(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
        
        if l1 == nil {
            return l2
        }
        
        if l2 == nil {
            return l1
        }
        
        if l1!.val <= l2!.val {
            l1?.next = mergeTwoLists(l1?.next, l2)
            return l1
        } else {
            l2?.next = mergeTwoLists(l1, l2?.next)
            return l2
        }
        
    }
    
}
