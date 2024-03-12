//
//  99_恢复二叉搜索树.swift
//  Algorithms
//
//  Created by sheng on 2022/9/23.
//

import Foundation
// https://leetcode.cn/problems/recover-binary-search-tree/
/// 二叉搜索树的特点：
/// ① 每个节点的左子树的节点比这个节点小
/// ② 每个节点的右子树的节点比这个节点大
/// ③ 中序遍历的结果是升序的
class RecoverBinarySearchTree {
    
    var first: TreeNode?
    var second: TreeNode?
    var prev: TreeNode?
    
    func recoverTree(_ root: TreeNode?) {
        // 找到错误的两个节点
        findWrongNodes(root)
        let val = first!.val
        first?.val = second!.val
        second?.val = val
    }
    
    /// 中序遍历找到错误的节点
    func findWrongNodes(_ node: TreeNode?) {
        if node == nil {
            return
        }
        findWrongNodes(node?.left)
        
        if node != nil && prev != nil && node!.val < prev!.val {
            second = node
            if first != nil {
                return
            }
            first = prev
        }
        
        prev = node
        
        findWrongNodes(node?.right)
    }
}
