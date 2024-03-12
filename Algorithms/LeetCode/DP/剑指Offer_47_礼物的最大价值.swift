//
//  剑指Offer_47_礼物的最大价值.swift
//  Algorithms
//
//  Created by sheng on 2022/9/21.
//

import Foundation
// https://leetcode.cn/problems/li-wu-de-zui-da-jie-zhi-lcof/

class MaxValue {
    func maxValue(_ grid: [[Int]]) -> Int {
        let rows = grid.count
        let cols = grid[0].count
        var dp = Array(repeating: Array(repeating: 0, count: cols), count: rows)
        
        // 第 0 行
        dp[0][0] = grid[0][0]
        for col in 1..<cols {
            dp[0][col] = dp[0][col - 1] + grid[0][col]
        }
        
        // 第 0 列
        for row in 1..<rows {
            dp[row][0] = dp[row - 1][0] + grid[row][0]
        }
        // 其余
        for row in 1..<rows {
            for col in 1..<cols{
                dp[row][col] = max(dp[row][col - 1], dp[row - 1][col]) + grid[row][col]
            }
        }
        return dp[rows - 1][cols - 1]
    }
    #warning("优化成一维数组")
    
}
