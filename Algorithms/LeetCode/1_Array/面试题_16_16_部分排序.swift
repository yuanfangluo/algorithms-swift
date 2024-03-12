//
//  面试题_16_16_部分排序.swift
//  Algorithms
//
//  Created by sheng on 2022/9/19.
//

import Foundation
// https://leetcode.cn/problems/sub-sort-lcci/

class SubSortLcci: Runnable {
    func run() {
        print(subSort([1, 5, 4, 3, 2, 6, 7]))
    }
    
    func subSort(_ array: [Int]) -> [Int] {
        if array.isEmpty {
            return [-1, -1]
        }
        // 从左扫描到右
        var maxValue = array[0]
        var r = -1
        for i in 1..<array.count {
            let v = array[i]
            if v >= maxValue {
                maxValue = v
            } else {
                r = i
            }
        }
        // 如果是-1了，就没有必要下面了
        if r == -1 {
            return [-1, -1]
        }
        // 从右扫描到左
        var minValue = array[array.count - 1]
        var l = -1
        for i in stride(from: array.count - 2, through: 0, by: -1) {
            let v = array[i]
            if v <= minValue {
                minValue = v
            } else {
                l = i
            }
        }
        return [l, r]
    }
}
