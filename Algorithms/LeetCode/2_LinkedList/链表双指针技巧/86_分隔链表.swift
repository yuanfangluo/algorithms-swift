//
//  86_分隔链表.swift
//  Algorithms
//
//  Created by sheng on 2022/9/20.
//

import Foundation
// https://leetcode.cn/problems/partition-list/
// https://leetcode.cn/problems/partition-list-lcci/

class PartitionList {
    func partition(_ head: ListNode?, _ x: Int) -> ListNode? {
        var cur = head
        
        if cur == nil {
            return nil
        }
        
        let lHead = ListNode(0)
        var lTail = lHead
        
        let rHead = ListNode(0)
        var rTail = rHead
        
        while cur != nil {
            if cur!.val < x {
                lTail.next = cur
                lTail = cur!
            } else {
                rTail.next = cur
                rTail = cur!
            }
            cur = cur?.next
        }
        
        // 将右链表的尾节点指向nil
        rTail.next = nil
        
        // 将左链表的尾节点的next执行右链表的头节点
        lTail.next = rHead.next
        
        return lHead.next
    }
}
