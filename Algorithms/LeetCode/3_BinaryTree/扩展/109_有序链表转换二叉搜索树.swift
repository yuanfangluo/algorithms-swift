//
//  109_有序链表转换二叉搜索树.swift
//  Algorithms
//
//  Created by sheng on 2022/10/29.
//

import Foundation
// https://leetcode.cn/problems/convert-sorted-list-to-binary-search-tree/

class SortedListToBST {
    
    // 思路1： 中序遍历
    var cur: ListNode?
    func sortedListToBST(_ head: ListNode?) -> TreeNode? {
        var p = head
        var len = 0
        while p != nil {
            len += 1
            p = p?.next
        }
        
        cur = head
        
        return inorderBuild(0, len - 1)

    }
    // 函数定义：根据左闭右闭区间 [left, right] 通过中序遍历构造二叉树
    func inorderBuild(_ left: Int, _ right: Int) -> TreeNode? {
        if left > right {
            return nil
        }
        let mid = (left + right) >> 1
        // 1. 构造左子树
        let leftTree = inorderBuild(left, mid - 1)
        // 2. 构造根节点
        let root = TreeNode(cur!.val)
        cur = cur?.next
        
        // 3. 构造右子树
        let rightTree = inorderBuild(mid + 1, right)
        // 4. 将左右子树接到根节点上
        root.left = leftTree
        root.right = rightTree
        return root
    }
    
    // 思路2：通过找链表中点的方式写出解法
    func sortedListToBST2(_ head: ListNode?) -> TreeNode? {
        return buildBST(head, nil)
    }
    
    // 函数定义：将链表左闭右开区间 [begin, end) 的节点构造成 BST
    func buildBST(_ begin: ListNode?, _ end: ListNode?) -> TreeNode? {
        if begin === end {
            // 因为是左闭右开区间，此时已经变成空集了
            return nil
        }
        
        let mid = getMid(begin, end)
        let root = TreeNode(mid!.val)
        
        root.left = buildBST(begin, mid)
        root.right = buildBST(mid?.next, end)
        return root
    }
    // 获取链表左闭右开区间 [begin, end) 的中间节点
    func getMid(_ begin: ListNode?, _ end: ListNode?) -> ListNode? {
        var slow = begin
        var fast = begin
        
        while fast !== end && fast?.next !== end {
            slow = slow?.next
            fast = fast?.next?.next
        }
        
        return slow
    }

}
