//
//  BinaryTree.swift
//  Algorithms
//
//  Created by sheng on 2022/9/22.
//

import Foundation

// 二叉树的问题首先想到使用递归

// 前序遍历 （先遍历自己，再遍历左边，最后遍历右边）

// 中序遍历 （先遍历左边，再遍历自己，最后遍历右边）

// 后序遍历 （先遍历左边，再遍历右边，最后遍历自己）

// 层序遍历 一层一层遍历

class BinaryTree {
    
    // 前序: 递归
    func preorderTraverse(_ node: TreeNode?) {
        if node == nil {
            return
        }
        // 访问节点
        print(node!.val)
        preorderTraverse(node?.left)
        preorderTraverse(node?.right)
    }
    
    // 中序: 递归
    func inorderTraverse(_ node: TreeNode?) {
        if node == nil {
            return
        }
        inorderTraverse(node?.left)
        print(node!.val)
        inorderTraverse(node?.right)
    }
    
    // 后序：递归
    func postorderTraverse(_ node: TreeNode?) {
        if node == nil {
            return
        }
        postorderTraverse(node?.left)
        postorderTraverse(node?.right)
        print(node!.val)
    }
    
    // 层序：使用queue
    func levelOrderTraversal(_ node: TreeNode?){
        if node == nil {
            return
        }
        
        let queue = Queue<TreeNode>()
        queue.enqueue(node!)
        while !queue.isEmpty {
            // 访问节点
            let node = queue.dequeue()
            print(node!.val)
            if (node?.left != nil) {
                queue.enqueue((node?.left)!)
            }
            
            if (node?.right != nil) {
                queue.enqueue((node?.right)!)
            }
        }
    }
    
    // 前序: 迭代，使用栈
    func preorderTraversal2(_ node: TreeNode?) {
        if node == nil {
            return
        }
        let stack = Stack<TreeNode>()
        stack.push(node!)
        while !stack.isEmpty {
            let node = stack.pop()
            // 访问节点
            print(node!.val)
            // 先将右子节点入栈
            if node?.right != nil {
                stack.push(node!.right!)
            }
            // 再将左子节点入栈
            if node?.left != nil {
                stack.push(node!.left!)
            }
        }
    }
    
    // 前序: 迭代，使用栈
    func preorderTraversal3(_ node: TreeNode?) {
        var node = node
        if node == nil {
            return
        }
        let stack = Stack<TreeNode>()
        while true {
            if node != nil {
                // 访问节点
                print(node!.val)
                // 将右子节点入栈
                if node!.right != nil {
                    stack.push(node!.right!)
                }
                // 向左走
                node = node?.left
            } else if stack.isEmpty {
                return
            } else {
                // 处理右边
                node = stack.pop()
            }
        }
    }
    

    // 中序：迭代 使用栈
    func inorderTraversal2(_ node: TreeNode?) {
        var node = node
        if node == nil {
            return
        }
      
        let stack = Stack<TreeNode>()
        while true {
            if node != nil {
                stack.push(node!)
                // 向左走
                node = node?.left
            } else if stack.isEmpty {
                return
            } else {
                node = stack.pop()
                // 访问节点
                print(node!.val)
                node = node?.right
            }
        }
    }
    
    // 后序：迭代
    func postorderTraversal2(_ node: TreeNode?) {
        let node = node
        if node == nil {
            return
        }
      
        let stack = Stack<TreeNode>()
        stack.push(node!)
        var pre: TreeNode? = nil
        while !stack.isEmpty {
            let top = stack.top
            // 如果栈顶节点是叶子节点
            let leaf = (top?.left == nil) && (top?.right == nil)
            // 如果上一次访问的节点是栈顶节点的子节点
            let preIsChild = (pre != nil) && ((pre == top?.left) || pre == top?.right)
            
            if leaf || preIsChild {
                // 访问栈顶节点
                print(top!.val)
                
                // 弹出栈顶节点
                stack.pop()
                
                // 标记为已访问
                pre = top
            } else {
                if top?.right != nil {
                    stack.push((top?.right)!)
                }
                
                if top?.left != nil {
                    stack.push((top?.left)!)
                }
            }
        }
    }
    
    var res = 0
    var depth = 0
    
    // 树的深度
    //
    
    /**
     基本概念：
     层数：
     根节点在第1层，根节点的子节点在第2层，以此类推。
     节点的深度：从根节点到当前节点的路径上的节点总数
     节点的高度：从当前节点到最远节点路径上的节点总数
     树的深度：节点深度的最大值
     数的高度：节点高度的最大值
     树的深度 = 树的高度
     */
    func maxDepth1(_ root: TreeNode?) -> Int {
        traverse(root)
        return res
    }
    
    // 回溯算法
    func traverse(_ root: TreeNode?) {
        if root == nil {
            res = max(res, depth)
            return
        }
        
        // 前序遍历位置做选择
        depth += 1
        
        traverse(root?.left)
        
        traverse(root?.right)
        // 后序遍历位置取消选择
        depth -= 1
    }
    
    // 根据一棵树的根节点，计算出这棵树的最大深度
    func maxDepth(_ root: TreeNode?) -> Int {
        if root == nil {
            return 0
        }
        // 递归计算左右子树的最大深度
        let leftMax = maxDepth(root?.left)
        
        let rightMax = maxDepth(root?.right)
        
        // 整棵树的最大深度
        let reslut = max(leftMax, rightMax) + 1
        return reslut
    }
    
}


public class TreeNode {
    public var val: Int
    public var left: TreeNode?
    public var right: TreeNode?
    public init() { self.val = 0; self.left = nil; self.right = nil; }
    public init(_ val: Int) { self.val = val; self.left = nil; self.right = nil; }
    public init(_ val: Int, _ left: TreeNode?, _ right: TreeNode?) {
        self.val = val
        self.left = left
        self.right = right
    }
}

extension TreeNode: Equatable {
    public static func == (lhs: TreeNode, rhs: TreeNode) -> Bool {
        lhs.val == rhs.val
    }
}

extension TreeNode {
    func isLeaf() -> Bool {
        self.left == nil && self.right == nil
    }
}
