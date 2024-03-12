//
//  1658_将x减到0的最小操作数.swift
//  Algorithms
//
//  Created by sheng on 2022/11/3.
//

import Foundation
// https://leetcode.cn/problems/minimum-operations-to-reduce-x-to-zero/?show=1


class MinOperations {
    
    /**
     题目让我们从边缘删掉和为x 的元素，剩下来的子数组；
     尽可能少地从边缘删除元素，也就是说剩下来的子数组大小尽可能大
     
     所以，这道题等价于 让你寻找 nums 中元素和为 sum(nums) - x 的最长数组
     
     寻找子数组就是考察滑动窗口技巧
     
     1. 什么时候扩大窗口
     当窗口内元素之和小于目标和，扩大窗口
     
     2. 什么时候缩小窗口
     当窗口内元素大于目标和，缩小窗口
     
     3. 什么时候更新结果
     当窗口内元素之和等于目标和，找到一个符合条件的子数组，这就是我们想找的最长子数组
     
     类似 713. 乘积小于 K 的子数组，之所以本题可以用滑动窗口，关键是题目说了 nums 中的元素都是正数，这就保证了只要有元素加入窗口，和一定变大，只要有元素离开窗口，和一定变小
     
     如果存在负数的话就没有这个性质了，也就不能确定什么时候扩大和缩小窗口，也就不能使用滑动窗口算法，而应该使用前缀和 + 哈希表的方式解决，参见 560. 和为K的子数组
     */
    
    
    func minOperations(_ nums: [Int], _ x: Int) -> Int {
        // 计算总和
        var sum = 0
        for num in nums {
            sum += num
        }
        
        // 那么滑动窗口需要寻找的子数组目标和
        let target = sum - x
        
        // 滑动算法
        var left = 0
        var right = 0
        
        // 记录窗口内所有元素和
        var windowSum = 0
        // 记录目标子数组的最大长度
        var maxLen = Int.min
        // 开始执行滑动算法
        while right < nums.count {
            // 扩大窗口
            windowSum += nums[right]
            
            right += 1
            
            while windowSum > target && left < right {
                windowSum -= nums[left]
                left += 1
            }
            
            // 寻找目标数组
            if target == windowSum {
                maxLen = max(maxLen, right - left)
            }
        }
        
        return maxLen == Int.min ? -1 : nums.count - maxLen
       }
}
