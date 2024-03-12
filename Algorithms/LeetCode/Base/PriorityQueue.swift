//
//  PriorityQueue.swift
//  Algorithms
//
//  Created by sheng on 2022/11/3.
//

import Foundation


typealias PriorityBlock<T> = (T, T) -> Bool

class PriorityQueue<T>: Queue<T> {
    //    var elements: [T]
    var priorityBlock: PriorityBlock<T>
    
    init(_ block: @escaping PriorityBlock<T>) {
        priorityBlock = block
    }
    
    func offer(_ num: T) {
        elements.append(num)
        heapifyUp(count - 1)
    }
    
    @discardableResult
    override func dequeue() -> T? {
        if self.count == 0 {
            return nil
        }
        elements.swapAt(0, count - 1)
        let element = elements.removeLast()
        heapifyDown(0)
        return element
    }
    
    func peek() -> T? {
        if self.count == 0 {
            return nil
        }
        return elements.first!
    }
    
    //! 新增一个元素到末尾，它需要 上溢
    private func heapifyUp(_ i: Int) {
        guard i > 0 else { return }
        let parent = (i - 1) / 2
        if priorityBlock(elements[i], elements[parent]) {
            elements.swapAt(i, parent)
            heapifyUp(parent)
        }
    }
    
    //! 将堆顶删除时，我们是将 堆顶和 数组末互换，再移除的，此时堆顶元素需要下沉
    private func heapifyDown(_ i: Int) {
        let left = i * 2 + 1
        let right = left + 1
        var postion = i
        if left < count && priorityBlock(elements[left], elements[postion]) {
            postion = left
        }
        if right < count && priorityBlock(elements[right], elements[postion]) {
            postion = right
        }
        
        if postion != i {
            elements.swapAt(i, postion)
            heapifyDown(postion)
        }
    }
}
