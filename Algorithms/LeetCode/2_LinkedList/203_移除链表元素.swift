//
//  203_移除链表元素.swift
//  Algorithms
//
//  Created by sheng on 2022/9/19.
//

import Foundation

// https://leetcode.cn/problems/remove-linked-list-elements/

class RemoveElements: Runnable {
    func run() {
        
    }
    
    // 方法二：使用虚拟头结点
    func removeElements2(_ head: ListNode?, _ val: Int) -> ListNode? {
        var oldHead = head
        // 新链表的头结点
        let newHead: ListNode = ListNode(0)
        // 新链表的尾节点
        var newTail: ListNode = newHead
        
        while oldHead != nil {
            if oldHead?.val != val {
                newTail.next = oldHead
                newTail = oldHead!
            }
            oldHead = oldHead?.next
        }
        newTail.next = nil
        return newHead.next
    }
    
    // 可以看成是构建一个新链表
    // head是用来扫描链表节点的
    // newHead是新链表的头结点，用来返回新链表的
    // newTail是新链表的最后一个节点：是用来指向下一个节点的
    func removeElements(_ head: ListNode?, _ val: Int) -> ListNode? {
        var oldHead = head
        // 新链表的头结点
        var newHead: ListNode?
        // 新链表的尾节点
        var newTail: ListNode?
        
        while oldHead != nil {
            if oldHead?.val != val {
                // 将head拼接到newTail的后面
                if newTail == nil {
                    newHead = oldHead
                    newTail = oldHead
                } else {
                    newTail?.next = oldHead
                    newTail = oldHead
                }
            }
            oldHead = oldHead?.next
        }
        
        if newTail == nil {
            return nil
        } else {
            // 尾节点的next要清空
            newTail?.next = nil
        }
        return newHead
    }
}
