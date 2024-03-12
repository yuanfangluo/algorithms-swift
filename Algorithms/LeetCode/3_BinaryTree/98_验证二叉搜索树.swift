//
//  98_验证二叉搜索树.swift
//  Algorithms
//
//  Created by sheng on 2022/9/28.
//

import Foundation
// https://leetcode.cn/problems/validate-binary-search-tree/

class ValidateBST {
    
    func isValidBST(_ root: TreeNode?) -> Bool {
            isValidBST(root, nil, nil)
    }
    
    var prevNode: TreeNode?
    
    // 思路一：二叉搜索树的中序遍历是递增的
    // 使用递归来中序遍历
    // 时间复杂度：O(n)
    // 空间复杂度：O(n)
    func isValidBST1(_ root: TreeNode?) -> Bool {
        if root == nil {
            return true
        }
        
        if !isValidBST(root?.left) {
            return false
        }
        
        if prevNode != nil && prevNode!.val >= root!.val {
            return false
        }
        prevNode = root
        
        if !isValidBST(root?.right) {
            return false
        }
        
        return true
    }
    
    // 迭代
    // 时间复杂度：O(n)
    // 空间复杂度：O(n)
    func isValidBST2(_ root: TreeNode?) -> Bool {
        var node = root
        if node == nil {
            return true
        }
        
        let stack = Stack<TreeNode>()
        while true {
            if node != nil {
                stack.push(node!)
                // 向左走
                node = node?.left
            } else if stack.isEmpty {
                break
            } else {
                node = stack.pop()
                // 访问节点
                if prevNode != nil && prevNode!.val >= node!.val {
                    return false
                }
                prevNode = node
                
                node = node?.right
            }
        }
        return true
    }
    
    // 思路2：遍历的同时指定范围，可以使用前序遍历，中序，后序，层序
    // 这里使用前序
    // 时间复杂度：O(n)
    // 空间复杂度：O(n)
    func isValidBST(_ root: TreeNode?, _ min: Int?, _ max: Int?) -> Bool {
        if root == nil {
            return true
        }
        
        if min != nil && root!.val <= min! {
            return false
        }
        
        if max != nil && root!.val >= max! {
            return false
        }
        
        if !isValidBST(root?.left, min, root?.val) {
           return false
        }
        
        if !isValidBST(root?.right,root?.val, max) {
           return false
        }
        
        return true
    }
    
    // 使用层序遍历
    // 时间复杂度：O(n)
    // 空间复杂度：O(n)
    func isValidBST3(_ root: TreeNode?) -> Bool {
        if root == nil {
            return true
        }
        
        let nodes = Queue<TreeNode>()
        let mins = Queue<Int>()
        let maxs = Queue<Int>()
        nodes.enqueue(root!)
//        mins.enqueue(nil)
//        maxs.enqueue(nil)
        
        while !nodes.isEmpty {
            let node = nodes.dequeue()
            let min = mins.dequeue()
            let max = maxs.dequeue()

            if min != nil && root!.val <= min! {
                return false
            }
            
            if max != nil && root!.val >= max! {
                return false
            }
            
            if node?.left != nil {
                nodes.enqueue((node?.left)!)
                mins.enqueue(min!)
                maxs.enqueue(node!.val)
            }
            
            if node?.right != nil {
                nodes.enqueue((node?.right)!)
                mins.enqueue(node!.val)
                maxs.enqueue(max!)
            }
        }
        return true
    }
    
}
