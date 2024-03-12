//
//  3_无重复字符的最长子串.swift
//  Algorithms
//
//  Created by sheng on 2022/9/21.
//

import Foundation

// https://leetcode.cn/problems/longest-substring-without-repeating-characters/

class LongestSubstringWithoutRepeatingCharacters: Runnable {
    func run() {
        print(lengthOfLongestSubstring2("abcabcbb"))
    }
    
    // 思路3：滑动窗口算法
    func lengthOfLongestSubstring3(_ s: String) -> Int {
        
        var window: [Character: Int] = [:]

        // 2. 初始化left和right,其实[left, right)
        var left = 0
        var right = 0
        
        var res = 0
        while right < s.count {
            // c是将移入窗口的字符
            let c = Array(s)[right]
            // 扩大窗口
            right += 1
            // 进行窗口内数据的更新
            if let count = window[c] {
                window[c] = count + 1
            } else {
                window[c] = 1
            }
            
            // 判断左侧窗口是否要收缩
            // 当 window[c] 值大于 1 时，说明窗口中存在重复字符，不符合条件，就该移动 left 缩小窗口了
            while window[c]! > 1 {
                // 收缩
                // d是将移出窗口的字符
                let d = Array(s)[left]
                // 左移窗口
                left += 1
                // 进行窗口内数据的一系列更新
                window[d] = window[d]! - 1
            }
            
            // 要在收缩窗口完成后更新 res，因为窗口收缩的 while 条件是存在重复元素，换句话说收缩完成后一定保证窗口中没有重复
            res = max(res, right - left)
        }
        return res
    }
    
    // 思路2：
    func lengthOfLongestSubstring2(_ s: String) -> Int {
        if s.isEmpty {
            return 0
        }
        let chars: [Character] = Array(s)
        
        // 用来保存每一个字符上一次的位置(一共有128个ASCII字符：0-127)
        var prevIdxes: [Int] = Array(repeating: -1, count: 128)
        prevIdxes[chars[0].intValue] = 0
        // 以 i - 1 位置字符结尾的最长不重复子串的开始索引（最左索引）
        // 因为i = 1开始，那么 i - 1 = 0
        var li = 0
        var maxValue = 1
        for i in 1..<chars.count {
            // i位置字符上一次出现的位置，有可能为空
            // 要保证pi在li的左边，那么pi尽可能往左边远
            let pi = prevIdxes[chars[i].intValue]
            if li <= pi {
                li = pi + 1
            }
            // 存储这个字符出现的位置
            prevIdxes[chars[i].intValue] = i
            maxValue = max(maxValue, i - li + 1)
        }
        
        return maxValue
    }
    
    // 思路1：
    func lengthOfLongestSubstring(_ s: String) -> Int {
        if s.isEmpty {
            return 0
        }
        let chars: [Character] = Array(s)
        
        // 用来保存每一个字符上一次的位置
        var prevIdxes: [Character: Int] = [:]
        prevIdxes[chars[0]] = 0
        // 以 i - 1 位置字符结尾的最长不重复子串的开始索引（最左索引）
        // 因为i = 1开始，那么 i - 1 = 0
        var li = 0
        var maxValue = 1
        for i in 1..<chars.count {
            // i位置字符上一次出现的位置，有可能为空
            // 要保证pi在li的左边，那么pi尽可能往左边远
            let pi = prevIdxes[chars[i]]
            if pi != nil && li <= pi! {
                li = pi! + 1
            }
            
            // 存储这个字符出现的位置
            prevIdxes[chars[i]] = i
            maxValue = max(maxValue, i - li + 1)
        }
        
        return maxValue
    }
}
