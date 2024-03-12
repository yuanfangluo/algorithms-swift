//
//  567_字符串的排列.swift
//  Algorithms
//
//  Created by sheng on 2022/11/3.
//

import Foundation
// https://leetcode.cn/problems/permutation-in-string/

class PermutationInString: Runnable {
    
    func run() {
        print(checkInclusion("eidbaooo", "ab"))
    }
    
    
    /**
     这种包含字符串的题目，很明显是滑动窗口算法
     */
    // 判断 s 中是否存在t的排列
    func checkInclusion(_ s: String, _ t: String) -> Bool {
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
        
        
        while right < s.count {
            // c是将移入窗口的字符
            let c = s.charAt(right)
            // 扩大窗口
            right += 1
            // 进行窗口内数据的一系列更新
            if need.keys.contains(c) { // 如果need里面有这个key
                // 进行窗口内数据的更新
                if let count = window[c] {
                    window[c] = count + 1
                } else {
                    window[c] = 1
                }
                
                if window[c] == need[c] {
                    valid += 1
                }
            }
            
            // 因为子串的长度是一致的，所以窗口的长度是固定的，所以每次收缩窗口的时候只会移除一次
            // 判断左侧窗口是否要收缩
            while right - left >= t.count {
                // 1. 先判断
                // 在这里判断是否找到了合法在子串
                if valid == need.count {
                    return true
                }
                // 2. 再收缩
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
        return false
    }
}
