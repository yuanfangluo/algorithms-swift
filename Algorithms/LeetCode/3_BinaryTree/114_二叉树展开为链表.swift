//
//  114_二叉树展开为链表.swift
//  Algorithms
//
//  Created by sheng on 2022/10/25.
//

import Foundation
// https://leetcode.cn/problems/flatten-binary-tree-to-linked-list/

class Flatten {
    // 前序遍历：递归
    func flatten1(_ root: TreeNode?) {
        if root == nil {
            return
        }
        
        if root?.left != nil {
            // 保留之前的right
            let oldRight = root?.right
            
            // 将left放到right
            root?.right = root?.left
            
            // 将left清空
            root?.left = nil
            
            // 找到root的最右下角节点
            var mostRight  = root
            while mostRight?.right != nil {
                mostRight = mostRight?.right
            }
            // 将之前保留的right放到mostRight
            mostRight?.right = oldRight
        }
        // 次数左边已经被清空了
        // 直接遍历右边
        flatten(root?.right)
    }
    
    // 前序遍历：迭代
    func flatten2(_ root: TreeNode?) {
        var root = root
        while root != nil {
            if root?.left != nil {
                // 保留之前的right
                let oldRight = root?.right
                
                // 将left放到right
                root?.right = root?.left
                
                // 将left清空
                root?.left = nil
                
                // 找到root的最右下角节点
                var mostRight  = root
                while mostRight?.right != nil {
                    mostRight = mostRight?.right
                }
                // 将之前保留的right放到mostRight
                mostRight?.right = oldRight
            }
            
            root = root?.right
        }
    }
    
    var prev: TreeNode?
    // 后序遍历，这边是先右后左，最后root
    func flatten(_ root: TreeNode?) {
        
        flatten(root?.right)
        flatten(root?.left)
        
        if prev != nil {
            root?.right = prev
            root?.left = nil
        }
        prev = root
    }
}
