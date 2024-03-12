//
//  862_和至少为K的最短子数组.swift
//  Algorithms
//
//  Created by sheng on 2022/10/26.
//

import Foundation
// https://leetcode.cn/problems/shortest-subarray-with-sum-at-least-k/

class ShortestSubarray:Runnable {
    func run() {
        print(
//            shortestSubarray([1], 1),
//            shortestSubarray([1, 2], 4),
            shortestSubarray([2, -1, 2], 3)
        )
    }
    /**
     分析：要找子数组的长度，需要找[l, r]， 得出长度是：r - l + 1
     */
    
    // 该方法超出时间限制
   private func shortestSubarray1(_ nums: [Int], _ k: Int) -> Int {
       var minLen = -1
       for l in 0..<nums.count {
           var sum = k - nums[l]
           if sum <= 0 {
               minLen = 1
               break
           }
           for r in (l+1)..<nums.count {
               sum -= nums[r]
               if sum <= 0 {
                   if minLen == -1 {
                       minLen = r - l + 1
                       print(l, r)
                   } else {
                       print(l, r)
                       minLen = min(minLen, r - l + 1)
                   }
                   break
               }
           }
       }
       return minLen
    }
    
    // 方法优化：前缀和数组
    /**
     数组nums 的前缀和数组为 preSumArr, 其中 preSumArr[i] = num[0]+...+ nums[i - 1]
     对于边界情况：preSumArr[0] = 0
    那么从数组 nums 下标 i 开始长度为 m 的子数组的和 = preSumArr[i + m] - preSumArr[i]
     题目要求计算 \textit{nums}nums 中，和大于等于 kk 的最短子数组的长度。
     可以以nums的每一个下标作为候选子数组的起点下标，都计算满足条件的最短子数组的长度，然后再从这些长度中找出最小值即可。
     
     */
    private func shortestSubarray2(_ nums: [Int], _ k: Int) -> Int {
        let n = nums.count
        var preSumArr = Array(repeating: 0, count: n + 1)
        
        for i in 1...n {
            preSumArr[i] = preSumArr[i - 1] + nums[ i - 1]
        }
        
        print(preSumArr)
        
        var res = -1
        
        let deque = Deque<Int>()
        
        for i in 0...n {
            let curSum = preSumArr[i]
            
            while !deque.isEmpty && (curSum - preSumArr[deque.head!] >= k) {
                if res == -1 {
                    res = i - deque.dequeue()!
                } else {
                    res = min(res, i - deque.dequeue()!)
                }
            }
            
            while !deque.isEmpty && preSumArr[deque.tail!] >= curSum {
                deque.dequeueLast()
            }
            deque.enqueue(i)
        }
        return res
    }
    #warning("前缀和数组")
    private func shortestSubarray(_ nums: [Int], _ k: Int) -> Int {
        let n = nums.count
        var preSumArr = Array(repeating: 0, count: n + 1)
        
        for i in 1...n {
            preSumArr[i] = preSumArr[i - 1] + nums[ i - 1]
        }
        
        //
        var q = Array(repeating: 0, count: n + 1)
        
        var head = 0
        var tail = -1
        var res = n + 1
        
        for i in 0...n {
            let curSum = preSumArr[i]
            
            while head <= tail && (curSum - preSumArr[q[head]]) >= k {
                res = min(res, i - q[head])
                head += 1
            }
            
            while (head <= tail && preSumArr[q[tail]] >= curSum) {
                tail -= 1
            }
            tail += 1
            q[tail] = i
        }
        
        return res < n + 1 ? res : -1
    }
    
}


