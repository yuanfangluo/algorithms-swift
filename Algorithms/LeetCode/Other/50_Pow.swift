//
//  50_Pow.swift
//  Algorithms
//
//  Created by sheng on 2022/10/13.
//

import Foundation
// https://leetcode.cn/problems/powx-n/
// 最简单的方法，也是最笨的方法：
// 将n 个 x 相乘
// 时间复杂度：O(n)
// 空间复杂度：O(1)

// 另外两个方法：
// ① 分治
// ② 快速幂
// 时间复杂度是 O(logn)
// 非递归空间复杂度：O(1)
// 递归空间复杂度：O(logn)


class Pow: Runnable {
    
    func run() {
        print("-1 / 2 = \(-1/2)")
        print("-1 >> 1 = \((-1) >> 1)")
        print(myPow(2.0, 10))
    }
    
    // 分治：递归
    private func myPow2(_ x: Double, _ n: Int) -> Double {
        if n == 0 {
            return 1
        }
        
        if n == -1 {
            return 1 / x
        }
        
        // 判断 n 是否是奇数
        let odd = (n & 1) == 1
        
        var half = myPow(x, n >> 1)
        
        half *= half
        
        //        let x = (n < 0) ? (1 / x) : x
        /*
         首先：
         -1 >> 1 = -1
         如果是正数：
         奇数： 3^7
         3^7 = 3^3 * 3^3 * 3
         偶数
         3^8 = 3^4 * 3^4
         如果是负数：
         奇数：-7
         3^(-7) = 3^(-4) * 3^(-4) * 3
         -7 / 2 = -3
         -7 >> 1 = -4
         偶数：-8
         3^(-8) = 3^(-4) * 3^(-4)
         
         总结：
         不管是正数还是负数，只要是奇数，那就：
         一半 * 一半 * x
         如果是偶数，那就：
         一半 * 一半
         */
        return odd ? half * x : half
    }
    
    // 快速幂：非递归
    /**
     
     
     
     
     */
    private func myPow(_ x: Double, _ n: Int) -> Double {
        let neg = (n < 0)
        var y = neg ? -n : n
        var res = 1.0
        var x = x
        
        while y > 0 {
//            print(n & 1)
            if (y & 1) == 1 {
                res *= x
            }
            
            x *= x
            // 丢掉最后一位
            y >>= 1
        }
        
        return neg ? (1 / res) : res
    }
}

// 求x的y次幂模z的结果: x^y % z
// 其中x，y可能是很大的整数，z是整数
// x >= 0, y >= 0, z != 0
class PowMod: Runnable {
    
    func run() {
        print(powMod2(-123, 455, 789), powMod3(-123, 455, 789))
    }
    
    // 该方法会溢出，不好
    func powMod(_ x: Int, _ y: Int, _ z: Int) -> Int {
        var res = 1
        var x = x
        var y = y
        while y > 0 {
//            print(n & 1)
            if (y & 1) == 1 {
                res *= x
            }
            
            x *= x
            // 丢掉最后一位
            y >>= 1
        }
        
        return res % z // 如果这样，会溢出,应该在计算的过程中就开始模运算
    }
    
    // 公式须知
    // (a * b) % p = ((a % p) * (b % p)) % p
    
    // 快速幂：非递归
    func powMod2(_ x: Int, _ y: Int, _ z: Int) -> Int {
        var res = 1 % z
        var x = x
        var y = y
        x %= z
        while y > 0 {
//            print(n & 1)
            if (y & 1) == 1 {
                res = (res * x) % z
            }
            
            x = (x * x) % z
            // 丢掉最后一位
            y >>= 1
        }
        
        return res
    }
    
    // 分治：递归
    func powMod3(_ x: Int, _ y: Int, _ z: Int) -> Int {
        if y == 0 {
            return 1 % z
        }
        
        // 判断 n 是否是奇数
        let odd = (y & 1) == 1
        
        var half = powMod3(x, y >> 1, z)
        
        half *= half
        
        return odd ? (half * (x % z)) % z : (half % z)
        
    }
}
