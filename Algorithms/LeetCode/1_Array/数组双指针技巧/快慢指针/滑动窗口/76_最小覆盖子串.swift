//
//  76_最小覆盖子串.swift
//  Algorithms
//
//  Created by sheng on 2022/11/2.
//

import Foundation
// https://leetcode.cn/problems/minimum-window-substring/

class MinWindow: Runnable {
    
    func run() {
//        print(minWindow("ADOBECODEBANC", "ABC"))
        print(minWindow("ADOBECODEBANC",
                        "ABC"))

    }
    
    // s是大串，t是小串
    func minWindow(_ s: String, _ t: String) -> String {
        // 1. 首先初始化两个哈希表
        var need: [Character: Int] = [:]
        
        for c in t {
            if let count = need[c] {
                need[c] = count + 1
            } else {
                need[c] = 1
            }
        }
        
        print(need)
        
        var window: [Character: Int] = [:]

        // 2. 初始化left和right,其实[left, right)
        var left = 0
        var right = 0
        // 表示窗口中满足need条件的字符个数
        var valid = 0
        // 记录最小覆盖子串的起始索引以及长度
        var start = 0
        var len = Int.max
        
        while right < s.count {
            // c是将移入窗口的字符
            let c = s.charAt(right)
            // 扩大窗口
            right += 1
            // 进行窗口内数据的一系列更新
            if need.keys.contains(c) { // 如果need里面有这个key
                if let count = window[c] {
                    window[c] = count + 1
                } else {
                    window[c] = 1
                }
                
                if window[c] == need[c] {
                    valid += 1
                }
            }
            
            // 判断左侧窗口是否要收缩
            while valid == need.count { // 代表window里面已经有need里面的数据了
                // 在这里更新最小覆盖子串
                let curLen = right - left
                
                if curLen < len {
                    start = left
                    len = curLen
                }
                
                // d是将移出窗口的字符
                let d = s.charAt(left)
                // 左移窗口
                left += 1
                // 进行窗口内数据的一系列更新
                if need.keys.contains(d) { // 如果need里面有这个key
                    if window[d]! == need[d]! {
                        valid -= 1
                    }
                    window[d] = window[d]! - 1
                }
            }
        }
        
        print(start, len)
        
        return len == Int.max ? "" : s.substring(start, len)
    }
}

