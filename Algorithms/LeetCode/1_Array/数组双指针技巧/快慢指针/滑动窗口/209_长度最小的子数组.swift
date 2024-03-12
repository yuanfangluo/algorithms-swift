//
//  209_长度最小的子数组.swift
//  Algorithms
//
//  Created by sheng on 2022/11/3.
//

import Foundation

// https://leetcode.cn/problems/minimum-size-subarray-sum/?show=1

class MinSubArrayLen {
    
    /**
     
     典型的滑动窗口算法
     
     1. 什么时候扩大窗口
     窗口里面的元素和小于目标值
     2. 什么时候减小窗口
     窗口里面的元素和大于目标值
     3. 什么时候更新结果
     窗口里面的目标和大于等于目标值
     
     */
    
    func minSubArrayLen(_ target: Int, _ nums: [Int]) -> Int {
        
        var left = 0
        var right = 0
        
        var windowSum = 0
        var  minLen = Int.max
        
        while right < nums.count {
            
            windowSum += nums[right]
            
            right += 1
            
            while windowSum >= target && left < right  {
                // 在这里更新答案
                minLen = min(minLen, right - left)
                
                windowSum -= nums[left]
                left += 1
            }
        }

        return minLen == Int.max ? 0 : minLen
    }
}
