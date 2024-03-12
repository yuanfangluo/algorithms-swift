//
//  22_括号生成.swift
//  Algorithms
//
//  Created by sheng on 2022/10/12.
//

import Foundation
// https://leetcode.cn/problems/generate-parentheses/

class GenerateParentheses: Runnable {
    func run() {
        print(generateParenthesis(3))
    }
    
    var list: [String] = []
    var string: [Character] = []
    
    func generateParenthesis(_ n: Int) -> [String] {
        if n < 0 {
            return list
        }
        
        string = Array(repeating: " ", count: n << 1)
        dfs(0, n, n)
        return list
    }
    
    func dfs(_ idx: Int, _ leftRemain: Int, _ rightRemain: Int) {
        if (idx == string.count) {
            list.append(String(string))
            return
        }
        
        // 枚举这一层所有可能的选择
        // 选择某一种可能之后，进入下一层搜索
        // 选择左括号，然后进入下一层搜索
        
        // 什么条件下可以选择左括号？左括号剩余数量 > 0
        if leftRemain > 0 {
            string[idx] = Character("(")
            dfs(idx + 1, leftRemain - 1, rightRemain)
        }
        
        // 选择右括号，进入下一层搜索
        // 什么条件下选择右括号？右括号数量大于0 && 右括号剩余的数量 != 左括号的剩余数量
        if (rightRemain > 0 && leftRemain != rightRemain) {
            string[idx] = Character(")")
            dfs(idx + 1, leftRemain, rightRemain - 1)
        }
    }
}
