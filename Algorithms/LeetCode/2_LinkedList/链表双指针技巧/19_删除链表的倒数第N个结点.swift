//
//  19_删除链表的倒数第N个结点.swift
//  Algorithms
//
//  Created by sheng on 2022/10/28.
//

import Foundation
// https://leetcode.cn/problems/remove-nth-node-from-end-of-list/

class RemoveNthFromEnd: Runnable {
    func run() {
        let head = ListNode(0)
        head.next = ListNode(1)
        head.next?.next = ListNode(2)
        print(removeNthFromEnd(head, 2)!)
    }
    
    private func removeNthFromEnd(_ head: ListNode?, _ k: Int) -> ListNode? {
        
        // 注意注意注意：
        // 如果链表只有一个节点，求倒数第二个是没有的，需要借助虚拟头节点
        let dummy = ListNode(0)
        dummy.next = head
        
        // 删除倒数第k个节点，需要找到倒数第 k + 1 个节点
        let node = kToLast(dummy, k + 1)
        // 删掉倒数第k个节点
        node?.next = node?.next?.next
        
        return dummy.next
    }
    
    private func kToLast(_ head: ListNode?, _ k: Int) -> ListNode? {
         
         var p1 = head

        // p1 先走 k 步
         for _ in 0..<k {
             p1 = p1?.next
         }
         
         var p2 = head
        // p1 和 p2 同时走 n - k 步
         while p1 != nil {
             p2 = p2?.next
             p1 = p1?.next
         }
         // 此时 p2 指向了 n - k + 1，也就是倒数第 k 个
         return p2
     }
     
}
