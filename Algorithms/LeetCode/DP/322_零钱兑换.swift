//
//  322_零钱兑换.swift
//  Algorithms
//
//  Created by sheng on 2022/9/13.
//

import Foundation
// https://leetcode.cn/problems/coin-change/
// 面试题 08.11. 硬币: https://leetcode.cn/problems/coin-lcci/
class CoinChange: Runnable {
    func coinChange(_ faces: [Int], _ n: Int) -> Int {
        if n == 0 {
            return 0
        }
        
        var dp = Array(repeating: 0, count: n + 1)
        for i in 1...n {
            var minValue = Int.max
            for face in faces {
//                if i >= face {
//                    minValue = min(dp[i - face], minValue)
//                }
                if i < face || dp[i - face] == -1 {
                    continue
                }
                minValue = min(dp[i - face], minValue)
            }
            if minValue == Int.max {
                dp[i] = -1
            } else {
                dp[i] = minValue + 1
            }
        }
        return dp[n]
    }
    
    func run() {
        print(coinChange([1, 5, 10, 25], 41))
    }
//    方法一： 暴力递归,自顶向下，出现了重叠子问题
    func coins1(_ n: Int) -> Int {
        if n < 1 {
            return Int.max
        }
        if n == 25 || n == 20 || n == 5 || n == 1 {
            return 1
        }
        return min(coins1( n - 25), coins1( n - 20), coins1( n - 5), coins1( n - 1)) + 1
    }
    
    
// 方法二：记忆化搜索（自顶向下的调用）
    func coins2(_ n: Int) -> Int {
        if n < 1 {
            return -1
        }
        /// 凑到n分需要的最少硬币个数
        var dp = Array(repeating: 0, count: n + 1)
        for face in [1, 5, 20, 25] {
            if n < face {
                break
            }
            dp[face] = 1
        }
        return coins2(n, &dp)
    }
    
    func coins2(_ n: Int, _ dp: inout [Int]) -> Int {
        if n < 1 {
            return Int.max
        }
        if dp[n] == 0 {
            dp[n] = min(coins1( n - 25), coins1( n - 20), coins1( n - 5), coins1( n - 1)) + 1
        }
        return dp[n]
    }
//    方法三：动态优化(自底向上的递推)
    func coins3(_ n: Int) -> Int {
        if n < 1 {
            return -1
        }
        var dp = Array(repeating: 0, count: n + 1)
        for i in 1...n {
            var minValue = Int.max
            if i >= 1 {
                minValue = min(dp[i - 1], minValue)
            }
            
            if i >= 5 {
                minValue = min(dp[i - 5], minValue)
            }
            
            if i >= 20 {
                minValue = min(dp[i - 20], minValue)
            }
            
            if i >= 25 {
                minValue = min(dp[i - 25], minValue)
            }
            
            dp[i] = minValue + 1
        }
        
        return dp[n]
    }
    
    //
    func coins4(_ n: Int) -> Int {
        if n < 1 {
            return -1
        }
        // 凑到n分需要的最少硬币个数
        var dp = Array(repeating: 0, count: n + 1)
        
        // faces[i] 是凑够i分时最后选择的那枚硬币的面值
        var faces = Array(repeating: 0, count: dp.count)
        for i in 1...n {
            var minValue = Int.max
            if i >= 1 && dp[i - 1] < minValue {
                minValue = dp[i - 1]
                faces[i] = 1
            }
            
            if i >= 5 && dp[i - 5] < minValue  {
                minValue = dp[i - 5]
                faces[i] = 5
            }
            
            if i >= 20 && dp[i - 20] < minValue  {
                minValue = dp[i - 20]
                faces[i] = 20
            }
            
            if i >= 25 && dp[i - 25] < minValue  {
                minValue = dp[i - 25]
                faces[i] = 25
            }
            
            dp[i] = minValue + 1
        }
        printResult(faces, n)
        return dp[n]
    }
    
    func printResult(_ faces: [Int], _ i: Int) {
        var n = i
        while n > 0 {
            print(faces[n])
            n -= faces[n]
        }
    }
    
}
