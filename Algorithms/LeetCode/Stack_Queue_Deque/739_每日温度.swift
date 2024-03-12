//
//  739_每日温度.swift
//  Algorithms
//
//  Created by sheng on 2022/9/21.
//

import Foundation

// https://leetcode.cn/problems/daily-temperatures/

// 给你一个值，找到右边第一个比它大的

class DailyTemperatures: Runnable {
    func run() {
        print(dailyTemperatures2([73,74,75,71,69,72,76,73]))
    }
    
    // 方法二：倒推法精简
    func dailyTemperatures3(_ temperatures: [Int]) -> [Int] {
        var values = Array(repeating: 0, count: temperatures.count)
        for i in stride(from: values.count - 2, through: 0, by: -1) {
            var j = i + 1
            while true {
                if temperatures[i] < temperatures[j] {
                    values[i] = j - i
                    break
                } else if values[j] == 0 {
                    values[i] = 0
                    break
                }
                // 当 temperatures[i] == temperatures[j]
                j = j + values[j]
            }
        }
        return values
    }
    
    
    // 方法二：倒推法
    func dailyTemperatures2(_ temperatures: [Int]) -> [Int] {
        var values = Array(repeating: 0, count: temperatures.count)
        for i in stride(from: values.count - 2, through: 0, by: -1) {
            var j = i + 1
            while true {
                if temperatures[i] < temperatures[j] {
                    values[i] = j - i
                    break
                } else if values[j] == 0 {
                    values[i] = 0
                    break
                } else if temperatures[i] == temperatures[j] {
                    values[i] = values[j] + (j - i)
                    break
                } else {
                    j = j + values[j]
                }
            }
        }
        return values
    }
    
    // 方法一：使用栈找出右边第一个比它大的值
    func dailyTemperatures(_ temperatures: [Int]) -> [Int] {
        var result = Array(repeating: 0, count: temperatures.count)
        let stack = Stack<Int>()
        for i in 0..<temperatures.count {
            // 这里写大于
            while !stack.isEmpty && temperatures[i] > temperatures[stack.top!]  {
                let top = stack.top!
                result[top] = i - top
                stack.pop()
            }
            stack.push(i)
        }
        return result
    }
}
