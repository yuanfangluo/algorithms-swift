//
//  378_有序矩阵中第K小的元素.swift
//  Algorithms
//
//  Created by sheng on 2022/10/31.
//

import Foundation
// https://leetcode.cn/problems/kth-smallest-element-in-a-sorted-matrix/?show=1


/**
 这道题其实是前文 单链表的六大解题套路 中讲过的 23. 合并K个升序链表 的变体。

 矩阵中的每一行都是排好序的，就好比多条有序链表，你用优先级队列施展合并多条有序链表的逻辑就能找到第 k 小的元素了。
 
 */
class KthSmallestInSortedMatrix {
    func kthSmallest(_ matrix: [[Int]], _ k: Int) -> Int {
        var k = k
        // 存储二元组 (matrix[i][j], i, j)
        // i代表行,j代表列，记录当前元素索引位置，用于生成下一个节点
        let pq = PriorityQueue<(Int, Int, Int)> { a, b in
            // 按照元素大小升序排列
            a.0 < b.0
        }
        
        // 初始化优先级队列，把每一行的第一个元素装进去
        for i in 0..<matrix.count {
            pq.offer((matrix[i][0], i, 0))
        }
        
        var res = -1
        // 执行合并多个有序链表的逻辑，找到第 k 小的元素
        while !pq.isEmpty && k > 0 {
            let cur = pq.dequeue()!
            res = cur.0
            k -= 1
            
            // 该节点的位置是
            let i = cur.1
            let j = cur.2
            
            // 将链表中的下一个节点位置是
            let nextI = i
            let nextJ = j + 1
            // 将链表的下一个节点加入优先级队列
            if nextJ < matrix[i].count { //
                pq.offer((matrix[nextI][nextJ], nextI, nextJ))
            }
        }
        return res
    }
    
    // 思路2：全部加到一个数组里面，然后排序
    func kthSmallest2(_ matrix: [[Int]], _ k: Int) -> Int {

        var arr = [Int]()
        
        for row in matrix {
            arr += row
        }
        arr.sort()
        
        return arr[k - 1]
    }
    
}
