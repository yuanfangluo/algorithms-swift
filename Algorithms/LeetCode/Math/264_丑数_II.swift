//
//  264_丑数_II.swift
//  Algorithms
//
//  Created by sheng on 2022/10/29.
//

import Foundation

// https://leetcode.cn/problems/ugly-number-ii/?show=1

class NthUglyNumber: Runnable {
    
    func run() {
        print(nthUglyNumber(1))
    }
    
    /**
     首先，我在前文 如何高效寻找质数 中也讲过高效筛选质数的「筛数法」：一个质数和除 1 以外的其他数字的乘积一定不是质数，把这些数字筛掉，剩下的就是质数。
     
     基于筛数法的思路和丑数的定义，我们不难想到这样一个规律：如果一个数x是丑数，那么x * 2, x * 3, x * 5都一定是丑数。
     
     如果我们把所有丑数想象成一个从小到大排序的链表，就是这个样子：
     1 -> 2 -> 3 -> 4 -> 5 -> 6 -> 8 -> ...
     
     然后，我们可以把丑数分为三类：2 的倍数、3 的倍数、5 的倍数。这三类丑数就好像三条有序链表，如下：
    
     能被 2 整除的丑数：
     1*2 -> 2*2 -> 3*2 -> 4*2 -> 5*2 -> 6*2 -> 8*2 ->...

     能被 3 整除的丑数：
     1*3 -> 2*3 -> 3*3 -> 4*3 -> 5*3 -> 6*3 -> 8*3 ->...
     
     能被 5 整除的丑数：
     1*5 -> 2*5 -> 3*5 -> 4*5 -> 5*5 -> 6*5 -> 8*5 ->...
     
     我们如果把这三条「有序链表」合并在一起并去重，得到的就是丑数的序列，其中第n个元素就是题目想要的答案：
     1 -> 1*2 -> 1*3 -> 2*2 -> 1*5 -> 3*2 -> 4*2 ->...
     
     所以这里就和链表双指针技巧汇总中讲到的合并两条有序链表的思路基本一样了
     
     类比合并两个有序链表，看下这道题的解法代码：
     */
    
    // 我们用p2, p3, p5分别代表三条丑数链表上的指针，用product2, product3, product5代表丑数链表上节点的值，用ugly数组记录有序链表合并之后的结果
    func nthUglyNumber(_ n: Int) -> Int {
        // 可以理解为三个指向有序链表头结点的指针
        var p2 = 1
        var p3 = 1
        var p5 = 1
        
        // 可以理解为三个有序链表的头节点的值
        var product2 = 1
        var product3 = 1
        var product5 = 1
        
        // 可以理解为最终合并的有序链表（结果链表）
        var ugly = Array(repeating: 0, count: n + 1)
        
        // 可以理解为结果链表上的指针
        var p = 1
        
        // 开始合并三个有序链表，找到第 n 个丑数时结束
        
        while p <= n {
            // 取三个链表的最小结点
            let minV = min(product2, product3, product5)
            // 将最小节点接到结果链表上
            ugly[p] = minV
            p += 1
            
            // 前进对于有序链表上的指针
            if (minV == product2) {
                product2 = 2 * ugly[p2]
                p2 += 1
            }
            
            if (minV == product3) {
                product3 = 3 * ugly[p3]
                p3 += 1
            }
            
            if (minV == product5) {
                product5 = 5 * ugly[p5]
                p5 += 1
            }
            
        }

        // 返回第 n 个质数
        return ugly[n]
    }
    
    // 动态规划
    func nthUglyNumber2(_ n: Int) -> Int {
        
        if n == 1 {
            return 1
        }
        
        var dp = Array(repeating: 0, count: n + 1)
        dp[1] = 1
        
        var p2 = 1
        var p3 = 1
        var p5 = 1
        
        for i in 2...n {
            
            let num2 = dp[p2] * 2
            let num3 = dp[p3] * 3
            let num5 = dp[p5] * 5
            
            dp[i] = min(num2, num3, num5)
            
            if dp[i] == num2 {
                p2 += 1
            }
            if dp[i] == num3 {
                p3 += 1
            }
            if dp[i] == num5 {
                p5 += 1
            }
        }
        return dp[n]
    }
}
