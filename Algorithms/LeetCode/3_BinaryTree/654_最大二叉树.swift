//
//  654_最大二叉树.swift
//  Algorithms
//
//  Created by sheng on 2022/9/20.
//

import Foundation
// https://leetcode.cn/problems/maximum-binary-tree/
/**
 最大二叉树
 
 */
class MaximumBinaryTree: Runnable {
    func run() {
        print(parentIndexes([3, 2, 1, 6, 0, 5]))
    }
    
    func conclassMaximumBinaryTree(_ nums: [Int]) -> TreeNode? {
        return findRoot(nums, 0, nums.count)
    }
    
    /// 找出 [l, r) 的根节点
    func findRoot(_ nums: [Int], _ l: Int, _ r: Int) -> TreeNode? {
        // 递归基
        if l == r {
            return nil
        }
        // 找出最大值的索引
        var maxIdx = l
        for i in (l+1)..<r {
            if nums[i] > nums[maxIdx] {
                maxIdx = i
            }
        }
        
        let root = TreeNode(nums[maxIdx], findRoot(nums, l, maxIdx), findRoot(nums, maxIdx + 1, r))
        return root
    }
    
    func parentIndexes(_ nums: [Int]) -> [Int] {
        /**
         1. 扫描一遍元素
         2. 保证栈从栈底到栈顶的元素是单调递减的
            - 如果能入栈，代表将要入栈的元素的左边第一个比它大的是现在的栈顶元素
            - 如果不能入栈，需要弹出来，弹出来的右边第一个比它大的是将要入栈的元素
         */
        var lis = Array(repeating: -1, count: nums.count)
        var ris = Array(repeating: -1, count: nums.count)
        let stack = Stack<Int>()
        
        for i in 0..<nums.count {
            while !stack.isEmpty && nums[i] > nums[stack.top!]  {
                ris[stack.pop()!] = i
            }
            
//            if !stack.isEmpty {
//                lis[i] = stack.top!
//            } else {
//                lis[i] = -1
//            }
            
            lis[i] = stack.isEmpty ? -1 : stack.top!
            stack.push(i)
        }
        print(lis, ris)
        
        var result = Array(repeating: -1, count: nums.count)
        for i in 0..<result.count {
            if lis[i] == -1 && ris[i] == -1 {
                // 代表是根节点
                result[i] = -1
                continue
            }
            
            if lis[i] == -1 {
                result[i] = ris[i]
            } else if ris[i] == -1 {
                result[i] = lis[i]
            } else if nums[lis[i]] < nums[ris[i]] {
                result[i] = lis[i]
            } else {
                result[i] = ris[i]
            }
        }
        return result
    }
}


