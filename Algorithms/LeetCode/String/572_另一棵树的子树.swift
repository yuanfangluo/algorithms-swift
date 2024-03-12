//
//  572_另一棵树的子树.swift
//  Algorithms
//
//  Created by sheng on 2022/9/21.
//

import Foundation
// https://leetcode.cn/problems/subtree-of-another-tree/

// 二叉树的序列化
class SubtreeOfAnotherTree: Runnable {
    func isSubtree(_ root: TreeNode?, _ subRoot: TreeNode?) -> Bool {
        if root == nil || subRoot == nil {
            return false
        }
        return postSerialize(root).contains(postSerialize(subRoot))
    }
    
    func run() {
        let root = TreeNode(3)
        let four = TreeNode(4)
        let one = TreeNode(1)
        let two = TreeNode(2)
        let five = TreeNode(5)
        four.left = one
        four.right = two
        root.left = four
        root.right = five
        print(postSerialize(root))
    }
    
    func postSerialize(_ node: TreeNode?) -> String {
        var string = "!"
        postSerialize(node, &string)
        return string
    }
    
    //    后序遍历
    func postSerialize(_ node: TreeNode?, _ string: inout String) {
        if node?.left == nil {
           string = string + "#!"
        } else {
            postSerialize(node?.left, &string)
        }
        
        if node?.right == nil {
            string = string + "#!"
        } else {
            postSerialize(node?.right, &string)
        }
        string = string + "\(node!.val)!"
    }
    
}

// 思考：怎么反序列化
