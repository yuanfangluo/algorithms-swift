//
//  7_整数反转.swift
//  Algorithms
//
//  Created by sheng on 2022/10/14.
//

import Foundation
// https://leetcode.cn/problems/reverse-integer/

class ReverseInteger: Runnable {
    func run() {
        print(reverse(1534236469))
    }
    private func reverse(_ x: Int) -> Int {
        var res = 0
        var x = x
        
        while x != 0 {
            let mod = x % 10
            res = res * 10 + mod
            // 验证是否溢出
            if res > Int32.max || res < Int32.min {
                return 0
            }
            x = x / 10
        }
        
        return Int(res)
    }
}
