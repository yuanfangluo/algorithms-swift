//
//  106_从中序与后序遍历序列构造二叉树.swift
//  Algorithms
//
//  Created by sheng on 2022/9/28.
//

import Foundation
// https://leetcode.cn/problems/conclass-binary-tree-from-inorder-and-postorder-traversal/



class ConclassBinaryTreeFromInorderAndPostorder {
    
    
    var map: [Int: Int] = [:]

    
    func buildTree(_ inorder: [Int], _ postorder: [Int]) -> TreeNode? {
        // 将中序遍历的元素为key，索引为value
        for i in 0..<inorder.count {
            map[inorder[i]] = i
        }
        
        return buildTree(inorder,
                         0,
                         inorder.count - 1,
                         postorder,
                         0,
                         postorder.count - 1)
       }
    
    /**
     定义：
     中序遍历数组为 inorder[inStart..inEnd]
     后序遍历数组为 postorder[postStart..postEnd]
     构造这个二叉树并返回该二叉树的根节点
     */
    func buildTree(_ inorder: [Int],
                   _ inStart: Int,
                   _ inEnd: Int,
                   _ postorder: [Int],
                   _ postStart: Int,
                   _ postEnd: Int ) -> TreeNode? {

        if inStart > inEnd {
            return nil
        }
        
        // 1. 根据后序遍历的最后一个节点，得到根节点
        var root = postorder[postEnd]
        // 2. root 在中序遍历的索引
        var rootIndex = map[root]!
        
        // 3. 计算左子树的大小
        var leftSize = rootIndex - inStart
        
        // 4. 构造当前根节点
        var rootNode = TreeNode(root)
        
        // 递归构造左右子树
        rootNode.left = buildTree(inorder,
                                  inStart,
                                  rootIndex - 1,
                                  postorder,
                                  postStart,
                                  postStart + leftSize - 1)
        rootNode.right = buildTree(inorder,
                                   rootIndex + 1,
                                   inEnd,
                                   postorder,
                                   postStart + leftSize,
                                   postEnd - 1)
        return rootNode
    }
    
    
    
}
