//
//  300_最长递增子序列.swift
//  Algorithms
//
//  Created by sheng on 2022/9/15.
//

import Foundation
// https://leetcode.cn/problems/longest-increasing-subsequence/

class LIS: Runnable {
    func run() {
        print(lengthOfLIS3([10, 2, 2, 5, 1, 7, 101, 18]))
    }
    // 方法三：二分搜索,可以将时间复杂度优化成O(nlogn)
    // top数组是升序的
    func lengthOfLIS3(_ nums: [Int]) -> Int {
        if nums.isEmpty {
            return 0
        }
        // 牌堆的数量
        var len = 0
        // 牌顶数组
        var top = Array(repeating: 0, count: nums.count)
        // 遍历所有牌
        for num in nums {
            var begin = 0
            var end = len
            while begin < end {
                let mid = (begin + end) >> 1
                if num <= top[mid] {
                    end = mid
                } else {
                    begin = mid + 1
                }
            }
            // 覆盖牌顶
            top[begin] = num
            // 检查是否需要新建牌堆
            if begin == len {
                len += 1
            }
        }
        return len
    }
    
//    方法二：扑克牌思想：
    func lengthOfLIS2(_ nums: [Int]) -> Int {
        if nums.isEmpty {
            return 0
        }
        // 牌堆的数量
        var len = 0
        // 牌顶数组
        var top = Array(repeating: 0, count: nums.count)
        // 遍历所有牌
        for num in nums {
            var j = 0
            while j < len {
                // 如果选取的牌小于等于牌堆的牌顶牌
                if top[j] >= num {
                    top[j] = num
                    break
                }
                // 选取的牌大于牌堆的牌顶牌
                j += 1
            }
            // 到这边代表没有找到一个堆的牌顶大于选择的牌，需要新建牌堆
            if j == len {
                len += 1
                top[j] = num
            }
        }
        return len
    }
    
    
    /**
     方法一：动态规划
     [10, 2, 2, 5, 1, 7, 101, 18]
     dp(i) 是以nums[i] 结尾的最长上升子序列的长度
     dp(0) = 1
    dp(1) = 1
     dp(2) = 1
     dp(3) = 2
    dp(4) = 2
     dp(5) = dp(4) + 1 = 2+ 1 = 3
     dp(6) = dp(5) + 1 = 4
     */
    func lengthOfLIS1(_ nums: [Int]) -> Int {
        if nums.isEmpty {
            return 0
        }
        // dp(i) 是以nums[i] 结尾的最长上升子序列的长度
        var dp = Array(repeating: 1, count: nums.count)
        var maxValue = dp[0]
        for i in 1..<nums.count {
            for j in 0..<i {
                if nums[i] <= nums[j] {
                    continue
                }
                dp[i] = max(dp[i], dp[j] + 1)
            }
            maxValue = max(dp[i], maxValue)
        }
        return maxValue
    }
    /**
     空间复杂度是：O(n)
     时间复杂度是：O(n^2)
     */
    
    
}
