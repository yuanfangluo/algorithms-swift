//
//  剑指Offer_18_删除链表的节点.swift
//  Algorithms
//
//  Created by sheng on 2022/11/1.
//

import Foundation
// https://leetcode.cn/problems/shan-chu-lian-biao-de-jie-dian-lcof/

class ListdeleteNode {
    
    // 思路1：找到要删除的前一个节点
    func deleteNode(_ head: ListNode?, _ val: Int) -> ListNode? {
        
        // 构造虚拟头节点指向给出的链表
        var dummy = ListNode()
        dummy.next = head
        
        var prev = dummy
        var cur = head
        
        while cur != nil {
            if cur?.val == val {
                prev.next = cur?.next
                break
            }
            prev = cur!
            cur = cur?.next
        }
        
        return dummy.next
    }
    
    // 思路2：可以认为这道题是把原链表分解成「值为 val」和「值不为 val」的两条链表，就可以复用 86.分割链表 的思路了
    // 感觉思路搞复杂了
    func deleteNode2(_ head: ListNode?, _ val: Int) -> ListNode? {
        // 构造虚拟头节点指向给出的链表
        var dummy = ListNode()
        dummy.next = head
        
        // 负责生成结果链表
        var prev = dummy
        // cur负责遍历链表
        var cur = head
        
        while cur != nil {
            if cur?.val != val {
                // 把值不为 val的节点接到结果链表上
                prev.next = cur
                prev = prev.next!
            }
            
            // 这里是 等于 val 的
            let temp = cur?.next
            cur?.next = nil
            cur = temp
        }
        return dummy.next
    }
    
}
