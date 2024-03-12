//
//  1822_数组元素积的符号.swift
//  Algorithms
//
//  Created by sheng on 2022/10/27.
//

import Foundation
// https://leetcode.cn/problems/sign-of-the-product-of-an-array/

class ArraySign {
    func arraySign(_ nums: [Int]) -> Int {
        var negCount = 0
        for num in nums {
            if num == 0 {
                return 0
            } else if num < 0 {
                negCount += 1
            }
        }
        
        if negCount & 1 == 1 { // 负数是奇数
            return -1
        }
        
        return 1
        
//        return negCount & 1 == 1 ? -1 : 1
    }
}
