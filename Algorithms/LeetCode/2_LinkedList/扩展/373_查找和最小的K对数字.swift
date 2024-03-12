//
//  373_查找和最小的K对数字.swift
//  Algorithms
//
//  Created by sheng on 2022/10/30.
//

import Foundation
// https://leetcode.cn/problems/find-k-pairs-with-smallest-sums/


/**
 
 输入: nums1 = [1,7,11], nums2 = [2,4,6], k = 3
 输出: [1,2],[1,4],[1,6]
 解释: 返回序列中的前 3 对数：
      [1,2],[1,4],[1,6],[7,2],[7,4],[11,2],[7,6],[11,4],[11,6]
 
 思路：合并K个有序链表
 */
class KSmallestPairs {
    func kSmallestPairs(_ nums1: [Int], _ nums2: [Int], _ k: Int) -> [[Int]] {
        var k = k
        //  存储三元组 (nums1[i], nums2[i], i)
        let pq = PriorityQueue<(Int, Int, Int)> { a, b in
            (a.0 + a.1) < (b.0 + b.1)
        }
        
        // 按照 23 题的逻辑初始化优先级队列
        for i in 0..<nums1.count {
            pq.offer((nums1[i], nums2[0], 0))
        }
        
        var res: [[Int]] = []
        // 执行合并多个有序链表的逻辑
        while !pq.isEmpty && k > 0 {
            let cur = pq.dequeue()!
            k -= 1
            // 链表中的下一个节点加入优先级队列
            let next_index = cur.2 + 1
            
            if next_index < nums2.count {
                pq.offer((cur.0, nums2[next_index], next_index))
            }
            
            res.append([cur.0, cur.1])
        }
        
        return res
    }
}
