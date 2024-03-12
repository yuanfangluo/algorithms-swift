//
//  198_打家劫舍.swift
//  Algorithms
//
//  Created by sheng on 2022/9/22.
//

import Foundation
// https://leetcode.cn/problems/house-robber/

class HouseRobber {
    func rob(_ nums: [Int]) -> Int {
        
        0
    }
    // 思路1：递归，从前往后偷
    // 和斐波那契数列一样，时间复杂度是O(2^n)，空间复杂度是：O(n)
    func rob1(_ nums: [Int]) -> Int {
        if nums.isEmpty {
            return 0
        }
        return rob(nums, 0)
    }
    // 从begin号房子开始偷
    func rob(_ nums: [Int], _ begin: Int) -> Int {
        if begin == nums.count - 1 {
            // 从最后一个开始偷，肯定是要有的
            return nums[begin]
        }
        
        if begin == nums.count - 2 {
            // 从倒数第二个开始偷，要么投倒数第二个，要么偷倒数第一个
            return max(nums[begin], nums[begin + 1])
        }
        
        let robCur = nums[begin] + rob(nums, begin + 2)
        let robNext = rob(nums, begin + 1)
        return max(robCur, robNext)
    }
    
    // 思路2：递归，从后往前偷
    // 和斐波那契数列一样，时间复杂度是O(2^n)，空间复杂度是：O(n)
    func rob2(_ nums: [Int]) -> Int {
        if nums.isEmpty {
            return 0
        }
        
        return rob2(nums, nums.count - 1)
    }
    
    // 从begin号房子开始偷
    func rob2(_ nums: [Int], _ begin: Int) -> Int {
        if begin == 0 {
            // 从第一个开始往前偷，肯定是要有的
            return nums[0]
        }
        
        if begin == 1 {
            // 从第二个开始往前偷，要么偷第二个，要么偷第一个
            return max(nums[0], nums[1])
        }
        
        let robCur = nums[begin] + rob(nums, begin - 2)
        let robNext = rob(nums, begin - 1)
        return max(robCur, robNext)
    }
    
    // 思路3：非递归，使用dp
    // 利用数组存放前n个房屋的最高偷窃金额
    // 时间复杂度，空间复杂度是O(n)
    func rob3(_ nums: [Int]) -> Int {
        if nums.isEmpty {
            return 0
        }
        
        if nums.count == 1 {
            return nums[0]
        }
        
        // nums.count >= 2
        
        var array = Array(repeating: 0, count: nums.count)
        array[0] = nums[0]
        array[1] = max(nums[0], nums[1])
        for i in 2..<nums.count {
            array[i] = max(nums[i] + array[i - 2], array[i - 1])
        }
        
        return array[nums.count - 1]
    }
    
    // 思路4：可以优化一下空间复杂度
    // 时间复杂度是O(n)，空间复杂度是O(1)
    func rob4(_ nums: [Int]) -> Int {
        if nums.isEmpty {
            return 0
        }
        
        if nums.count == 1 {
            return nums[0]
        }
        
        // nums.count >= 2
        var prev = nums[0]
        var cur = max(nums[0], nums[1])
        for i in 2..<nums.count {
            let tmp = cur
            cur = max(nums[i] + prev, cur)
            prev = tmp
        }
        return cur
    }
    
    // 针对思路4，换一种写法
    // 时间复杂度是O(n)，空间复杂度是O(1)
    func rob5(_ nums: [Int]) -> Int {
        if nums.isEmpty {
            return 0
        }
        var prev = 0
        var cur = 0
        for num in nums {
            let tmp = cur
            cur = max(num + prev, cur)
            prev = tmp
        }
        return cur
    }
}
