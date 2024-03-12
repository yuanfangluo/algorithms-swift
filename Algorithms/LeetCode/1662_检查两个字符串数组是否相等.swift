//
//  1662_检查两个字符串数组是否相等.swift
//  Algorithms
//
//  Created by sheng on 2022/11/1.
//

import Foundation
// https://leetcode.cn/problems/check-if-two-string-arrays-are-equivalent/


class ArrayStringsAreEqual {
    func arrayStringsAreEqual1(_ word1: [String], _ word2: [String]) -> Bool {
        // p1，p2 表示word1[p1], word2[p2]
        var p1 = 0
        var p2 = 0
        
        //  i, j 代表 word1[p1][i], word2[p2][j]
        var i = 0
        var j = 0
        
        while p1 < word1.count && p2 < word2.count {
            let s1 = Array(word1[p1])
            let s2 = Array(word2[p2])
            if s1[i] != s2[j] {
                return false
            }
            
            i += 1
            
            if i == word1[p1].count {
                p1 += 1
                i = 0
            }
            
            j += 1
            
            if j == word2[p2].count {
                p2 += 1
                j = 0
            }
            
        }
        
        return p1 == word1.count && p2 == word2.count
    }
    
    //
    func arrayStringsAreEqual12(_ word1: [String], _ word2: [String]) -> Bool {
        word1.joined() == word2.joined()
    }
}
