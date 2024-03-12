//
//  剑指Offer_22_链表中倒数第k个节点.swift
//  Algorithms
//
//  Created by sheng on 2022/10/28.
//

import Foundation
// https://leetcode.cn/problems/lian-biao-zhong-dao-shu-di-kge-jie-dian-lcof/

class GetKthFromEnd {
    func getKthFromEnd(_ head: ListNode?, _ k: Int) -> ListNode? {
        
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
