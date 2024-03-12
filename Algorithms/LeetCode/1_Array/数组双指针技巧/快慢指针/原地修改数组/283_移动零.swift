//
//  283_移动零.swift
//  Algorithms
//
//  Created by sheng on 2022/10/12.
//

import Foundation
// https://leetcode.cn/problems/move-zeroes/

// 双指针
class MoveZeroes: Runnable {
    
    func run() {
        var nums = [0, 1, 0, 3, 12]
        print(nums)
        moveZeroes(&nums)
        print(nums)
    }
    
    // 方法一：
    func moveZeroes(_ nums: inout [Int]) {
        
        var cur = 0
        
        for i in 0..<nums.count {
            if nums[i] == 0 {
                continue
            }
            
            if cur != i {
                nums[cur] = nums[i]
                nums[i] = 0
            }
            cur += 1
        }
    }
    
    // 方法二：相当于把前面的0移除，然后后面的元素补为零
    func moveZeroes2(_ nums: inout [Int]) {
        // 去除nums 中的所有零，返回不含0的 数组长度
        let p = removeElement(&nums, 0)

        // 将 nums[p..]的元素 赋值为0
        for i in p..<nums.count {
            nums[i] = 0
        }
    }
    
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
