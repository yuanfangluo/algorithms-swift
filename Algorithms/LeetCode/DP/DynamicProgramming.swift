//
//  DynamicProgramming.swift
//  Algorithms
//
//  Created by sheng on 2022/9/13.
//

import Foundation

// 求解最优化问题的一种常用策略
/** 可以用动态规划来解决的问题通常具备两个特点：
 1. 最优子结构（最优化原理）
 2. 无后效性
 */

// 从起点（0，0）走到（4,4）一共有多少种走法，只能向右，向下



// 最长公共子串
/**
 dp(i, j) 是以 str1[i - 1]、str2[j - 1]结尾的最长公共子串长度
 
 如果str1[i -1] = str2[j - 1]，那么dp(i, j) = dp(i - 1, j - 1) + 1
 如果str1[i -1] != str2[j - 1]，那么dp(i, j) = 0
 
 最长公共子串的长度就是所有dp(i, j) 中的最大值 max{ dp(i, j) }
 */
class LCSubstring: Runnable {
    func run() {
        print(lcs3("ABCD", "BABC"))
    }
    
    // 方法三：从后往前算
    func lcs3(_ text1: String, _ text2: String) -> Int {
        if text1.isEmpty || text2.isEmpty {
            return 0
        }
        
        let chars1 = Array(text1)
        let chars2 = Array(text2)
        
        var colChars: [Character] = chars1
        var rowChars: [Character] = chars2
        
        if chars1.count > chars2.count {
            colChars = chars2
            rowChars = chars1
        }
        var dp = Array(repeating: 0, count: colChars.count + 1)
        var maxValue = 0
        for i in 1...rowChars.count {
            for j in stride(from: colChars.count, through: 1, by: -1) {
                if chars1[i - 1] == chars2[j - 1] {
                    dp[j] = dp[j - 1] + 1
                    maxValue = max(maxValue, dp[j])
                } else {
                    dp[j] = 0 // 发现不相等，需要重新为0
                }
            }
        }
        return maxValue
    }
    
    // 方法二：一维数组dp
    func lcs2(_ text1: String, _ text2: String) -> Int {
        if text1.isEmpty || text2.isEmpty {
            return 0
        }
        
        let chars1 = Array(text1)
        let chars2 = Array(text2)
        
        var colChars: [Character] = chars1
        var rowChars: [Character] = chars2
        
        if chars1.count > chars2.count {
            colChars = chars2
            rowChars = chars1
        }
        var dp = Array(repeating: 0, count: colChars.count + 1)
        var maxValue = 0
        for i in 1...rowChars.count {
            var cur = 0
            for j in 1...colChars.count {
                let leftTop = cur
                cur = dp[j]
                if chars1[i - 1] == chars2[j - 1] {
                    dp[j] = leftTop + 1
                    maxValue = max(maxValue, dp[j])
                } else {
                    dp[j] = 0 // 发现不相等，需要重新为0
                }
            }
        }
        return maxValue
    }
    
    // 方法一：二维数组dp
    func lcs1(_ text1: String, _ text2: String) -> Int {
        if text1.isEmpty || text2.isEmpty {
            return 0
        }
        let chars1 = Array(text1)
        let chars2 = Array(text2)
        var dp = Array(repeating: Array(repeating: 0, count: chars2.count + 1), count: chars1.count + 1)
        var maxValue = 0
        for i in 1...chars1.count {
            for j in 1...chars2.count {
                if chars1[i - 1] == chars2[j - 1] {
                    dp[i][j] = dp[i - 1][j - 1] + 1
                }
                maxValue = max(maxValue, dp[i][j])
            }
        }
        return maxValue
    }
}

// 0-1背包
class Knapsack1: Runnable {
    func run() {
        print(maxValueExactly([6, 3, 5, 4, 6], [2, 2, 6, 5, 4], 10))
    }
    
    // 恰好装满
    func maxValueExactly(_ values: [Int], _ weights: [Int], _ capacity: Int) -> Int {
        if values.isEmpty || weights.isEmpty || capacity <= 0 {
            return 0
        }
        var dp: [Int] = Array(repeating: 0, count: capacity + 1)
        // 不合理的值是负无穷
        for j in 1...capacity {
            dp[j] = Int.min
        }
        for i in 1...values.count {
            for j in stride(from: capacity, through: weights[i - 1], by: -1) {
                dp[j] = max(dp[j], values[i - 1] + dp[j - weights[i - 1]])
            }
        }
        
        return dp[capacity] < 0 ? -1 : dp[capacity]
    }
    
    //   方法三：j的下界改为weights[i - 1]
        func maxValue3(_ values: [Int], _ weights: [Int], _ capacity: Int) -> Int {
            if values.isEmpty || weights.isEmpty || capacity <= 0 {
                return 0
            }
            let n = values.count
            var dp = Array(repeating: 0, count: capacity + 1)
            for i in 1...n {
                for j in stride(from: capacity, through: weights[i - 1], by: -1) {
                    dp[j] = max(dp[j], values[i - 1] + dp[j - weights[i - 1]])
                }
            }
            return dp[capacity]
        }
    
//     方法二：优化成一维数组
    func maxValue2(_ values: [Int], _ weights: [Int], _ capacity: Int) -> Int {
        if values.isEmpty || weights.isEmpty || capacity <= 0 {
            return 0
        }
        let n = values.count
        var dp = Array(repeating: 0, count: capacity + 1)
        for i in 1...n {
            for j in stride(from: capacity, through: 1, by: -1) {
                if j < weights[i - 1] {
                    continue
                }
                dp[j] = max(dp[j], values[i - 1] + dp[j - weights[i - 1]])
            }
        }
        return dp[capacity]
    }
    /**
     分析：
     dp(3, 7) 是有前 3（也就是index为2） 件物品可选，最大承重为 7 的最大价值
     如果 j < weights[i - 1],那么dp(i, j) = dp(i - 1, j)
     如果 j >= weights[i - 1]，那么：
     （1）如果不选择第i个物品，dp(i, j) = dp(i - 1, j)
     （2）如果选择第 i 个物品，则 dp(i, j) = values[i-1] + dp[i - 1, j - weights[i-1]]
     最终:
     dp(i, j) = max {dp(i - 1, j),  values[i-1] + dp(i - 1, j - weights[i-1])}
     */
    func maxValue1(_ values: [Int], _ weights: [Int], _ capacity: Int) -> Int {
        if values.isEmpty || weights.isEmpty || capacity <= 0 {
            return 0
        }
        
        let n = values.count
        var dp = Array(repeating: Array(repeating: 0, count: capacity + 1), count: n + 1)
        
        for i in 1...n {
            for j in 1...capacity {
                if j < weights[i - 1] {
                    dp[i][j] = dp[i-1][j]
                } else {
                    dp[i][j] = max(dp[i - 1][j], values[i - 1] + dp[i - 1][j - weights[i - 1]])
                }
            }
        }

        return dp[values.count][capacity]
    }
}
