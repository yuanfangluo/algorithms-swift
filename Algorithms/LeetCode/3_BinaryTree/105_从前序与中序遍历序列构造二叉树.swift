//
//  105_从前序与中序遍历序列构造二叉树.swift
//  Algorithms
//
//  Created by sheng on 2022/9/28.
//

import Foundation
// https://leetcode.cn/problems/conclass-binary-tree-from-preorder-and-inorder-traversal/

// 类似题目：
// 剑指 Offer 07. 重建二叉树:https://leetcode.cn/problems/zhong-jian-er-cha-shu-lcof/
class ConclassTreeFromPreorderAndInorder: Runnable {
    
    func run() {
        
    }
    
    var map: [Int: Int] = [:]
    
    func buildTree(_ preorder: [Int], _ inorder: [Int]) -> TreeNode? {
        // 将中序遍历的元素为key，索引为value
        for i in 0..<inorder.count {
            map[inorder[i]] = i
        }
        
        return buildTree(preorder,
                         0,
                         preorder.count - 1,
                         inorder,
                         0,
                         inorder.count - 1)
    }
    /**
     定义：
     前序遍历数组为 preorder[preStart..preEnd]
     中序遍历数组为 inorder[inStart..inEnd]
     构造这个二叉树并返回该二叉树的根节点
     */
    func buildTree(_ preorder: [Int],
                   _ preStart: Int,
                   _ preEnd: Int,
                   _ inorder: [Int],
                   _ inStart: Int,
                   _ inEnd: Int ) -> TreeNode? {
        // preStart是可以和preEnd相等的
        if preStart > preEnd {
            return nil
        }
        
        // 1. 根据前序遍历的第一个节点，得到根节点
        var root = preorder[preStart]
        // 2. root 在中序遍历的索引
        var rootIndex = map[root]!
        
        // 3. 计算左子树的大小
        var leftSize = rootIndex - inStart
        
        // 4. 构造当前根节点
        var rootNode = TreeNode(root)
        
        // 递归构造左右子树
        rootNode.left = buildTree(preorder,
                                  preStart + 1,
                                  preStart + leftSize,
                                  inorder,
                                  inStart,
                                  rootIndex - 1)
        rootNode.right = buildTree(preorder,
                                   preStart + leftSize + 1,
                                   preEnd,
                                   inorder,
                                   rootIndex + 1,
                                   inEnd)
        return rootNode
    }
    
}
