//
//  242_有效的字母异位词.swift
//  Algorithms
//
//  Created by sheng on 2022/9/21.
//

import Foundation

// https://leetcode.cn/problems/valid-anagram/ 
// 用空间换时间

class ValidAnagram: Runnable {
    func run() {
        print(isAnagram("anagram", "nagaram"))
        print(isAnagram("rat", "car"))
    }
    
    func isAnagram(_ s: String, _ t: String) -> Bool {
        if s.count != t.count {
            return false
        }
        
        let sArray: [Character] = Array(s)
        let tArray: [Character] = Array(t)
        var counts = Array(repeating: 0, count: 26)
        
        for i in 0..<sArray.count {
            let idx = sArray[i].intValue - Character("a").intValue
            counts[idx] = counts[idx] + 1
        }
        
        for i in 0..<tArray.count {
            let idx = tArray[i].intValue - Character("a").intValue
            counts[idx] = counts[idx] - 1
            if counts[idx] < 0 {
                return false
            }
        }
        return true
    }
}
