//
//  Greedy.swift
//  Algorithms
//
//  Created by sheng on 2022/9/12.
//

import Foundation
// 贪心
// 每一步都采取当前状态下最优的选择（局部最优解），从而推导出全局最优解

// 贪心的应用
/**
 - 哈夫曼树
 - 最小生成树算法：Prim、Kruskal
 - 最短路径算法：Dijkstra
 */

// 练习
// 最优加载问题（加勒比海盗）
class Pirate: Runnable {
    func run() {
        var weights = [3, 5, 4, 10, 7, 14, 2, 11]
        weights.sort() // 默认就是从小到大排序
        print(weights)
        var capacity = 30, currentWeight = 0
        var result: [Int] = []
        for weight in weights {
            currentWeight += weight
            if currentWeight <= capacity {
                result.append(weight)
            } else {
                currentWeight -= weight
                break
            }
        }
        print(result, currentWeight)
    }
}

// 零钱兑换
// 假设有25分，10分，5分，1分的硬币，现要找给客户41分的零钱，如何办到硬币个数最少
class PocketMoney: Runnable {
    func run() {
//        var faces = [25, 5, 10, 1]
        var faces = [25, 5, 20, 1]
        var money = 41
        coinChange(&faces, &money)
    }
    
    func coinChange(_ faces: inout [Int], _ money: inout Int) {
        faces.sort(by: >)
        print(faces)
        var result: [Int] = [], i = 0
        while i < faces.count {
            if money < faces[i] {
                i += 1
                continue
            }
            money -= faces[i]
            result.append(faces[i])
        }
        print(result)
    }
}

// 贪心策略并不一定得到全局最优解
// 可以使用动态规划得到最优解

// 0-1背包
/**
 有n件物品和一个最大承重为W的背包，每件物品的重量是wi，价值是vi
 在保证总重量不超过W的前提下，将哪几件物品装入背包，可以使得背包的总价值最大
 注意：每个物品只有1件
 如果采用贪心策略，有三个方案：
 （1）价值主导
 （2）重量主导
 （3）价值密度主导
 */
class Knapsack: Runnable {
    struct Item: CustomDebugStringConvertible {
        let weight: Int
        let value: Int
        var valueDensity: Double {
            Double(value) / Double(weight)
        }
        var debugDescription: String {
            "weight = \(weight), value = \(value), valueDensity = \(String(format: "%.2f", valueDensity))"
        }
    }
    
    func run() {
        select("价值主导") { i1, i2 in
            i1.value > i2.value
        }
        
        select("重量主导") { i1, i2 in
            i1.weight < i2.weight
        }
        
        select("价值密度主导") { i1, i2 in
            i1.valueDensity > i2.valueDensity
        }
    }
    
    func select(_ title: String, _ areInIncreasingOrder: (Item, Item) -> Bool) {
        var items = [
            Item(weight: 35, value: 10),
            Item(weight: 30, value: 40),
            Item(weight: 60, value: 30),
            Item(weight: 50, value: 50),
            Item(weight: 40, value: 35),
            Item(weight: 10, value: 40),
            Item(weight: 25, value: 30),
        ]
        
        items.sort(by: areInIncreasingOrder)
//        print(items)
        var capacity = 150, weight = 0, value = 0
        var result: [Item] = []
        for item in items {
            let newWeight = weight + item.weight
            if newWeight <= capacity {
                weight = newWeight
                value += item.value
                result.append(item)
            }
        }
        for item in result {
            print(item)
        }
        print(value)
    }
}



