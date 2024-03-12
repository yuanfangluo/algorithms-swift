//
//  Sequence.swift
//  Algorithms
//
//  Created by sheng on 2022/9/18.
//

import Foundation
// 这里的串是字符串
/**
 前缀：prefix
 真前缀：proper prefix
 后缀：suffix
 真后缀：proper suffix
 
 串匹配算法：查找一个模式串（pattern）在文本串（text）中的位置
 几个经典的串匹配算法：
 - 蛮力（Brute force）
 - KMP算法
 - Boyer-Moore
 - Rabin-Karp
 - Sunday
 
 蛮力算法：
 以字符为单位，从左到右移动模式串，直到匹配成功：
 - 蛮力1：
n是文本串长度，m是模式串长度
 最好情况：比较一轮就完全匹配成功，时间复杂度是O(m)
 最坏情况：比较 n-m +1 轮，每轮都比较至模式串的末字符后失败，（m-1次成功，1次失败）
 时间复杂度是O( m * ( n - m + 1))由于m远小于n，所以是O(mn)
 - KMP算法
 */
class BruteForce01: Runnable {
    func run() {
      print(indexOf2("hello world", "or"))
    }
    
    // 方法二：优化，在恰当的时候可以提前退出，减少比较次数
    func indexOf2(_ text: String, _ pattern: String) -> Int {
        if text.isEmpty || pattern.isEmpty {
            return -1
        }
        
        let textChars: [Character] = Array(text)
        let patternChars: [Character] = Array(pattern)
        let tlen = textChars.count
        let plen = patternChars.count
        if tlen < plen {
            return -1
        }
        
        var pi = 0, ti = 0, lenDelta = tlen - plen
        
        while pi < plen && ((ti - pi) <= lenDelta){
            if textChars[ti] == patternChars[pi] {
                ti += 1
                pi += 1
            } else {
                ti -= pi - 1
                pi = 0
            }
        }
        
        return (pi == plen) ? (ti - pi) : -1
    }
    
    
    // 方法一：正常逻辑
    func indexOf1(_ text: String, _ pattern: String) -> Int {
        if text.isEmpty || pattern.isEmpty {
            return -1
        }
        
        let textChars: [Character] = Array(text)
        let patternChars: [Character] = Array(pattern)
        let tlen = textChars.count
        let plen = patternChars.count
        if tlen < plen {
            return -1
        }
        
        var pi = 0, ti = 0
        
        while pi < plen && ti < tlen {
            if textChars[ti] == patternChars[pi] {
                ti += 1
                pi += 1
            } else {
                ti -= pi - 1
                pi = 0
            }
        }
        
        return (pi == plen) ? (ti - pi) : -1
    }
}

// 另一种实现的思路：
class BruteForce02: Runnable {
    func run() {
        print(indexOf1("hello world", "or"))
    }
    
    func indexOf1(_ text: String, _ pattern: String) -> Int {
        if text.isEmpty || pattern.isEmpty {
            return -1
        }
        
        let textChars: [Character] = Array(text)
        let patternChars: [Character] = Array(pattern)
        let tlen = textChars.count
        let plen = patternChars.count
        if tlen < plen {
            return -1
        }
        // 这里ti是指每一轮比较中text首个比较字符的位置
        let tiMax = tlen - plen
        for ti in 0...tiMax {
            var pi = 0
            while pi<plen {
                if textChars[ti + pi] != patternChars[pi] {
                    break
                } else{
                   pi += 1
                }
            }
            if pi == plen {
                return ti
            }
        }
        return -1
    }
}

// KMP算法
/**
 对比蛮力算法，KMP的精妙之处：充分利用了此前比较过的内容，可以很聪明地跳过一些没有必要比较的位置
 
 真前缀，真后缀的最大公共子串长度：
 
 KMP主逻辑：
 最好时间复杂度：O(m)
 最坏时间复杂度：O(n)，不超过 O(2n)
 
 next表构造：
 时间复杂度：O(m)
 
 KMP整体：
 最好时间复杂度：O(m)
 最坏时间复杂度：O(n+m)
 空间复杂度：O(m)
 */

class KMP: Runnable {
    func run() {
        print(indexOf("hello world", "or"))
    }
    
    func indexOf(_ text: String, _ pattern: String) -> Int {
        if text.isEmpty || pattern.isEmpty {
            return -1
        }
        
        let textChars: [Character] = Array(text)
        let patternChars: [Character] = Array(pattern)
        let tlen = textChars.count
        let plen = patternChars.count
        if tlen < plen {
            return -1
        }
        
        var pi = 0, ti = 0, lenDelta = tlen - plen
        
        let next: [Int] = next2(pattern)
        
        while pi < plen && ((ti - pi) <= lenDelta){
            if pi<0 || textChars[ti] == patternChars[pi] {
                ti += 1
                pi += 1
            } else {
              pi = next[pi]
            }
        }
        return (pi == plen) ? (ti - pi) : -1
    }
    
    func next(_ pattern: String) -> [Int] {
        let chars: [Character] = Array(pattern)
        var next: [Int] = Array(repeating: 0, count: chars.count)
        var i = 0
        next[0] = -1
        var n = -1
        let iMax = chars.count - 1
        while i < iMax {
            if n < 0 || chars[i] == chars[n] {
                i += 1
                n += 1
                next[i] = n
            } else {
                n = next[n]
            }
        }
        return next
    }
    
    // 优化
    func next2(_ pattern: String) -> [Int] {
        let chars: [Character] = Array(pattern)
        var next: [Int] = Array(repeating: 0, count: chars.count)
        var i = 0
        next[0] = -1
        var n = -1
        let iMax = chars.count - 1
        while i < iMax {
            if n < 0 || chars[i] == chars[n] {
                i += 1
                n += 1
                if chars[i] == chars[n] {
                    next[i] = next[n]
                } else {
                    next[i] = n
                }
            } else {
                n = next[n]
            }
        }
        return next
    }
}
