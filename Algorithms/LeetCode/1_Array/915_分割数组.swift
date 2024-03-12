//
//  915_分割数组.swift
//  Algorithms
//
//  Created by sheng on 2022/10/26.
//

import Foundation
// https://leetcode.cn/problems/partition-array-into-disjoint-intervals/

class PartitionDisjoint: Runnable {
    
    func run() {
        print(partitionDisjoint2([1,1,1,0,6,12]))
    }
    
    // 思路1：维护两个数组
    private func partitionDisjoint(_ nums: [Int]) -> Int {
        
        // maxArray[i]代表索引i之前的最大值
        var maxArray: [Int] = Array(repeating: nums[0], count: nums.count)
        // minArray[i]代表索引i之后的最小值
        var minArray: [Int] = Array(repeating: nums[nums.count - 1], count: nums.count)
        
        for i in 1..<nums.count {
            maxArray[i] = max(nums[i], maxArray[i - 1])
            let minI = (nums.count - 1) - i
            minArray[minI] = min(nums[minI], minArray[minI + 1])
        }
        
        print(maxArray, minArray)
        
        var resultIndex = 0
        for i in 0..<nums.count - 1 {
            if maxArray[i] <= minArray[i + 1] {
                resultIndex = i
                break
            }
        }
        
        return resultIndex + 1
    }
    
    // 思路2：先算出右边数组，然后从左到右计算出最大值和右边数组的元素比较
    private func partitionDisjoint2(_ nums: [Int]) -> Int {
        
        // 1. 先求出右边数组
        var rightArray = Array(repeating: nums[nums.count - 1], count: nums.count)
        for i in stride(from: nums.count - 1 - 1, through: 0, by: -1) {
            rightArray[i] = min(nums[i], rightArray[i + 1])
        }
        
        print(rightArray)
        
        var resultIdx = 0
        var leftMax = nums[0]
        for i in 0..<nums.count - 1 {
            leftMax = max(leftMax, nums[i])
            if leftMax <= rightArray[i + 1] {
                resultIdx = i
                break
            }
        }
        return resultIdx + 1
    }
}
