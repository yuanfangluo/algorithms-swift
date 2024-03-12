//
//  333_最大BST子树.swift
//  Algorithms
//
//  Created by sheng on 2022/9/23.
//

import Foundation
// https://leetcode.cn/problems/largest-bst-subtree/

/**
 给定一个二叉树，找到其中最大的二叉搜索树（BST）子树，其中最大指的是子树节点数最多的
 */

class LargestBSTSubtree {
    
    class Info {
        var root: TreeNode
        var size = 1
        var max: Int
        var min: Int
        init(root: TreeNode, size: Int = 1, max: Int, min: Int) {
            self.root = root
            self.size = size
            self.max = max
            self.min = min
        }
    }
    /// 返回以 root 为根节点的二叉树的最大 BST 子树信息
    func getInfo(_ root: TreeNode?) -> Info {
        Info(root: root!, max: 0, min: 0)
    }
    
    func largestBSTSubtree(_ root: TreeNode?) -> Int {
        
        return root == nil ? 0 : getInfo(root).size
    }
    
    func isBST(_ root: TreeNode?) -> Bool {
        return false
    }
    
    func nodesCount(_ root: TreeNode?) -> Int {
        
        
        return 0
    }
    
}
