//
//  15_三数之和.swift
//  Algorithms
//
//  Created by sheng on 2022/10/12.
//

import Foundation
// https://leetcode.cn/problems/3sum/

class ThreeSum: Runnable {
    
    func run() {
        print(threeSum([-1, 0, 1, 2, -1, -4]))
    }
    
    private func threeSum(_ ns: [Int]) -> [[Int]] {
        var list: [[Int]] = []
        let nums = ns.sorted()
        let lastIdx = nums.count - 3
        let lastR = nums.count - 1
        for i in 0...lastIdx {
            
            // 首先针对经过排序之后，如果相等，肯定是相邻的
            if i > 0 && nums[i] == nums[i - 1] {
                continue
            }
            
            var l = i + 1, r = lastR, remain = -nums[i]
            while l < r {
                let sumLR = nums[l] + nums[r]
                if sumLR == remain { // 相等
                    list.append([nums[i], nums[l], nums[r]])
                    // 跳过相同的值
                    while l < r && nums[l] == nums[l + 1] {
                        l += 1
                    }
                    
                    while l < r && nums[r] == nums[r - 1] {
                        r += -1
                    }
                    
                    // 往中间逼近
                    l += 1
                    r += -1
                } else if sumLR < remain { // 左右之和小于剩余，需要变大
                    l += 1
                } else { // 左右之和大于剩余，需要变小
                    r -= 1
                }
            }
        }
        return list
    }
}
