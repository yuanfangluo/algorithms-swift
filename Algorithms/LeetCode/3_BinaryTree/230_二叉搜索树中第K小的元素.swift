//
//  230_二叉搜索树中第K小的元素.swift
//  Algorithms
//
//  Created by sheng on 2022/9/28.
//

import Foundation
// https://leetcode.cn/problems/kth-smallest-element-in-a-bst/
class KthSmallest {
    
    func kthSmallest(_ root: TreeNode?, _ k: Int) -> Int {
        self.k = k
        traverse(root)
        return result
    }
    
    var cur: Int = 0
    var k: Int = 0
    var result: Int = 0
    
    // 使用中序遍历
    func traverse(_ root: TreeNode?) {
        if root == nil {
            return
        }
        
        traverse(root?.left)
        
        cur += 1
        
        if cur == k {
            result = root!.val
        }
        traverse(root?.right)
    }
    
    // 进阶：如果二叉搜索树经常被修改（插入/删除操作）并且你需要频繁地查找第 k 小的值，你将如何优化算法？
    
    
}
