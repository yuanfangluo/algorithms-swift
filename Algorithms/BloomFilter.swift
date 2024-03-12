//
//  BloomFilter.swift
//  Algorithms
//
//  Created by sheng on 2022/9/16.
//

import Foundation

// 如果要经常判断一个元素是否存在，你会怎么做？
/**
 很容易想到使用哈希表，将元素作为key去查找
 时间复杂度：O(1)，但是空间利用率不高，需要占用比较多的内存资源
 
 如果需要编写一个网络爬虫去爬10亿个网站数据，为了避免爬到重复的网站，如何判断某个网站是否爬过？
 很显然。哈希表不是一个很好的选择
 是否存在时间复杂度低，占用内存较少的方案？
 布隆过滤器（Bloom Filter）
 它是一个空间效率高的概率型数据结构，可以用来告诉你：一个元素一定不存在或者可能存在
 优缺点：
 优点：空间效率和查询时间都远远超过一般都算法
 缺点：有一定的误判率，删除困难
 使用场景：
 1. 经常要判断某个元素是否存在
 2. 元素数量巨大，希望用较少的内存空间
 3. 允许有一定的误判率
 
 它实质上是一个很长的二进制向量和一系列随机映射函数（hash函数）
 常见应用：
 - 网页黑名单系统
 - 垃圾邮件过滤系统
 - 爬虫的网址判重系统
 - 解决缓存穿透问题
 
 添加查询的时间复杂度是O(k)，k是哈希函数
 空间复杂度O(m)，m是二进制位是长度
 */

struct BloomFilter<T> {
//    二进制长度
    var bitSize: Int
//     二进制向量
    var bits: [Int]
    // hash函数的个数
    var hashSize: Int
    
    var n: Int // 数据规模
    var p: Double // 误判率
    
    func put(_ value: T) {
        
    }
    
    func contains(_ value: T) -> Bool {
        
        false
    }
}

