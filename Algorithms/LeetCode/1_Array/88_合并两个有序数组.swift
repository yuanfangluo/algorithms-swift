//
//  88_合并两个有序数组.swift
//  Algorithms
//
//  Created by sheng on 2022/9/19.
//

import Foundation
// https://leetcode.cn/problems/merge-sorted-array/
// 三指针
class MergeSortedArray: Runnable {
    func run() {
        var nums1 = [1, 3, 5, 0, 0, 0]
        merge(&nums1, 3, [2, 4, 6], 3)
        print(nums1)
    }
    
    func merge(_ nums1: inout [Int], _ m: Int, _ nums2: [Int], _ n: Int) {
        var i1 = m - 1
        var i2 = n - 1
        var cur = nums1.count - 1
        while i2 >= 0{
            if i1 >= 0 && nums1[i1] > nums2[i2] {
                nums1[cur] = nums1[i1]
                cur -= 1
                i1 -= 1
            } else {
              nums1[cur] = nums2[i2]
                cur -= 1
                i2 -= 1
            }
        }
    }
}
