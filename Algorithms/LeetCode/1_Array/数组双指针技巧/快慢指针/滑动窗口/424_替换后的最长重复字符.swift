//
//  424_替换后的最长重复字符.swift
//  Algorithms
//
//  Created by sheng on 2022/11/4.
//

import Foundation
// https://leetcode.cn/problems/longest-repeating-character-replacement/?show=1

class CharacterReplacement {
    
    /**
     输入：s = "ABAB", k = 2
     输出：4
     解释：用两个'A'替换为两个'B',反之亦然。
     
     你维护一个窗口在 s 上滑动，保证 s 中的所有字符都被替换成一样的，那么窗口的最大长度就是题目要的答案。
     
     1. 什么时候扩大窗口？
     当可替换次数大于0，扩大窗口，所有进入窗口的字符都进行替换，使得窗口内的所有元素都是重复的
     
     2. 什么时候缩小窗口？
     当可替换次数小于0时，缩小窗口，空余出可替换次数，以便扩大窗口
     
     3. 什么时候得到一个合法的答案？
     只要可替换次数大于等于0，窗口中的字符串都是重复的，我们想求的是一个最大窗口长度
     
     */
    func characterReplacement(_ s: String, _ k: Int) -> Int {
        
        // 统计窗口中每个字符出现的次数
        var windowCharCount = Array(repeating: 0, count: 26)
        // 记录窗口中字符的最多重复次数
        var windowMaxCount = 0
        // 记录这个值的意义在于：最划算的替换方法肯定是把其他字符替换成出现次数最多的那个字符
        // 所以窗口大小减去windowMaxCount 就是所需的替换次数
        
        // 记录结果
        var res = 0
        
        var left = 0
        var right = 0
        while right < s.count {
            // 添加字符，扩大窗口
            let index = Array(s)[right].intValue - Character("A").intValue
            
            windowCharCount[index] += 1
            
            windowMaxCount = max(windowMaxCount, windowCharCount[index])
            
            right += 1
            
            // 缩小窗口
            while right - left - windowMaxCount > k { // 需要替换的次数超过k次了
                // 移除字符，缩小窗口
                let idx = Array(s)[left].intValue - Character("A").intValue
                
                windowCharCount[idx] -= 1
                
                left += 1
                
                // 这里不需要更新 windowCount
                // 因为只有 windowMaxCount 变得更大的时候才可能获得更长的重复子串，才会更新res
            }
            
            // 此时肯定是一个合法的窗口
            res = max(res, right - left)
            
        }
        
        return res
    }
}
