//
//  146_LRU缓存.swift
//  Algorithms
//
//  Created by sheng on 2022/10/14.
//

import Foundation
// https://leetcode.cn/problems/lru-cache/
// 最常见的方法是：哈希表和双向链表
class LRUCache {
    var map: [Int: Node] = [:]
    var capacity: Int
    // 虚拟头节点
    var first: Node
    // 虚拟尾节点
    var last: Node
    
    init(_ capacity: Int) {
        self.capacity = capacity
        first = Node()
        last = Node()
        // 一开始双向链表没有任何节点，只有虚拟头节点和虚拟尾节点
        first.next = last
        last.prev = first
    }
    
    func get(_ key: Int) -> Int {
        let node = map[key]
        if node == nil {
            return -1
        }
        // 在这里需要将key放到最前面
        removeNode(node)
        addAfterFirst(node)
        return node!.value!
    }
    
    private func removeNode(_ node: Node?){
        node?.next?.prev = node?.prev
        node?.prev?.next = node?.next
    }
    
    private func addAfterFirst(_ node: Node?) {
        // 先维护node与first.next
        node?.next = first.next
        first.next?.prev = node
        
        // 再维护node和first
        first.next = node
        node?.prev = first
    }
    
        func put(_ key: Int, _ value: Int) {
            let node = map[key]
            if node != nil {
                node?.value = value
                removeNode(node)
                addAfterFirst(node)
            } else {
                // 不存在,，添加新的
                if map.count == capacity {
                    // 需要先移除最近未使用，再添加
                    // 先删除尾节点的prev的key，再删除虚拟尾节点的key
                    removeNode(map.removeValue(forKey: (last.prev?.key)!))
                }
                let newNode = Node(key: key, value: value)
                map[key] = newNode
                addAfterFirst(newNode)
            }
        }
    
    class Node {
        var key: Int?
        var value: Int?
        var prev: Node?
        var next: Node?
        
        init(key: Int, value: Int) {
            self.key = key
            self.value = value
        }
        
        init(){
            
        }
    }
}

