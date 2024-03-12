//
//  Array.swift
//  Algorithms
//
//  Created by sheng on 2022/10/27.
//

import Foundation

// 谈到数组，你必须想到
// 1. 快慢指针:原地修改数组，滑动窗口

// 滑动窗口框架




// 2. 左右指针:二分查找，，，，前缀和数组，差分数组
class MyArray {
    func traverse1(_ nums: [Int]) {
        for num in nums {
            print(num)
        }
    }
    
    func traverse2(_ nums: [Int]) {
        for i in 0..<nums.count {
            print(i, nums[i])
        }
    }
    
    func traverse3(_ nums: [Int]) {
        for i in stride(from: 0, to: nums.count, by: 1) {
            print(i, nums[i])
        }
    }
    
    func traverse4(_ nums: [Int]) {
        for i in stride(from: 0, through: nums.count - 1, by: 1) {
            print(i, nums[i])
        }
    }
    
}
