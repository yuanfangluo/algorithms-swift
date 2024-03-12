//
//  26_删除有序数组中的重复项.swift
//  Algorithms
//
//  Created by sheng on 2022/11/1.
//

import Foundation
// https://leetcode.cn/problems/remove-duplicates-from-sorted-array/

class ArrayRemoveDuplicates {
    
    func removeDuplicates(_ nums: inout [Int]) -> Int {
        var slow = 0
        var fast = 0
        
        while fast < nums.count {
            if nums[fast] != nums[slow] {
                slow += 1
                nums[slow] = nums[fast]
            }
            fast += 1
        }
        return slow + 1
    }
}
