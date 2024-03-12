//
//  263_丑数.swift
//  Algorithms
//
//  Created by sheng on 2022/10/29.
//

import Foundation
// https://leetcode.cn/problems/ugly-number/

/**
 首先，「丑数」系列问题属于会者不难难者不会的类型，因为会用到些数学定理嘛，如果没有专门学过，靠自己恐怕是想不出来的。
 
 另外，这类问题而且非常考察抽象联想能力，因为它除了数学定理之外，还需要你把题目抽象成链表相关的题目运用双指针技巧，或者抽象成数组相关的题目运用二分搜索技巧。
 
 
 */

// 丑数 就是只包含质因数 2、3 和 5 的正整数。
// 习惯上将1视作第一个丑数。

class IsUgly {
    func isUgly(_ n: Int) -> Bool {
        var n = n
        if n <= 0 {
            return false
        }
        
        while n % 2 == 0 {
            n /= 2
        }
        
        while n % 3 == 0 {
            n /= 3
        }
        
        while n % 5 == 0 {
            n /= 5
        }
        
        return n == 1
    }
}


