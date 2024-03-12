//
//  47_全排列II.swift
//  Algorithms
//
//  Created by sheng on 2022/9/9.
//

import Foundation
// https://leetcode.cn/problems/permutations-ii/

class PermutationsII {
    func run() {
        print(permuteUnique([1, 1, 2]))
    }
    
    var list: [[Int]] = []
    var nums: [Int] = []
    
    func permuteUnique(_ nums: [Int]) -> [[Int]] {
        if nums.isEmpty {
            return list
        }
        self.nums = nums
        dfs(0)
        return list
    }
    
    func dfs(_ idx: Int) {
        // 不能再往下搜索
        if idx == nums.count {
            list.append(nums)
            return
        }
        
        // 枚举这一层所有可以做出的选择
        for i in idx..<nums.count {
            // 保证一个数字在idx位置只会出现一次
            if isRepeat(idx, i) {
                continue
            }
            swap(idx, j: i)
            dfs(idx + 1)
            swap(idx, j: i)
        }
    }
    
    func isRepeat(_ idx: Int, _ i: Int) -> Bool {
        for j in idx..<i {
            if nums[j] == nums[i] {
                return true
            }
        }
        return false
    }
    
    func swap(_ i: Int, j: Int) {
        let tmp = nums[i]
        nums[i] = nums[j]
        nums[j] = tmp
    }
}
