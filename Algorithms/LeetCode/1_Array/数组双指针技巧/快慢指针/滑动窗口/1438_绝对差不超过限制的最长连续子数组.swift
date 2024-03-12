//
//  1438_绝对差不超过限制的最长连续子数组.swift
//  Algorithms
//
//  Created by sheng on 2022/11/3.
//

import Foundation
// https://leetcode.cn/problems/longest-continuous-subarray-with-absolute-diff-less-than-or-equal-to-limit/description/?show=1

class LongestSubarray: Runnable {
    
    func run() {
        print(longestSubarray([8,2,4,7], 4))
    }
    
    /**
     1. 什么时候扩大窗口？
     窗口内的绝对差不超过限制
     
     2. 什么时候缩小窗口？
     当新加入的元素使得绝对差超过限制
     
     3. 什么时候更新结果？
      窗口的最大宽度就是子数组的最大长度
     
     但有个问题，当窗口进新元素时，我可以更新窗口中的最大值和最小值，但当窗口收缩时，如何更新最大值和最小值呢？
     
     这就用到单调队列结构了，这里需要一个通用的 MonotonicQueue 类，用来高效判断窗口中的最大值和最小值
     
     
     */
    
    func longestSubarray(_ nums: [Int], _ limit: Int) -> Int {
        
        var left = 0
        var right = 0
        
        var windowSize = 0
        var res = 0
        let window = MonotonicQueue<Int>()
        
        // 滑动窗口模版
        while right < nums.count {
            // 扩大滑动窗口
            window.push(nums[right])
            right += 1
            windowSize += 1
            
            while (window.max! - window.min!) > limit {
                // 缩小窗口，更新窗口最值
                window.pop()
                left += 1
                windowSize -= 1
            }
            // 在窗口收缩判断完之后更新答案
            res = max(res, windowSize)
            
        }
        
        return res
    }
}
