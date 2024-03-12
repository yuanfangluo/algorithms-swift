//
//  23_合并K个升序链表.swift
//  Algorithms
//
//  Created by sheng on 2022/9/20.
//

import Foundation
// https://leetcode.cn/problems/merge-k-sorted-lists/

class MergeK {
    func mergeKLists(_ lists: [ListNode?]) -> ListNode? {
        
        return nil
    }
    
    // 思路1：最笨的方法
    // O(nlogn)
    func mergeKLists1(_ lists: [ListNode?]) -> ListNode? {
        
        // 1. 先将节点放到数组中 // O(n)
        // 2. 数组中的节点排序 // O(nlogn)
        // 3. 将元素串成一个链表 // O(n)
        
        return nil
    }
    
    // 思路2：逐一比较
    // 时间复杂度：O(kn)，k个链表，n个节点
    func mergeKLists2(_ lists: [ListNode?]) -> ListNode? {
        var lists = lists
        if lists.isEmpty {
            return nil
        }
        let head = ListNode()
        var cur = head
        while true {
            // 最小头节点的链表所在的位置
            var minIndex = -1
            for i in 0..<lists.count {
                if lists[i] == nil { // 代表该链表已经取完了
                    continue
                }
                
                if (minIndex == -1 || lists[i]!.val < lists[minIndex]!.val){ // 找出最小头节点链表所在的位置
                    minIndex = i
                }
            } // O(k)
            
            if minIndex == -1 { // 代表所有链表取完了
                break
            }
            
            cur.next = lists[minIndex]
            cur = lists[minIndex]!
            // 最小头节点链表向后走一步
            lists[minIndex] = lists[minIndex]?.next
        }// O(n)
        
        return head.next
    }
    
    // 思路3：两两合并到0位置
    // O(kn)
    func mergeKLists3(_ lists: [ListNode?]) -> ListNode? {
        var lists = lists
        if lists.isEmpty {
            return nil
        }
        
        for i in 1..<lists.count {
            lists[0] = mergeTwoLists(lists[0], lists[i])
        }
        
        return lists[0]
    }
    
    func mergeTwoLists(_ list1: ListNode?, _ list2: ListNode?) -> ListNode? {
        var list1 = list1
        var list2 = list2
        if list1 == nil {
            return list2
        }
        if list2 == nil {
            return list1
        }
        
        let head: ListNode = ListNode(0)
        
        var cur: ListNode? = head
        
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
        
        return head.next
    }
    
    // 思路4：优先级队列（小顶堆），类似于思路2
    // nlog(k)
    func mergeKLists4(_ lists: [ListNode?]) -> ListNode? {
        let lists = lists
        if lists.isEmpty {
            return nil
        }
        
        let dummy = ListNode()
        var cur = dummy
        
        let pq = PriorityQueue<ListNode> { node1, node2 in
            node1.val < node2.val
        }
        
        // 将 k 个链表的头节点加入最小堆
        for list in lists {
            if list == nil {
                continue
            }
            pq.offer(list!)
        }
        
        // 不断删除堆顶元素
        while !pq.isEmpty {
            // 删除堆顶元素
            
            let node = pq.dequeue()
            
            cur.next = node
            cur = node!
            if node?.next != nil {
                pq.offer(node!.next!)
            }
        }
        
        return dummy.next
    }
    
    // 思路5：分治(最好的方法)
    // nlogk
    func mergeKLists5(_ lists: [ListNode?]) -> ListNode? {
        var lists = lists
        if lists.isEmpty {
            return nil
        }
        
        var step = 1
        while step < lists.count {
            let nextStep = step << 1
            for i in stride(from: 0, to: lists.count - step, by: nextStep) {
                lists[i] = mergeTwoLists(lists[i], lists[i + step])
            }
            step = nextStep
        }
        return lists[0]
    }
}
