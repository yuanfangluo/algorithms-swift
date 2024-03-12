//
//  1_两数之和.swift
//  Algorithms
//
//  Created by sheng on 2022/10/12.
//

import Foundation
// https://leetcode.cn/problems/two-sum/

class TwoSum: Runnable {
    
    func run() {
        print(twoSum([2, 4, 5, 7, 9, 11], 14))
    }
    
   private func twoSum(_ nums: [Int], _ target: Int) -> [Int] {
        var result: [Int] = []
        var dic:[Int: Int] = [:]
        dic[nums[0]] = 0
        for i in 1..<nums.count {
            let dif = target - nums[i]
            if let value = dic[dif] {
                result.append(value)
                result.append(i)
            } else {
                dic[nums[i]] = i
            }
        }
        return result
    }
}
