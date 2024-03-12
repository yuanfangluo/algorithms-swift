//
//  MonotonicQueue.swift
//  Algorithms
//
//  Created by sheng on 2022/11/3.
//

import Foundation

class MonotonicQueue<E: Comparable> {
    
    // 常规队列，存储所有元素
    var q: [E] = []
    
    // 元素降序排列的单调队列，头部是最大值
    var maxq: [E] = []
    // 元素升序排列的单调队列，头部是最小值
    var minq: [E] = []
    
    func push(_ e: E) {
        // 维护常规队列，直接在队尾插入元素
        q.append(e)
        
        // 维护 maxq，将小于 elem 的元素全部删除
        while !maxq.isEmpty && maxq.last! < e{
            maxq.removeLast()
        }
        maxq.append(e)
        
        while !minq.isEmpty && minq.last! > e {
            minq.removeLast()
        }
        minq.append(e)
       
    }
    
    var max: E? {
        maxq.first
    }
    
    var min: E? {
        minq.first
    }
    
    @discardableResult
    func pop() -> E? {
        // 从标准队列头部弹出需要删除的元素
        if q.isEmpty {
            return nil
        }
        
        let deletedVal = q.removeFirst()
        
        if deletedVal == maxq.first {
            maxq.removeFirst()
        }
        
        if deletedVal == minq.first {
            minq.removeFirst()
        }
        
        return deletedVal
    }
    
    var size: Int {
        q.count
    }
    
    var isEmpty: Bool {
        q.isEmpty
    }
}
