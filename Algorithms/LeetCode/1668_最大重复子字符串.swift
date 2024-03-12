//
//  1668_最大重复子字符串.swift
//  Algorithms
//
//  Created by sheng on 2022/11/3.
//

import Foundation
// https://leetcode.cn/problems/maximum-repeating-substring/description/

class MaxRepeating: Runnable {
    
    func run() {
        print(maxRepeating("ababc", "ab"), maxRepeating("ababc", "ba"), maxRepeating("ababc", "ac"))
    }
    
    func maxRepeating(_ sequence: String, _ word: String) -> Int {
        
        var res = 0
        var words = word
        while words.count <= sequence.count {
            if sequence.contains(words) {
                res += 1
                words += word
            } else {
                break
            }
        }
        
        return res
    }
}
