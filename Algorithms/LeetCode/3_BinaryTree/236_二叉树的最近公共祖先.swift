//
//  236_二叉树的最近公共祖先.swift
//  Algorithms
//
//  Created by sheng on 2022/9/22.
//

import Foundation
// https://leetcode.cn/problems/lowest-common-ancestor-of-a-binary-tree/

// 剑指 Offer 68 - II. 二叉树的最近公共祖先: https://leetcode.cn/problems/er-cha-shu-de-zui-jin-gong-gong-zu-xian-lcof/

class LowestCommonAncestor {
    
    /// 去以 root 为根节点的二叉树中查找p， q的最近公共祖先
    /// ① 如果p，q同时存在于这颗二叉树中，就能成功返回他们的最近公共祖先
    /// ② 如果p，q 都不存在于这颗二叉树中， 返回 nil
    /// ③ 如果只有p存在于这颗二叉树中，返回 p
    /// ④ 如果只有q存在于这颗二叉树中，返回 q
    func lowestCommonAncestor(_ root: TreeNode?, _ p: TreeNode?, _ q: TreeNode?) -> TreeNode? {
        
        if root == nil || root == p || root == q {
            return root
        }
        
        // 到这里代表p, q 不是根节点
        /// 去以 root.left 为根节点的二叉树中查找p， q的最近公共祖先
        let left = lowestCommonAncestor(root?.left, p, q)
        /// 去以 root.right 为根节点的二叉树中查找p， q的最近公共祖先
        let right = lowestCommonAncestor(root?.right, p, q)
        
        if left != nil && right != nil {
            return root
        }
        
        return left != nil ? left : right
      }
}
