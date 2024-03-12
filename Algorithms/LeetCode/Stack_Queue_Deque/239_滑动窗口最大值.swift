//
//  239_滑动窗口最大值.swift
//  Algorithms
//
//  Created by sheng on 2022/9/20.
//

import Foundation
// https://leetcode.cn/problems/sliding-window-maximum/

// 相同题目
// https://leetcode.cn/problems/hua-dong-chuang-kou-de-zui-da-zhi-lcof/


class SlidingWindowMaximum: Runnable {
    
    func run() {
        print(maxSlidingWindow2([1, -1], 1))
    }
    
    // 方法二：使用动态规划
    func maxSlidingWindow3(_ nums: [Int], _ k: Int) -> [Int] {
        return []
    }
    // 方法二：优化
    func maxSlidingWindow2(_ nums: [Int], _ k: Int) -> [Int] {
        if nums.isEmpty {
            return []
        }
        
        if k == 1 {
         return nums
        }
        
        var result = Array(repeating: 0, count: nums.count - (k - 1))
        // 求出前k个元素的最大值索引
        var maxIndex = 0
        for i in 1..<k {
            if nums[i] >= nums[maxIndex] {
                maxIndex = i
            }
        }
        // li是滑动窗口的最左索引
        for li in 0..<result.count {
            // ri是滑动窗口的最右索引
            let ri = li + (k - 1)
            if maxIndex < li { // 最大值的索引不在滑动窗口的合理范围内
                // 求出[li, ri]范围的最大值的索引
                maxIndex = li
                for i in (li+1)...ri {
                    if nums[i] >= nums[maxIndex] {
                        maxIndex = i
                    }
                }
            } else if nums[ri] >= nums[maxIndex] {
                // 最大值的索引在滑动窗口范围内，保留后面的
                maxIndex = ri
            }
            result[li] = nums[maxIndex]
        }
        return result
    }
    
    
    // 方法一：使用双端队列
    func maxSlidingWindow1(_ nums: [Int], _ k: Int) -> [Int] {
        if nums.isEmpty {
            return []
        }
        if k == 1 {
         return nums
        }
        
        var result = Array(repeating: 0, count: nums.count - (k - 1))
        let deque = Deque<Int>()
        
        for i in 0..<nums.count {
            // 只要nums[队尾]<=nums[i], 需要删除队尾
            while !deque.isEmpty && nums[i] >= nums[deque.tail!] {
                deque.dequeueLast()
            }
            
            // 将i加入到队尾
            deque.enqueue(i)
            
            // 检查窗口索引是否合法
            let li = i - (k - 1)
            if li < 0 {
                continue
            }
            
            // 检查队头的合法性
            if deque.head! < li {
                // 队头不合法，需要删除队头
                deque.dequeue()
            }
            
            // 设置窗口的最大值
            result[li] = nums[deque.head!]
        }
        
        return result
       }
}
