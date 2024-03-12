//
//  素数.swift
//  Algorithms
//
//  Created by sheng on 2022/10/29.
//

import Foundation

// 如果一个大于1的自然数中,如果只能被 1 和它本身整除，那么这个数就是素数。
// 1 不是素数
class Primes {
    
    // 返回区间 [2, n) 中有几个素数
    // 比如 countPrimes(10) 返回 4
    // 因为 2,3,5,7 是素数
    
    /**
     首先从 2 开始，我们知道 2 是一个素数，那么 2 × 2 = 4, 3 × 2 = 6, 4 × 2 = 8… 都不可能是素数了。

     然后我们发现 3 也是素数，那么 3 × 2 = 6, 3 × 3 = 9, 3 × 4 = 12… 也都不可能是素数了。
     
     图片：
     https://mmbiz.qpic.cn/mmbiz_gif/map09icNxZ4nsaZVRZkibM5SxAX4wmNHagHwhicoaEOSNFlnt47tqY9U9qKKoBYE4vvxG5kFhBzcRRKy7wYbzmiaUw/640?wx_fmt=gif&wxfrom=5&wx_lazy=1
     */
    // 先看我们的第一版代码
    func countPrimes1(_ n: Int) -> Int {
        // 将数组都初始化为 true
        var isPrim = Array(repeating: true, count: n)
        
        for i in 2..<n {
            if isPrim[i] { // 如果i这个位置是素数
                // 那么 i 的倍数不可能是素数了
                for j in stride(from: 2 * i, to: n, by: i) {
                    isPrim[j] = false
                }
            }
        }
        
        var count = 0
        for i in 2..<n {
            if isPrim[i] {
                count += 1
            }
        }
        
        return count
    }
    
    // 版本二：
    // 素数计数的算法就高效实现了。其实这个算法有一个名字，叫做 Sieve of Eratosthenes, 埃拉托斯特尼筛法
    // 该算法的时间复杂度比较难算，显然时间跟这个嵌套 for 循环有关，其操作数应该是：
    // n/2 + n/3 + n/5 + n/7 + … = n × (1/2 + 1/3 + 1/5 + 1/7…)
    // 括号中是素数的倒数和。其最终结果是 O(N * loglogN)
    func countPrimes2(_ n: Int) -> Int {
        // 将数组都初始化为 true
        var isPrim = Array(repeating: true, count: n)
        
        // 回想刚才判断一个数是否是素数的isPrime函数，由于因子的对称性，其中的 for 循环只需要遍历[2,sqrt(n)]就够了。
        // 这里也是类似的，我们外层的 for 循环也只需要遍历到sqrt(n)
        var i = 2
        while i * i < n {
            if isPrim[i] { // 如果i这个位置是素数
                // 那么 i 的倍数不可能是素数了
                
                // 把i的整数倍都标记为false，但是仍然存在计算冗余。
                
                // 比如i = 4时算法会标记 4 × 2 = 8，4 × 3 = 12 等等数字，但是 8 和 12 已经被i = 2和i = 3的 2 × 4 和 3 × 4 标记过了。

                // 我们可以稍微优化一下，让j从i的平方开始遍历，而不是从2 * i开始
                for j in stride(from: i * i, to: n, by: i) {
                    isPrim[j] = false
                }
            }
            i += 1
        }
        
        var count = 0
        for i in 2..<n {
            if isPrim[i] {
                count += 1
            }
        }
        
        return count
    }
    
    // 判断整数 n 是否是素数
    /**
     i不需要遍历到n，而只需要到sqrt(n)即可。为什么呢，我们举个例子，假设n = 12。
     
     12 = 2 × 6
     12 = 3 × 4
     12 = sqrt(12) × sqrt(12)
     12 = 4 × 3
     12 = 6 × 2
     
     可以看到，后两个乘积就是前面两个反过来，反转的分界点就在sqrt(n)。

     换句话说，如果在[2,sqrt(n)]这个区间之内没有发现可整除因子，就可以直接断定n是素数了，因为在区间[sqrt(n),n]也一定不会发现可整除因子。

     这样，isPrime函数的时间复杂度降为了 O(sqrt(N))，但是我们实现countPrimes函数其实并不需要这个函数，以上只是希望读者明白sqrt(n)的含义，因为等会还会用到。
     */
    func isPrime(_ n: Int) -> Bool {
        var i = 2
        while i * i < n {
            if n % i == 0 {
                // 有其他整除因子
                return false
            }
            i += 1
        }
        return true
    }
    
}
