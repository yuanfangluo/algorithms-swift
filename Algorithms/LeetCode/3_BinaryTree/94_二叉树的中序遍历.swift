//
//  94_二叉树的中序遍历.swift
//  Algorithms
//
//  Created by sheng on 2022/9/28.
//

import Foundation
// https://leetcode.cn/problems/binary-tree-inorder-traversal/

class Inorder {
    
    var result: [Int] = []
    
    // 递归
    @discardableResult
    func inorderTraversal(_ root: TreeNode?) -> [Int] {
        if root != nil {
            inorderTraversal(root?.left)
            
            result.append(root!.val)
            
            inorderTraversal(root?.right)
            
        }
        return result
    }
    
    // 迭代
    @discardableResult
    func inorderTraversal2(_ root: TreeNode?) -> [Int] {
        
        result
    }
    
}
