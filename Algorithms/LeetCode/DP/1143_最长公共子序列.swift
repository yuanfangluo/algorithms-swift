//
//  1143_最长公共子序列.swift
//  Algorithms
//
//  Created by sheng on 2022/9/15.
//

import Foundation
// https://leetcode.cn/problems/longest-common-subsequence/
/**
 dp(i, j)是text1前i个元素与text2前j个元素的最长公共子序列长度
 i ∈ [0, text1.length]
 j ∈ [0, text2.length]
 dp(i, 0) 和 dp(0, j) 初始值为0
 */

class LCS: Runnable {
    func run() {
        print(lcs("ABCBDAB", "BDCABA"))
    }
    
    func lcs(_ text1: String, _ text2: String) -> Int {
        lcs5(text1, text2)
    }
    
    // 方法五：一维数组再次优化，一维数组的长度为两个字符串较小的长度
    func lcs5(_ text1: String, _ text2: String) -> Int {
        if text1.isEmpty || text2.isEmpty {
            return 0
        }
        var rowText: [Character] = []
        var colText: [Character] = []
        
        if text1.count > text2.count {
            colText = Array(text2)
            rowText = Array(text1)
        } else {
            colText = Array(text1)
            rowText = Array(text2)
        }
        
        var dp =  Array(repeating: 0, count: colText.count + 1)
        for i in 1...rowText.count {
            var cur = 0
            for j in 1...colText.count {
                let leftTop = cur
                cur = dp[j] // 保存给之后使用
                if rowText[i - 1] == colText[j - 1] {
                    dp[j] = leftTop + 1
                } else {
                    dp[j] = max(dp[j], dp[j - 1])
                }
            }
        }
        return dp[colText.count]
    }
    
    // 方法四：一维数组
    func lcs4(_ text1: String, _ text2: String) -> Int {
        if text1.isEmpty || text2.isEmpty {
            return 0
        }
        let chars1 = Array(text1)
        let chars2 = Array(text2)
        var dp =  Array(repeating: 0, count: chars2.count + 1)
        for i in 1...chars1.count {
            var cur = 0
            for j in 1...chars2.count {
                let leftTop = cur
                cur = dp[j] // 保存给之后使用
                if chars1[i - 1] == chars2[j - 1] {
                    dp[j] = leftTop + 1
                } else {
                    dp[j] = max(dp[j], dp[j - 1])
                }
            }
        }
        return dp[chars2.count]
    }
    
    
//    方法三：实际上每次只用到两行，使用滚动数组
    func lcs3(_ text1: String, _ text2: String) -> Int {
        if text1.isEmpty || text2.isEmpty {
            return 0
        }
        let chars1 = Array(text1)
        let chars2 = Array(text2)
        var dp = Array(repeating: Array(repeating: 0, count: chars2.count + 1), count: 2)
        for i in 1...chars1.count {
//            var row = i % 2
            let row = i & 1
//            var prevRow = (i - 1)%2
            let prevRow = (i - 1) & 1
            for j in 1...chars2.count {
                if chars1[i - 1] == chars2[j - 1] {
                    dp[row][j] = dp[prevRow][j - 1] + 1
                } else {
                  dp[row][j] = max(dp[prevRow][j], dp[row][j - 1])
                }
            }
        }
//        return dp[chars1.count % 2][chars2.count]
        return dp[chars1.count & 1][chars2.count]
    }
    
    
    
    // 方法二：动态规划
    // 空间复杂度：O(n * m)
    // 时间复杂度：O(n * m)
//    其中，m、n分别是text1和text2的字符串长度
    func lcs2(_ text1: String, _ text2: String) -> Int {
        if text1.isEmpty || text2.isEmpty {
            return 0
        }
        let chars1 = Array(text1)
        let chars2 = Array(text2)
        var dp = Array(repeating: Array(repeating: 0, count: text2.count + 1), count: text1.count + 1)
        for i in 1...chars1.count {
            for j in 1...chars2.count {
                if chars1[i - 1] == chars2[j - 1] {
                    dp[i][j] = dp[i - 1][j - 1] + 1
                } else {
                  dp[i][j] = max(dp[i - 1][j], dp[i][j - 1])
                }
            }
        }
        return dp[chars1.count][chars2.count]
    }
    
    // 方法一：递归
    /**
        时间复杂度：
        空间复杂度
     */
    func lcs1(_ text1: String, _ text2: String) -> Int {
        if text1.isEmpty || text2.isEmpty {
            return 0
        }
        return lcs1(text1, text1.count, text2, text2.count)
    }
    
    /// 求text1前index为i个元素和text2前index为j个元素的LCS的长度
    func lcs1(_ text1: String, _ i: Int, _ text2: String, _ j: Int) -> Int {
        if i == 0 || j == 0 {
            return 0
        }
        
        let chars1 = Array(text1)
        let chars2 = Array(text2)
        
        if chars1[i - 1] == chars2[j - 1] {
            return lcs1(text1, i - 1, text2, j - 1) + 1
        }
        
        return max(lcs1(text1, i - 1, text2, j),
                   lcs1(text1, i, text2, j - 1))
    }
}
