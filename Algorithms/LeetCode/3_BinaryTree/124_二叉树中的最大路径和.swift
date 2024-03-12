//
//  124_二叉树中的最大路径和.swift
//  Algorithms
//
//  Created by sheng on 2022/10/25.
//

import Foundation
// https://leetcode.cn/problems/binary-tree-maximum-path-sum/
// 思路：针对每一个节点，穿过它但是不穿过它父节点的所有路径的最大路径和
// 那么整体的最大路径和就是这些最大路径和的最大值
// 思路：求一个节点能提供给父节点的最大路径值？
// 采用后序遍历求
// 因为就是一个简单的后序遍历
// 时间复杂度：O(n)
// 空间复杂度：O(n)
class BTMPS {
    func maxPathSum(_ root: TreeNode?) -> Int {
        value(root)
        return sum
    }
    
    // 最终的最大值
    var sum = Int.min
    
    // 求一个节点能够给父节点提供的最大路径值
    @discardableResult
    func value(_ node: TreeNode?) -> Int {
        if node == nil {
            return 0
        }
        let lv = max(value(node?.left), 0)
        let rv = max(value(node?.right), 0)
        
        // 后序位置
        // 计算穿过该节点大最大路径值
        let curSum = node!.val + lv + rv
        sum = max(sum, curSum)
        return node!.val + max(lv, rv)
    }
}
