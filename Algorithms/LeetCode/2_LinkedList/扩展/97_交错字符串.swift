//
//  97_交错字符串.swift
//  Algorithms
//
//  Created by sheng on 2022/11/1.
//

import Foundation
// https://leetcode.cn/problems/interleaving-string/?show=1


/**
 实则就是一个使用双指针技巧合并两个字符串的过程：
 
 int i = 0, j = 0, k = 0;
 for (int k = 0; k < s3.length; k++) {
     if (s1[i] == s3[k]) {
         i++;
     } else if (s2[j] == s3[k]) {
         j++;
     }
 }
 
 但本题跟普通的数组/链表双指针技巧不同的是，这里需要穷举所有情况。
 
 比如 s1[i], s2[j] 都能匹配 s3[k] 的时候，到底应该让谁来匹配，才能完全合并出 s3 呢？
 
 回答这个问题很简单，我不知道让谁来，那就都来试一遍好了，前文 经典动态规划：最长公共子序列 和 经典动态规划：编辑距离 都处理过类似的情况。
 
 所以本题肯定需要一个递归函数来穷举双指针的匹配过程，然后用一个备忘录消除递归过程中的重叠子问题，也就能写出自顶向下的递归的动态规划解法了

 
 */
class IsInterleave: Runnable {
    
    func run() {
        print(isInterleave("aabcc", "dbbca", "aadbbcbcac"))
    }
    
    var memo: [[Int]] = []
    
    func isInterleave(_ s1: String, _ s2: String, _ s3: String) -> Bool {
        
        let m = s1.count
        let n = s2.count
        
        // 如果长度对不上，肯定不可能
        if m + n != s3.count {
            return false
        }
        
        // 备忘录，其中-1代表为计算，0代表false，1代表true
        memo = Array(repeating: Array(repeating: -1, count: n + 1), count: m + 1)
        
        return dp(s1, 0, s2, 0, s3)
    }
    
    
    
    // 函数定义：计算 s1[i...] 和s2[j...] 是否能组合出 s3[i+j...]
    func dp(_ s1: String, _ i: Int, _ s2: String, _ j: Int, _ s3: String) -> Bool {
        
        let k = i + j
        if k == s3.count {
            return true
        }
        
        // 查看备忘录，如果已经计算过，直接返回
        if memo[i][j] != -1 {
            return memo[i][j] == 1
        }
        
        var res = false
        
        // 如果 s1[i] 可以匹配 s3[k]，那么填入 s1[i] 试一下

        if i < s1.count && s1.substring(i, 1) == s3.substring(k, 1) {
            res = dp(s1, i + 1, s2, j, s3)
        }
        
        // 如果 s1[i] 不可以匹配 s3[k]，那么填入 s2[j] 试一下
        if j < s2.count && s2.substring(j, 1) == s3.substring(k, 1) {
            res = res || dp(s1, i, s2, j + 1, s3)
        }
        
        // 如果 s1[i] 和 s2[j] 都匹配不了，那么返回 false
        memo[i][j] = res ? 1 : 0
        
        return res
    }
}
