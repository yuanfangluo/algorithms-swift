//
//  21_合并两个有序链表.swift
//  Algorithms
//
//  Created by sheng on 2022/9/20.
//

import Foundation

// https://leetcode.cn/problems/merge-two-sorted-lists/

class MergeTwoSortedLists {
    
    // 思路1：使用虚拟头节点 dummy head
    func mergeTwoLists2(_ list1: ListNode?, _ list2: ListNode?) -> ListNode? {
        var list1 = list1
        var list2 = list2
        if list1 == nil {
            return list2
        }
        if list2 == nil {
            return list1
        }
        // 虚拟头节点
        let dummy: ListNode = ListNode(0)
        var cur: ListNode? = dummy
        
        while list1 != nil && list2 != nil {
            if list1!.val <= list2!.val {
                cur?.next = list1
                cur = list1
                list1 = list1?.next
            } else {
                cur?.next = list2
                cur = list2
                list2 = list2?.next
            }
        }
        
        if list1 == nil {
            cur?.next = list2
        } else if (list2 == nil) {
            cur?.next = list1
        }
        
        return dummy.next
    }
    
    // 思路2：递归
    // 递归函数定义：合并两个有序链表
    func mergeTwoLists(_ list1: ListNode?, _ list2: ListNode?) -> ListNode? {
        if list1 == nil {
            return list2
        }
        
        if list2 == nil {
            return list1
        }
        
        if list1!.val <= list2!.val {
            list1?.next = mergeTwoLists(list1?.next, list2)
            return list1
        } else {
            list2?.next = mergeTwoLists(list2?.next, list1)
            return list2
        }
    }
}
