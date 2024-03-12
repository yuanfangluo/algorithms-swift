//
//  剑指Offer_62_圆圈中最后剩下的数字.swift
//  Algorithms
//
//  Created by sheng on 2022/10/13.
//

import Foundation
// https://leetcode.cn/problems/yuan-quan-zhong-zui-hou-sheng-xia-de-shu-zi-lcof/

class LastRemaining: Runnable {
    
    func run() {
        print(lastRemaining(11, 3), lastRemaining2(11, 3))
    }
    
    // 公式：f(n, m) = (f(n - 1, m) + m) % n
   private func lastRemaining(_ n: Int, _ m: Int) -> Int {
        
        if n == 1 {
            return 0
        }
        
        return (lastRemaining(n - 1, m) + m) % n
       }
    
    // 非递归
   private func lastRemaining2(_ n: Int, _ m: Int) -> Int {
        
        var res = 0
        
        for i in 2...n {
            res = (res + m) % i
        }
        
        return res
    }
    
    // 编号 从1 开始呢？
    private func lastRemaining3(_ n: Int, _ m: Int) -> Int {
         
         var res = 0
         
         for i in 2...n {
             res = (res + m) % i
         }
         
         return res + 1
     }
    
}
