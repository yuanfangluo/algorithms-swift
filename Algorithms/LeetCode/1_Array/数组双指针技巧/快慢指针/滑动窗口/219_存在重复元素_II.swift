//
//  219_存在重复元素_II.swift
//  Algorithms
//
//  Created by sheng on 2022/11/3.
//

import Foundation
// https://leetcode.cn/problems/contains-duplicate-ii/?show=1

class ContainsNearbyDuplicate {
    
    
    /**
     1. 什么时候扩大窗口
        窗口大小小于k时
     2. 什么时候缩小窗口
        当窗口大小大于k时
     3. 什么时候更新结果
     nums[i] == nums[j] 且 窗口大小 = k
     */
    func containsNearbyDuplicate(_ nums: [Int], _ k: Int) -> Bool {
        var left = 0
        var right = 0
        
        var window = Set<Int>()
        while right < nums.count {
            // 扩大窗口
            if window.contains(nums[right]) {
                return true
            }
            
            window.insert(nums[right])
            right += 1
            
            // 缩小窗口
            if right - left > k {
                window.remove(nums[left])
                left += 1
            }
        }
        
        return false
    }
}
