//
//  151_反转字符串中的单词.swift
//  Algorithms
//
//  Created by sheng on 2022/9/21.
//

import Foundation
// https://leetcode.cn/problems/reverse-words-in-a-string/
// 剑指 Offer 58 - I. 翻转单词顺序: https://leetcode.cn/problems/fan-zhuan-dan-ci-shun-xu-lcof/
class ReverseWords: Runnable {
    func run() {
        print(reverseWords("  hello world  "))
        print(reverseWords("   "))
    }
    
    func reverseWords(_ s: String) -> String {
        let removedSpacesString = s.trimmingCharacters(in: .whitespaces)
        if removedSpacesString.isEmpty {
            return ""
        }
        
        var chars: [Character] = Array(removedSpacesString)
        // 首先消除多余的空格
        // 字符串的有效长度
        var len = 0
        // 当前存放字符的位置
        var cur = 0
        // 前一个字符是否为空格
        var space  = true
        for i in 0..<chars.count {
            if chars[i] != Character(" ") { // chars[i] 是非空格字符
                chars[cur] = chars[i]
                cur += 1
                space = false
            } else if space == false { // chars[i] 是空格字符，并且前一个字符是非空格字符
                chars[cur] = Character(" ")
                cur += 1
                space = true
            }
        }
        
        // 如果最后一个字符是空格，那就cur - 1，如果不是空格，就是字符串的长度
        len  = space ? (cur - 1) : cur
        if len <= 0 {
            return ""
        }
        print(len)
        
        // 对整个有效字符串进行逆序
        reverse(&chars, 0, len)
        
        // 对每一个单词逆序
        // 前一个空格字符的位置
        var previousIdx = -1
        for i in 0..<len {
            if chars[i] != Character(" ") {
                continue
            }
            reverse(&chars, previousIdx + 1, i)
            previousIdx = i
        }
        
        // 翻转最后一个单词
        reverse(&chars, previousIdx + 1, len)
        
        // 截取字符串
        let str = String(chars)
        let index = str.index(str.startIndex, offsetBy: len)
        return String(str[..<index])
    }
    
    // 在 [li, ri) 范围内的字符串逆序
    private func reverse(_ chars: inout [Character], _ l: Int, _ r: Int) {
        var li = l
        var ri = r - 1
        while li < ri {
            let tmp = chars[li]
            chars[li] = chars[ri]
            chars[ri] = tmp
            li += 1
            ri -= 1
        }
    }
    
}
