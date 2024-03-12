//
//  213_打家劫舍_II.swift
//  Algorithms
//
//  Created by sheng on 2022/9/22.
//

import Foundation

// https://leetcode.cn/problems/house-robber-ii/

class HouseRobberII: Runnable {
    
    func run() {
        print(rob([200,3,140,20,10]))
    }
    
    private func rob(_ nums: [Int]) -> Int {
        if nums.count == 1 {
            return nums[0]
        }
        
        if nums.count == 2 {
            return max(nums[0], nums[1])
        }
        
        if nums.count == 3 {
            return max(nums[0], nums[1], nums[2])
        }
        
        // 不需要第一个
        var nums1 = Array(nums)
        nums1.removeFirst()
        
        // 不需要最后一个
        var nums2 = Array(nums)
        nums2.removeLast()
        
        print(rob1(nums1), rob1(nums2))
        
        return max(rob1(nums1), rob1(nums2))
    }
    
    
    func rob1(_ nums: [Int]) -> Int {
        var array = Array(repeating: 0, count: nums.count)
        array[0] = nums[0]
        array[1] = max(nums[0], nums[1])
        
        for i in 2..<nums.count {
            array[i] = max(nums[i] + array[i - 2], array[i - 1])
        }
        return array[nums.count - 1]
    }
}
