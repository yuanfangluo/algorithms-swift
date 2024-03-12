//
//  42_接雨水.swift
//  Algorithms
//
//  Created by sheng on 2022/10/16.
//

import Foundation
// https://leetcode.cn/problems/trapping-rain-water/
// 思路：计算每一根柱子上有多少水
// 取决于：min(左边柱子的最大高度，右边柱子的最大高度)
// 最小值 - 本身柱子的高度 = 当前柱子可以接的雨水
class TrappingRainWater: Runnable {
    
    func run() {
        print(trap([0, 1, 0, 2, 1, 0, 1, 3, 2, 1, 2, 1]),trap([0]))
    }
    
    private func trap(_ height: [Int]) -> Int {
        if height.count <= 1 {
            return 0
        }
        var leftMaxes = Array(repeating: 0, count: height.count)
        let lastIdx = height.count - 2
        for i in 1...lastIdx {
            // 如果要求i位置的左边的最大值，需要比较 i-1位置的值和 i-1 位置的左边的最大值
            leftMaxes[i] = max(leftMaxes[i - 1], height[i - 1])
        }
        
        var rightMaxes = Array(repeating: 0, count: height.count)
        for i in stride(from: lastIdx, through: 1, by: -1) {
            rightMaxes[i] = max(rightMaxes[i + 1], height[i + 1])
        }
        
        //       print(leftMaxes, rightMaxes)
        var water = 0
        for i in 1...lastIdx {
            let m = min(leftMaxes[i], rightMaxes[i])
            if m <= height[i] { // 最小的柱子 <= 本身的高度，是放不了水的
                continue
            }
            water += m - height[i]
        }
        
        return water
    }
}
