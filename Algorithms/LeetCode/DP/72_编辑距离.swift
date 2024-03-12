//
//  72_编辑距离.swift
//  Algorithms
//
//  Created by sheng on 2022/9/21.
//

import Foundation
// https://leetcode.cn/problems/edit-distance/

class EditDistance: Runnable {
    
    func run() {
        print(minDistance("mice", "arise"))
    }
    
    #warning("优化成一维数组")
    
    // 动态规划
   private func minDistance(_ word1: String, _ word2: String) -> Int {
       if word1.isEmpty {
           return word2.count
       }
       
       if word2.isEmpty {
           return word1.count
       }
       
        let chars1: [Character] = Array(word1)
        let chars2: [Character] = Array(word2)
        let rows = chars1.count
        let cols = chars2.count
        
        var dp = Array(repeating: Array(repeating: 0, count: cols + 1), count: rows + 1)
        
        dp[0][0] = 0
        // 第 0 列
       for row in 1...rows {
            dp[row][0] = row
        }
        
        // 第 0 行
       for col in 1...cols {
            dp[0][col] = col
        }
        
        // 其他
       for row in 1...rows {
           for col in 1...cols {
                let top = dp[row - 1][col] + 1
                let left = dp[row][col - 1] + 1
                var leftTop = dp[row - 1][col - 1]
                if chars1[row - 1] != chars2[col - 1] {
                    leftTop += 1
                }
                dp[row][col] = min(top, left, leftTop)
            }
        }
        return dp[rows][cols]
    }
}
