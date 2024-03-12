//
//  160_相交链表.swift
//  Algorithms
//
//  Created by sheng on 2022/9/19.
//

import Foundation
// https://leetcode.cn/problems/intersection-of-two-linked-lists/
// https://leetcode.cn/problems/intersection-of-two-linked-lists-lcci/
// https://leetcode.cn/problems/liang-ge-lian-biao-de-di-yi-ge-gong-gong-jie-dian-lcof/
/**
 思路：两个并在一起
 */
class intersection {
    func getIntersectionNode(_ headA: ListNode?, _ headB: ListNode?) -> ListNode? {
        if headA == nil || headB == nil {
            return nil
        }
        
        var curA = headA
        var curB = headB
        
        while curA !== curB  {
            curA = (curA == nil) ? headB : curA?.next
            curB = (curB == nil) ? headA : curB?.next
        }
        
        return curA
    }
}
