//
//  313_超级丑数.swift
//  Algorithms
//
//  Created by sheng on 2022/10/29.
//

import Foundation

// https://leetcode.cn/problems/super-ugly-number/

class NthSuperUglyNumber {
    
    /**
     所谓超级丑数是一个所有质因数都出现在primes中的正整数
     如果让primes = [2, 3, 5]就是上道题，所以这道题是上道题的进阶版。
     
     不过思路还是类似的，你还是把每个质因子看做一条有序链表，上道题相当于让你合并三条有序链表，而这道题相当于让你合并len(primes)条有序链表，也就是 双指针技巧秒杀七道链表题目 中讲过的「合并 K 条有序链表」的思路。
     
     注意我们在上道题抽象出了三条链表，需要p2, p3, p5作为三条有序链表上的指针，同时需要product2, product3, product5记录指针所指节点的值，每次循环用min函数计算最小头结点。
     
     这道题相当于输入了len(primes)条有序链表，我们不能用min函数计算最小头结点了，而是要用优先级队列来计算最小头结点，同时依然要维护链表指针、指针所指节点的值，我们可以用一个三元组来保存这些信息。

     你结合 双指针技巧秒杀七道链表题目 合并 K 条有序链表的思路就能理解这道题的解法：
     
     */
    func nthSuperUglyNumber(_ n: Int, _ primes: [Int]) -> Int {
        // 优先队列中装三元组 int[] {product, prime, pi}
        // 其中 product 代表链表节点的值，prime 是计算下一个节点所需的质数因子，pi 代表链表上的指针
        let pq = PriorityQueue<[Int]>{ n1, n2 in n1[0] < n2[0] }
        
        // 把多条链表的头结点加入优先级队列
        for i in 0..<primes.count {
            pq.offer([1, primes[i], 1])
        }
        
        // 可以理解为最终合并的有序链表（结果链表）
        var ugly = Array(repeating: 0, count: n + 1)
        // 可以理解为结果链表上的指针
        var p = 1;
        
        while (p <= n) {
            // 取三个链表的最小结点
            let pair = pq.dequeue()!;
            let product = pair[0]; // 节点值
            let prime = pair[1];
            let index = pair[2];
            
            // 避免结果链表出现重复元素
            if product != ugly[p - 1] {
                // 接到结果链表上
                ugly[p] = product
                p += 1
            }
            
            // 生成下一个节点加入优先级队列
            let nextPair = [ugly[index] * prime, prime, index + 1]
            pq.offer(nextPair)
        }
        
        return ugly[n]
    }
}
