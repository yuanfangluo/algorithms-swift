//
//  单链表的倒数第k个节点.swift
//  Algorithms
//
//  Created by sheng on 2022/10/28.
//

import Foundation

// 思路1：首先你会想到的方法是：
// 先遍历一遍链表，找到链表节点的个数 n
// 然后再遍历链表，找到正数第 n - k + 1 个节点就是所求的
// 这个方法是通过遍历2次链表，如果要求只遍历一次链表，那么怎么求？

// 思路2：我们可以使用双指针
// 首先我们先让 p1 走k步，此时如果再让 p1 走 n - k 就会走到空指针
// 此时我们让 p2 从头开始和p1往后走
// 当p1走到空指针的时候，p2的位置就是倒数第k个节点的位置

class KToLast: Runnable {
    
    func run() {
        let head = ListNode(0)
        head.next = ListNode(1)
        head.next?.next = ListNode(2)
        print(kToLast(head, 1)!)
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


