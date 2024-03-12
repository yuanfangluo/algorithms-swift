//
//  977_有序数组的平方.swift
//  Algorithms
//
//  Created by sheng on 2022/9/19.
//

import Foundation
// https://leetcode.cn/problems/squares-of-a-sorted-array/

/**
 平方的特点是会把负数变成正数，所以一个负数和一个正数平方后的大小要根据绝对值来比较。
 
 可以把元素 0 作为分界线，0 左侧的负数是一个有序数组 nums1，0 右侧的正数是另一个有序数组 nums2，那么这道题就和 88. 合并两个有序数组 讲过的 21. 合并两个有序链表 的变体。

 所以，我们可以去寻找正负数的分界点，然后向左右扩展，执行合并有序数组的逻辑。不过还有个更好的办法，不用找正负分界点，而是直接将双指针分别初始化在 nums 的开头和结尾，相当于合并两个从大到小排序的数组，和 88 题类似。
 */

class squaresofasortedarray: Runnable {
    func run() {
        print(sortedSquares([-2, -1, 0, 3, 4]))
    }
    
    // 双指针，从首尾两端开始排序
    func sortedSquares(_ nums: [Int]) -> [Int] {
        var result = Array(repeating: 0, count: nums.count)
        var l = 0
        var r = nums.count - 1
        var i = nums.count - 1
        while l != r {
            let lv = nums[l] * nums[l]
            let rv = nums[r] * nums[r]
            if lv < rv {
                result[i] = rv
                r -= 1
                i -= 1
            } else {
                result[i] = lv
                l += 1
                i -= 1
            }
        }
        // 到这里是 l == r
        result[i] = nums[l] * nums[l]
        return result
    }
}
