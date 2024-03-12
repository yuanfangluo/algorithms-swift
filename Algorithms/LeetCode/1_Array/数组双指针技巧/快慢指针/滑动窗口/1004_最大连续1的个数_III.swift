//
//  1004_最大连续1的个数_III.swift
//  Algorithms
//
//  Created by sheng on 2022/11/3.
//

import Foundation

// https://leetcode.cn/problems/max-consecutive-ones-iii/?show=1

class MaxConsecutiveOnesIII {
    
    /**
     1、什么时候应该扩大窗口？
        当可替换次数大于等于0时，扩大窗口，此时记录窗口里的1，剩余的就是0
     2、什么时候应该缩小窗口？
          当需要替换0为1的个数大于可替换个数，缩小窗口，空余出可替换次数，以便继续扩大窗口
     3、什么时候应该更新答案？
     可替换次数大于等于0，窗口中的0都会被替换成1，求此时窗口的长度，再将结果和之前求的最大长度比较，更新max
     */
    
    func longestOnes(_ nums: [Int], _ k: Int) -> Int {

        var left = 0
        var right = 0
        
        // 记录窗口中1的出现次数
        var windowOneCount = 0
        // 记录结果长度
        var res = 0

        while right < nums.count {
            // 扩大窗口
            if nums[right] == 1 {
                windowOneCount += 1
            }
            
            right += 1
            
            while right - left - windowOneCount > k {
                // 当窗口中需要替换的0 的数量大于k，缩小窗口
                
                if nums[left] == 1 {
                    windowOneCount -= 1
                }
                left += 1
                
            }
            
            // 此时一定是一个合法的窗口，求最大窗口长度
            res = max(res, right - left)
        }
        return res
    }
}
