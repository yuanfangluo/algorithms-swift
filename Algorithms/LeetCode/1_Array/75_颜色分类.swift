//
//  75_颜色分类.swift
//  Algorithms
//
//  Created by sheng on 2022/9/19.
//

import Foundation
// https://leetcode.cn/problems/sort-colors/
/**
 套路：要求原地排序，扫描一遍，通常是双指针，甚至有时候是三指针
 这里使用三指针
 */
class SortColors: Runnable {
    func run() {
        var nums = [1, 2, 0, 2, 1, 0]
        sortColors(&nums)
        print(nums)
    }
    
    func sortColors(_ nums: inout [Int]) {
        var i = 0
        var l = 0
        var r = nums.count - 1
        while i <= r {
            let num = nums[i]
            if num == 0 {
                swap(&nums, i, l)
                l += 1
                i += 1
            } else if num == 1 {
                i += 1
            } else { // num == 2
                swap(&nums, i, r)
                r -= 1
            }
        }
    }
    
    func swap(_ nums: inout [Int], _ i: Int, _ j: Int) {
        let tmp = nums[i]
        nums[i] = nums[j]
        nums[j] = tmp
    }
}
