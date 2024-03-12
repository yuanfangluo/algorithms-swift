//
//  17_电话号码的字母组合.swift
//  Algorithms
//
//  Created by sheng on 2022/9/30.
//

import Foundation
// https://leetcode.cn/problems/letter-combinations-of-a-phone-number/


class LetterCombinations: Runnable {
    
    func run() {
        print(letterCombinations("23"))
    }
    
    var lettersArray: [[Character]] = [
        ["a", "b", "c"], ["d", "e", "f"],
        ["g", "h", "i"], ["j", "k", "l"], ["m", "n", "o"],
        ["p", "q", "r", "s"], ["t", "u", "v"], ["w", "x", "y", "z"]
    ]
    
    // 最终的结果
    var list: [String] = []
    // 将传入的字符串改为字符数组
    var chars: [Character] = []
    // 存放每层的字符
    var string: [Character] = []
    
    func letterCombinations(_ digits: String) -> [String] {
        if digits.isEmpty {
            return list
        }
        chars = Array(digits);
        string = Array(repeating: Character(" "), count: chars.count)
        dfs(0)
        return list
       }
    
    func dfs(_ idx: Int) {
        // 已经到最后一层了，不能再深入了
        if idx == chars.count {
            // 得到一个正确的解
            list.append(String(string))
            return
        }
        
        // 先枚举这一层可以做的所有选择
        let letters = lettersArray[Int(String(chars[idx]))!  - 2]
        for letter in letters {
            string[idx] = letter
            dfs(idx + 1)
        }
    }
}
