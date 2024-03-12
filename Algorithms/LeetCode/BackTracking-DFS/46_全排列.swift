//
//  46_全排列.swift
//  Algorithms
//
//  Created by sheng on 2022/9/9.
//

import Foundation
// https://leetcode.cn/problems/permutations/

class Permutations: Runnable {
    
    func run() {
        print(permute([1, 2, 3]))
    }
    
    var list: [[Int]] = []
    var nums: [Int] = []
    
    // 用来保存每一层选择的数字
    var result: [Int] = []
    // 记录nums对应的元素是否被使用过
    var used: [Bool] = []
    
    func permute(_ nums: [Int]) -> [[Int]] {
        if nums.isEmpty {
            return list
        }
        self.nums = nums
        used = Array(repeating: false, count: nums.count)
        result = Array(repeating: 0, count: nums.count)
        dfs(0)
        return list
    }
    
    func dfs(_ idx: Int) {
        // 不能再往下搜索
        if idx == nums.count {
            list.append(result)
            return
        }
        
        // 枚举这一层所有可以做出的选择
        for i in 0..<nums.count {
            if used[i] {
                continue
            }
            result[idx] = nums[i]
            used[i] = true
            dfs(idx + 1)
            used[i] = false
        }
    }
}

class Permutations2: Runnable {
    
    func run() {
        print(permute([1, 2, 3]))
    }
    
    var list: [[Int]] = []
    var nums: [Int] = []
    
    // 用来保存每一层选择的数字
    var result: [Int] = []
    
    func permute(_ nums: [Int]) -> [[Int]] {
        if nums.isEmpty {
            return list
        }
        self.nums = nums
        dfs(0)
        return list
    }
    
    func dfs(_ idx: Int) {
        // 不能再往下搜索
        if idx == nums.count {
            list.append(result)
            return
        }
        
        // 枚举这一层所有可以做出的选择
        for num in nums {
            if result.contains(num) {
                continue
            }
            
            result.append(num)
            
            dfs(idx + 1)
            
            result.removeLast()
        }
    }
}

class Permutations3: Runnable {
    
    func run() {
        print(permute([1, 2, 3]))
    }
    
    var list: [[Int]] = []
    var nums: [Int] = []
    
    func permute(_ nums: [Int]) -> [[Int]] {
        if nums.isEmpty {
            return list
        }
        self.nums = nums
        dfs(0)
        return list
    }
    
    func dfs(_ idx: Int) {
        // 不能再往下搜索
        if idx == nums.count {
            list.append(nums)
            return
        }
        
        // 枚举这一层所有可以做出的选择
        for i in idx..<nums.count {
            swap(idx, j: i)
            dfs(idx + 1)
            swap(idx, j: i)
        }
    }
    
    func swap(_ i: Int, j: Int) {
        let tmp = nums[i]
        nums[i] = nums[j]
        nums[j] = tmp
    }
}
