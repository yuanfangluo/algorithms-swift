//
//  108_将有序数组转换为二叉搜索树.swift
//  Algorithms
//
//  Created by sheng on 2022/9/28.
//

import Foundation
// https://leetcode.cn/problems/convert-sorted-array-to-binary-search-tree/

// 一看到树，考虑递归
class SortedArrayToBST {
    func sortedArrayToBST(_ nums: [Int]) -> TreeNode? {
        return build(nums, 0, nums.count - 1)
    }
    
    // 将闭区间 [left right] 中的元素转化成BST，并且返回根节点
    func build(_ nums: [Int], _ left: Int, _ right: Int) -> TreeNode? {
        if left > right {
            return nil
        }
        
        // BST节点左小右大， 中间的元素就是根节点
        let mid = (left + right) >> 1
        let root = TreeNode(nums[mid])
        root.left = build(nums, left, mid - 1)
        root.right = build(nums, mid + 1, right)
        return root
    }
    
}
