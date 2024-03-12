//
//  2_两数相加.swift
//  Algorithms
//
//  Created by sheng on 2022/9/19.
//

import Foundation

// https://leetcode.cn/problems/add-two-numbers/

class AddTwoNumbers: Runnable {
    func run() {
        
    }
    
    // 思路：链表双指针,虚拟头节点
    func addTwoNumbers(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
        // 在两条链表的指针
        var p1 = l1
        var p2 = l2
        
        // 虚拟头结点（构建新链表的常用技巧）
        var dummp = ListNode(0)
        
        // 指针p 负责构建新链表
        var p = dummp
        // 记录进位
        var carry = 0
        
        // 开始执行加法，两条链表走完并且没有进位时，才能结束循环
        while p1 != nil || p2 != nil || carry > 0 {
            
            // 首先加上上次的进位
            var val = carry
            
            if p1 != nil {
                val += p1!.val
                p1 = p1?.next
            }
            
            if p2 != nil {
                val += p2!.val
                p2 = p2?.next
            }
            
            // 处理进位情况
            carry = val / 10
            val = val % 10
            
            // 构建新节点
            p.next = ListNode(val)
            
            p = p.next!
            
        }
        // 返回链表的头节点，也就是虚拟头结点的下一个
        return dummp.next
    }
    
    func addTwoNumbers2(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
        var list1 = l1
        var list2 = l2
        if list1 == nil {
            return list2
        }
        if list2 == nil {
            return list1
        }
        // 新链表的虚拟头结点
        let dummyHead = ListNode(0)
        // 新链表的最后一个节点
        var last = dummyHead
        // 进位值
        var carry = 0
        
        while list1 != nil || list2 != nil {
            var v1 = 0
            if list1 != nil {
                v1 = list1!.val
                list1 = list1?.next
            }
            
            var v2 = 0
            if list2 != nil {
                v2 = list2!.val
                list2 = list2?.next
            }
            
            let sum = v1 + v2 + carry
            carry = sum / 10
            last.next = ListNode(sum % 10)
            last = last.next!
        }
        
        // 检查最后的进位
        if carry > 0 {
            last.next = ListNode(carry)
        }
        
        return dummyHead.next
    }
}
