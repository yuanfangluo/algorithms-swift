//
//  220_存在重复元素_III.swift
//  Algorithms
//
//  Created by sheng on 2022/11/3.
//

import Foundation
// https://leetcode.cn/problems/contains-duplicate-iii/?show=1

class Solution {
    
    
    
    /**
     1. 什么时候扩展窗口
     当窗口大小小于等于 k 时，扩大窗口，包含更多元素
     2. 什么时候缩小窗口
     当窗口大小大于 k 时，缩小窗口，减少窗口元素
     3. 什么时候更新结果
     窗口大小小于等于 k，且窗口中存在两个不同元素之差小于 t 时，找到一个答案
     
     那么我如何在窗口 [left, right) 中快速判断是否有元素之差小于 t 的两个元素呢？
     
     这就需要使用到 TreeSet 利用二叉搜索树结构寻找「地板元素」和「天花板元素」的特性了。
     
     */
    func containsNearbyAlmostDuplicate(_ nums: [Int], _ indexDiff: Int, _ valueDiff: Int) -> Bool {
        
        let window = TreeSet<Int>()
        var left = 0
        var right = 0
        
        while right < nums.count {
            
            //  为了防止 i == j, 所以在扩大窗口之前先判断是否有符合题意的索引对 (i, j)
            
            // 查找略大于 nums[right] 的那个元素
            let ceiling = window.ceiling(nums[right])
            
            if ceiling != nil && ceiling! - nums[right] <= valueDiff {
                return true
            }
            
            // 查找略小于 nums[right] 的那个元素
            
            let floor = window.floor(nums[right])
            
            if floor != nil && nums[right] - floor! <= valueDiff {
                return true
            }
            
            // 扩大窗口
            window.add(nums[right])
            right += 1
            
            if right - left > indexDiff {
                // 缩小窗口
                window.remove(nums[left])
                left += 1
            }
            
            
        }
        
        
        return false
    }
}
