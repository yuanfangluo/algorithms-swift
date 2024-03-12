//
//  27_移除元素.swift
//  Algorithms
//
//  Created by sheng on 2022/11/1.
//

import Foundation
// https://leetcode.cn/problems/remove-element/


class ArrayRemoveElement {
    
    // 使用快慢指针
    func removeElement(_ nums: inout [Int], _ val: Int) -> Int {
        if nums.isEmpty {
            return 0
        }
        
        var slow = 0
        
        var fast = 0
        
        while fast < nums.count {
            if nums[fast] != val {
                
                nums[slow] = nums[fast]
                slow += 1
            }
            fast += 1
        }
        
        return slow
    }
}
