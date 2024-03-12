//
//  5_最长回文子串.swift
//  Algorithms
//
//  Created by sheng on 2022/9/21.
//

import Foundation

// https://leetcode.cn/problems/longest-palindromic-substring/



class LongestPalindromicSubstring: Runnable {
    func run() {
        print(longestPalindrome5("abbaba"))
    }
    
    // 方法六：马拉车算法
    func longestPalindrome6(_ s: String) -> String {
        return ""
    }
    
    // 方法五：以一串连续相同字符串为控制中心
    func longestPalindrome5(_ s: String) -> String {
        if s.count <= 1 {
            return s
        }
        
        let chars: [Character] = Array(s)
        let count = chars.count
        var begin = 0
        var maxLen = 1
        
        var i = 0
        var nextI = 0
        while i < count {
            var r = i + 1
            // 找出右边第一个不等于chars[i]的位置
            while r < count && chars[i] == chars[r] {
                r += 1
            }
            
            // r会成为新的i
            nextI = r
            
            // 从l向左, r 向右
            var l = i - 1
            while l >= 0 && r < count && chars[l] == chars[r] {
                l -= 1
                r += 1
            }
            
            // 扩展结束后, chars(l, r)就是最长的回文串
            // 开始索引
            let curB = l + 1
            
            // 当前长度
            let curLen = r - curB
            
            if curLen > maxLen {
                maxLen = curLen
                begin = curB
            }
            i = nextI
        }
        return s.substring(begin, maxLen)
    }

    
    // 方法四：扩展中心法
    func longestPalindrome4(_ s: String) -> String {
        if s.count <= 1 {
            return s
        }
        let chars: [Character] = Array(s)
        let count = chars.count
        var begin = 0
        var maxLen = 1
        for i in stride(from: count - 2, through: 1, by: -1) {
            
            // 以字符为中心
            let len1 = palindromeLength(chars, i - 1, i + 1)
            // 以字符右边间隙为中心
            let len2 = palindromeLength(chars, i, i + 1)
            
            let max12 = max(len1, len2)
            if max12 > maxLen {
                maxLen = max12
                begin = i - (maxLen - 1) >> 1
            }
        }
        
        // 处理0号字符右边的间隙为中心
        if chars[0] == chars[1] && maxLen < 2 {
            begin = 0
            maxLen = 2
        }
        
        return s.substring(begin, maxLen) 
    }
    
    func palindromeLength(_ chars: [Character], _ l: Int, _ r: Int) -> Int {
        
        var li = l
        var ri = r
        while li >= 0 && ri < chars.count && chars[li] == chars[ri] {
            li -= 1
            ri += 1
        }
        return ri - li - 1
    }
    #warning("优化成一维数组")
    // 方法三：动态规划改为一维数组
    func longestPalindrome3(_ s: String) -> String {
        
        return ""
    }
    
    // 方法二：动态规划:实际上是动态规划的优化
    func longestPalindrome2(_ s: String) -> String {
        if s.isEmpty {
            return ""
        }
        let chars: [Character] = Array(s)
        let count = chars.count
        var dp = Array(repeating: Array(repeating: false, count: count), count: count)
        var begin = 0
        var maxLen = 1
        
        for i in stride(from: count - 1, through: 0, by: -1) {
            for j in i..<count {
                let len = j - i + 1
                
                if len <= 2 {
                    dp[i][j] = (chars[i] == chars[j])
                } else {
                    dp[i][j] = (chars[i] == chars[j]) && dp[i + 1][j - 1]
                }
                
                if dp[i][j] { // 当为回文串的时候需要比较一下当前长度和之前的最大长度
                    if len > maxLen { // 如果当前长度大于最大长度，需要修改最大长度
                        begin = i
                        maxLen = len
                    }
                }
            }
        }
        return s.substring(begin, maxLen) 
    }
    
    // 方法一：暴力法
    func longestPalindrome(_ s: String) -> String {
        
        return ""
    }
}
