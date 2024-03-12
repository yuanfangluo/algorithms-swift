//
//  两个链表是否相交.swift
//  Algorithms
//
//  Created by sheng on 2022/10/28.
//

import Foundation

class IntersectLists {
    
    func isIntersect(_ list1: ListNode?, _ list2: ListNode?) -> ListNode? {
        
        var l1 = list1
        var l2 = list2
        
        while l1 !== l2 {
            if l1 == nil {
                l1 = list2
            } else {
                l1 = l1?.next
            }
            
            if l2 == nil {
                l2 = list1
            } else {
                l2 = l2?.next
            }
        }
        // 如果有相交，那么 l1 = l2
        // 如果没有相交，那么 l1 = l2 = nil
        return l1
    }
}
