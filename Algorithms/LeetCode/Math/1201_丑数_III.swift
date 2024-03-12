//
//  1201_丑数_III.swift
//  Algorithms
//
//  Created by sheng on 2022/10/29.
//

import Foundation
// https://leetcode.cn/problems/ugly-number-iii/

class UglyNumberIII {
    
    /**
     首先，我们可以定义一个单调递增的函数f：
     f(num, a, b, c)计算[1..num]中，能够整除a或b或c的数字的个数，显然函数f的返回值是随着num的增加而增加的（单调递增）。
     
     题目让我们求第n个能够整除a或b或c的数字是什么，也就是说我们要找到一个最小的num，使得f(num, a, b, c) == n。

     这个num就是第n个能够整除a或b或c的数字。
     
     */
    
    func nthUglyNumber(_ n: Int, _ a: Int, _ b: Int, _ c: Int) -> Int {
        // 题目说本题结果在 [1, 2 * 10^9] 范围内，
        // 所以就按照这个范围初始化两端都闭的搜索区间
        var left = 0
        var right: Int = Int(2e9)
        // 搜索左侧边界的二分搜索
        while left <= right {
               let mid = left + (right - left) / 2
               if f(mid, a, b, c) < n {
                   // [1..mid] 中符合条件的元素个数不足 n，所以目标在右半边
                   left = mid + 1
               } else {
                   // [1..mid] 中符合条件的元素个数大于 n，所以目标在左半边
                   right = mid - 1
               }
           }
           return left;
    }
    // 函数 f 是一个单调函数
    // 计算 [1..num] 之间有多少个能够被 a 或 b 或 c 整除的数字
    // 说一下函数f怎么实现，这里面涉及容斥原理以及最小公因数、最小公倍数的计算方法。
// 首先，我把[1..num]中能够整除a的数字归为集合A，能够整除b的数字归为集合B，能够整除c的数字归为集合C，那么len(A) = num / a, len(B) = num / b, len(C) = num / c
    
    // 但是f(num, a, b, c)的值肯定不是num / a + num / b + num / c这么简单，因为你注意有些数字可能可以被a, b, c中的两个数或三个数同时整除，如下图：
    // https://mmbiz.qpic.cn/sz_mmbiz_jpg/gibkIz0MVqdFsNibLuF4mGUoubxiapHxZNsXbpicSfgo9iaOgdng4hZTOAnzIB3icD0bR7xWnXbHbNrqr6icbSmEU7SCQ/640?wx_fmt=jpeg&wxfrom=5&wx_lazy=1&wx_co=1
    
    // 按照容斥原理，这个集合中的元素应该是：A + B + C - A ∩ B - A ∩ C - B ∩ C + A ∩ B ∩ C
    
    // 问题来了，A, B, C三个集合的元素个数我们已经算出来了，但如何计算像 A ∩ B 这种交集的元素个数呢？
    
    // 其实也很容易想明白，A ∩ B的元素个数就是num / lcm(a, b)，其中lcm是计算最小公倍数（Least Common Multiple）的函数
    
    // 类似的，A ∩ B ∩ C的元素个数就是num / lcm(lcm(a, b), c)的值
    
    // 现在的问题是，最小公倍数怎么求？
    
    // 直接记住定理吧：lcm(a, b) = a * b / gcd(a, b)，其中gcd是计算最大公因数（Greatest Common Divisor）的函数。
    
    // 现在的问题是，最大公因数怎么求？这应该是经典算法了，我们一般叫辗转相除算法（或者欧几里得算法）。
    
    // 好了，套娃终于套完了，我们可以把上述思路翻译成代码就可以实现f函数
    
    
    func f(_ num: Int, _ a: Int, _ b: Int, _ c: Int) -> Int {
        
        let setA = num / a
        let setB = num / b
        let setC = num / c
        let setAB = num / lcm(a, b)
        let setAC = num / lcm(a, c)
        let setBC = num / lcm(b, c)
        let setABC = num / lcm(lcm(a, b), c)
        
        // 集合论定理：A + B + C - A ∩ B - A ∩ C - B ∩ C + A ∩ B ∩ C
        return setA + setB + setC - setAB - setAC - setBC + setABC
    }
    
    // 最大公因数
    func gcd(_ a: Int, _ b: Int) -> Int {
        if a < b {
            // 需要保证 a > b
            return gcd(b, a)
        }
        
        if b == 0 {
            return a
        }
        
        return gcd(b, a % b)
    }
    
    // 最小公倍数
    func lcm(_ a: Int, _ b: Int) -> Int {
        // 最小公倍数就是乘积除以最大公因数
        return a * b / gcd(a, b);
    }
    
}
