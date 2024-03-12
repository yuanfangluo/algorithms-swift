//
//  Stack.swift
//  Algorithms
//
//  Created by sheng on 2022/10/23.
//

import Foundation

class Stack<T> {
    var array: [T] = []
    var isEmpty: Bool {
        array.isEmpty
    }
    
    var top: T? {
        if isEmpty {
            return nil
        } else {
            return array.last
        }
    }
    
    func push(_ t: T) {
        array.append(t)
    }
    @discardableResult
    func pop() -> T? {
        if isEmpty {
            return nil
        } else {
            return array.removeLast()
        }
    }
}
