//
//  121_买卖股票的最佳时机.swift
//  Algorithms
//
//  Created by sheng on 2022/9/22.
//

import Foundation
// https://leetcode.cn/problems/best-time-to-buy-and-sell-stock/

// 剑指 Offer 63. 股票的最大利润: https://leetcode.cn/problems/gu-piao-de-zui-da-li-run-lcof/
class BestTimeToBuyAndSellStock: Runnable {
    
    func run() {
        print(maxProfit([3, 5, 4, 1, 6, 2]))
    }
    
    func maxProfit(_ prices: [Int]) -> Int {
        var maxProfit = 0
        var minPrice = prices[0]
        for i in 1..<prices.count {
            if minPrice > prices[i] {
                minPrice = prices[i]
                continue
            }
            maxProfit = max(maxProfit, prices[i] - minPrice)
        }
        return maxProfit
    }
    
    // 方法二： 动态规划
    
}
