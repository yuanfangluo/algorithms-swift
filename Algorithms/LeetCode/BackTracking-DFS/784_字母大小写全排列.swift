//
//  784_字母大小写全排列.swift
//  Algorithms
//
//  Created by sheng on 2022/10/30.
//

import Foundation
// https://leetcode.cn/problems/letter-case-permutation/

class LetterCasePermutation: Runnable {
    
    func run() {
        print(letterCasePermutation("a1b2"))
    }
    
    var res: [String] = []
    
    func letterCasePermutation(_ s: String) -> [String] {
        // 首先把字符串变成字符数组
        let chars: [Character] = Array(s)
        dfs(chars, 0)
        return res
    }
    
    func dfs(_ arr: [Character], _ pos: Int) {
        var arr = arr
        var pos = pos
        // 如果字符是一个数字，不需要变换大小写
        while pos < arr.count && arr[pos].isNumber {
            pos += 1
        }
        
        if pos == arr.count {
            res.append(String(arr))
            return
        }
        // 每个字符的大小写形式刚好差了 32
        // 变换大小写这件事等价于：
        
        // 如果字符是小写字符，减去 32 得到大写字符；
        // 如果字符是大写字符，加上 32 得到小写字符。
        // 而这两者合并起来，就是给这个字符做一次不进位的加法，即异或上 1 << 5
        arr[pos] = Character(arr[pos].lowercased())
        dfs(arr, pos + 1)
        arr[pos] = Character(arr[pos].uppercased())
        dfs(arr, pos + 1)
    }
}
