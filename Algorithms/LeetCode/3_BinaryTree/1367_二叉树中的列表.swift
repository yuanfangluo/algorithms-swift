//
//  1367_二叉树中的列表.swift
//  Algorithms
//
//  Created by sheng on 2022/10/26.
//

import Foundation
// https://leetcode.cn/problems/linked-list-in-binary-tree/

class IsSubPath {
    func isSubPath(_ head: ListNode?, _ root: TreeNode?) -> Bool {
        
        
        
        
        
        return false
    }
    
    func level(_ root: TreeNode?, _ head: ListNode?) {
        if root == nil {
            return
        }
        
        let queue = Queue<TreeNode>()
        queue.enqueue(root!)
        while !queue.isEmpty {
            let node = queue.dequeue()
            
            print(node!.val)
            
            // 判断是否有head
            if node!.val == head?.val { // 在二叉树里面找到head
                check(head, node)
            }
            
            if node?.left != nil {
                queue.enqueue((node?.left)!)
            }
            
            if node?.right != nil {
                queue.enqueue((node?.right)!)
            }
        }
    }
    
    @discardableResult
    func check(_ head: ListNode?, _ root: TreeNode?) -> Bool {
        var head = head
        let root = root
        while head?.next != nil {
            head = head?.next
            
            if root?.left != nil {
                
            }
            
            if root?.right != nil {
                
            }
        }
        
        return true
    }
}
