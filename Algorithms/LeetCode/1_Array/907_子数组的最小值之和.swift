//
//  907_子数组的最小值之和.swift
//  Algorithms
//
//  Created by sheng on 2022/10/28.
//

import Foundation
// https://leetcode.cn/problems/sum-of-subarray-minimums/


class SumSubarrayMins: Runnable {
    
    func run() {
        print(
            sumSubarrayMins([3,1,2,4])
            , sumSubarrayMins([11,81,94,43,3])
        )
    }
    
    private func sumSubarrayMins(_ arr: [Int]) -> Int {
        return sumSubarrayMins(arr, 0, arr.count - 1)
    }
    
    // 复杂度太高了
    private func sumSubarrayMins(_ arr: [Int], _ begin:Int, _ end: Int) -> Int {
        
        // minArr[i] 代表是[begin, end]子数组的最小值的和
        var minArr = Array(repeating: 0, count: end - begin + 1)
        
        for i in begin...end {
            var l = begin
            var r = begin
            var sum = 0
            while l <= r && l <= i {
                var minVal = arr[l]
                while l <= r && r <= i{
                    minVal = min(minVal, arr[r])
                    sum += minVal
                    print(sum)
                    r += 1
                }
                
                // 到这里代表 r > i
                l += 1
                r = l
            }
            
            minArr[i] = sum
        }
        
//        print(minArr)
        return minArr.last!
    }
    
    // 使用动态规划
    private func sumSubarrayMins2(_ arr: [Int]) -> Int {
        
        
        
        return sumSubarrayMins(arr, 0, arr.count - 1)
    }
}
