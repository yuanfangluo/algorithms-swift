//
//  53_最大子数组和.swift
//  Algorithms
//
//  Created by sheng on 2022/9/13.
//

import Foundation
// https://leetcode.cn/problems/maximum-subarray/
// 剑指 Offer 42. 连续子数组的最大和: https://leetcode.cn/problems/lian-xu-zi-shu-zu-de-zui-da-he-lcof/
/**
 子序列：可以不连续
 子串，子数组（连续子序列），子区间：必须连续
 */
class MaximumSubarray: Runnable {
    func run() {
        let nums = [-2, 1, -3, 4, -1, 2, 1, -5, 4]
        print(maxSubArray(nums))
    }
    
    func maxSubArray(_ nums: [Int]) -> Int {
        maxSubArray5(nums)
    }
    
    // 方法五：优化一下数组
    func maxSubArray5(_ nums: [Int]) -> Int {
        if nums.isEmpty {
            return 0
        }
        var dp = nums[0]
        var maxValue = dp
        for i in 1..<nums.count {
            if dp <= 0 {
                dp = nums[i]
            } else {
                dp = dp + nums[i]
            }
            maxValue = max(dp, maxValue)
        }
        return maxValue
    }
    
    
    // 方法四：动态规划
    func maxSubArray4(_ nums: [Int]) -> Int {
        if nums.isEmpty {
            return 0
        }
        //        dp(i)是以nums[i]结尾的最大连续子序列和（nums是整个序列）
        /**
         例如：-2，1， -3，4，-1, 2，1，-5, 4
         dp(0) = -2
         dp(1) = 1
         dp(2) = dp(1) + (-3) = -2
         dp(3) = 4
         dp(4) = dp(3) + (-1) = 3
         dp(5) = dp(4) + 2 = 5
         dp(6) = dp(5)+1 = 6
         dp(7) = dp(6) + (-5) = 1
         dp(8) = dp(7) + 4 = 5
         */
        var dp: [Int] = Array(repeating: 0, count: nums.count)
        dp[0] = nums[0]
        var maxValue = nums[0]
        for i in 1..<nums.count {
            if dp[i - 1] <= 0 {
                dp[i] = nums[i]
            } else {
                dp[i] = dp[i - 1] + nums[i]
            }
            maxValue = max(dp[i], maxValue)
        }
        return maxValue
    }
    
    // 方法三：分治（参考归并排序）
    /**
     1. 将序列均匀地分割成2个子序列
     [begin, end) = [begin, middle) + [middle, end], mid = (begin + end) >> 1
     2. 假设问题的解是S[i, j), 那么这个解有3种可能
     (1) [i, j) 处于[begin, middle) 中
     (2) [i, j) 处于[middle, end) 中
     (3) [i, j) 一部分在处于[begin, middle) 中，一部分在[middle, end) 中
     时间复杂度：和归并排序，快速排序一样
     T（n） = 2T(n/2) + O(n)
     T(n) = nlogn
     */
    func maxSubArray3(_ nums: [Int]) -> Int {
        if nums.isEmpty {
            return 0
        }
        return maxSubArray3(nums, 0, nums.count)
        
    }
    
    //    求[begin, end) 中最大连续子序列的和
    func maxSubArray3(_ nums: [Int], _ begin: Int, _ end: Int) -> Int {
        if end - begin == 1 {
            return nums[begin]
        }
        //        左边
        let mid = (begin + end) >> 1
        var leftMax = Int.min
        var leftSum = 0
        for i in stride(from: mid - 1, through: begin, by: -1) {
            leftSum += nums[i]
            leftMax = max(leftMax, leftSum)
        }
        //        右边
        var rightMax = Int.min
        var rightSum = 0
        for i in mid..<end {
            rightSum += nums[i]
            rightMax = max(rightMax, rightSum)
        }
        
        return max(
            leftMax + rightMax, // 一部分在左边
            max(
                maxSubArray3(nums, begin, mid), // 都在左边
                maxSubArray3(nums, mid, end) // 都在右边
            )
        )
    }
    
    // 方法二：暴力法优化
    func maxSubArray2(_ nums: [Int]) -> Int {
        if nums.isEmpty {
            return 0
        }
        var maxValue = Int.min
        for begin in 0..<nums.count {
            var sum = 0
            for end in begin..<nums.count {
                sum += nums[end]
                maxValue = max(maxValue, sum)
            }
        }
        return maxValue
    }
    
    // 方法一：暴力法
    func maxSubArray1(_ nums: [Int]) -> Int {
        if nums.isEmpty {
            return 0
        }
        var maxValue = Int.min
        for begin in 0..<nums.count {
            for end in begin..<nums.count {
                var sum = 0
                for i in begin...end {
                    sum += nums[i]
                }
                maxValue = max(maxValue, sum)
            }
        }
        return maxValue
    }
    
}


