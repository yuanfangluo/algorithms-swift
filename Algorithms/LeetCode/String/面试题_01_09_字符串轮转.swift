//
//  面试题_01_09_字符串轮转.swift
//  Algorithms
//
//  Created by sheng on 2022/9/21.
//

import Foundation
// https://leetcode.cn/problems/string-rotation-lcci/

class StringRotation {
    func isFlipedString(_ s1: String, _ s2: String) -> Bool {
        
        if s1.isEmpty && s2.isEmpty {
            return true
        }
        
        
        if s1.isEmpty || s2.isEmpty {
            return false
        }
        
        
        if s1.count != s2.count {
            return false
        }
        
        return (s1 + s1).contains(s2)
    }
}
