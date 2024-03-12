//
//  889_根据前序和后序遍历构造二叉树.swift
//  Algorithms
//
//  Created by sheng on 2022/10/27.
//

import Foundation
// https://leetcode.cn/problems/conclass-binary-tree-from-preorder-and-postorder-traversal/

class ConclassFromPrePost {
    
    /**
     1、首先把前序遍历结果的第一个元素或者后序遍历结果的最后一个元素确定为根节点的值。
     2、然后把前序遍历结果的第二个元素作为左子树的根节点的值。

     3、在后序遍历结果中寻找左子树根节点的值，从而确定了左子树的索引边界，进而确定右子树的索引边界，递归构造左右子树即可。
     */
    
    var map: [Int: Int] = [:]

    func conclassFromPrePost(_ preorder: [Int], _ postorder: [Int]) -> TreeNode? {
        for i in 0..<postorder.count {
            map[postorder[i]] = i
        }
        
        return buildTree(preorder,
                         0,
                         preorder.count - 1,
                         postorder,
                         0,
                         postorder.count - 1)
        
    }
    /**
     定义：
     前序遍历数组为 preorder[preStart..preEnd]
     后序遍历数组为 postorder[postStart..postEnd]
     构造这个二叉树并返回该二叉树的根节点
     */
    func buildTree(_ preorder: [Int],
                   _ preStart: Int,
                   _ preEnd: Int,
                   _ postorder: [Int],
                   _ postStart: Int,
                   _ postEnd: Int ) -> TreeNode? {
        
        if preStart > preEnd {
            return nil
        }
        
        if preStart == preEnd {
            return TreeNode(preorder[preStart])
        }
        
        // 1. 前序遍历的第一个节点是根节点
        var rootVal = preorder[preStart]
        
        // 2. root的左子树根节点是前序遍历的第二个元素
        var leftRootVal = preorder[preStart + 1];

        // 3. 根据左子树的根节点元素值从后序遍历找到索引
        var index = map[leftRootVal]!
        
        // 4. 左子树的个数
        var leftSize = index - postStart + 1
        
        // 5. 构造出当前节点
        var root = TreeNode(rootVal)
        
        // 6. 递归求出左右子树
        
        root.left = buildTree(preorder,
                              preStart + 1,
                              preStart + leftSize,
                              postorder,
                              postStart,
                              index )
        
        root.right =  buildTree(preorder,
                                preStart + leftSize + 1,
                                preEnd,
                                postorder,
                                index + 1,
                                postEnd - 1)
        return root
    }
}
