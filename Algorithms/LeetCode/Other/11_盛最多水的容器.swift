//
//  11_盛最多水的容器.swift
//  Algorithms
//
//  Created by sheng on 2022/10/14.
//

import Foundation
// https://leetcode.cn/problems/container-with-most-water/
// 双指针
class ContainerWithMostWater: Runnable {
    
    func run() {
        print(maxArea([1, 8, 6, 2, 5, 4, 8, 3, 7]))
    }
    
    private func maxArea(_ height: [Int]) -> Int {
        if height.isEmpty {
            return 0
        }
        var l = 0
        var r = height.count - 1
        var lh = height[l]
        var rh = height[r]
        var maxWater = (r - l) * min(lh, rh)
        while l < r {
            if height[l] < height[r] {
                l += 1
                if height[l] > lh {
                    // 到这里更新左边最高高度
                    lh = height[l]
                    maxWater = max((r - l) * min(lh, height[r]), maxWater)
                }
            } else {
                r -= 1
                if height[r] > rh {
                    // 到这里更新右边最高高度
                    rh = height[r]
                    maxWater = max((r - l) * min(height[l], rh), maxWater)
                }
            }
        }
        return maxWater
    }
}
