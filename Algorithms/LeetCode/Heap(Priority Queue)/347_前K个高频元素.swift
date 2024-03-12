//
//  347_前K个高频元素.swift
//  Algorithms
//
//  Created by sheng on 2022/10/25.
//

import Foundation
// https://leetcode.cn/problems/top-k-frequent-elements/

class TopKFrequent: Runnable {
    
    func run() {
        print(topKFrequent3([1,1,1,2,2,3], 2))
    }
    
    func topKFrequent(_ nums: [Int], _ k: Int) -> [Int] {
        return []
    }
    
    // 思路1：先用map统计，再全排序
    func topKFrequent1(_ nums: [Int], _ k: Int) -> [Int] {
        var map: [Int: Int] = [:]
        for num in nums {
            map[num] = (map[num] ?? 0) + 1
        }
//        print(map)
        let array = map.sorted { e1, e2 in
            e1.value > e2.value
        }
//        print(array)
        var result: [Int] = []
        for i in 0..<k {
            result.append(array[i].key)
        }
        return result
    }
    
    // 思路2：PriorityQueue
    // 先用map统计元素，然后维护一个小顶堆，保证小顶堆的元素个数是K个
    // 最后一个一个移除堆顶元素，获取元素
    func topKFrequent2(_ nums: [Int], _ k: Int) -> [Int] {
        return []
    }
    
    // 思路3：桶排序
    // 时间复杂度是：O(n)
    func topKFrequent3(_ nums: [Int], _ k: Int) -> [Int] {
        var map: [Int: Int] = [:]
        for num in nums {
            map[num] = (map[num] ?? 0) + 1
        }
        
        // 桶排序，这里要准备 n + 1 个桶
        var buckets: [[Int]] = Array(repeating: [], count: nums.count + 1)
        // 优化一下最大的有元素的桶
        var maxNo = 0
        for item in map {
            var bucket = buckets[item.value]
            bucket.append(item.key)
            buckets[item.value] = bucket
            maxNo = max(maxNo, item.value)
        }
        
        // 用来存储结果
        var result: [Int] = []
        for i in stride(from: maxNo, through: 0, by: -1) {
            if result.count < k {
                if buckets[i].isEmpty {
                    continue
                }
                result.append(contentsOf: buckets[i])
            } else {
                break
            }
        }
        return result
    }
    
    // 思路4：快速排序,找轴点
    func topKFrequent4(_ nums: [Int], _ k: Int) -> [Int] {
        
        var map: [Int: Int] = [:]
        
        for num in nums {
            map[num] = (map[num] ?? 0) + 1
        }
        
        var items =  map.map { $0 }
        
        // 在这里使用快排选择

        var result: [Int] = []
        for i in 0..<k {
            
        }
        return result
        
    }
    
    // 构造出轴点元素，并且返回位置
    //  [begin, end)
    func pivotIndex(_ array: [Int], _ beginIndex: Int, _ endIndex:Int) -> Int {
        var array = array
        
//       优化：随机选择一个元素跟begin位置进行交换
        let random = beginIndex + Int(Double.random(in: 0...1) * Double(endIndex - beginIndex))
        let tmp = array[beginIndex]
        array[random] = tmp
        array[beginIndex] = tmp
        
        var begin = beginIndex
        var end = endIndex - 1
//      备份begin位置的元素
        let pivot = array[begin]
        
        while begin < end {
            while begin < end  {
                // 因为轴点元素是开始位置，需要和end元素比较
    //            从右往左
                if pivot > array[end] {
                    end -= 1
                } else { // 右边元素<=轴点元素
                    array[begin] = array[end]
                    begin += 1
                    break
                }
            }
            
            while begin < end {
    //            从左往右
                if pivot < array[begin] {
                    begin += 1
                } else {
                    array[end] = array[begin]
                    end -= 1
                    break
                }
            }
        }
//        到这边代表 begin == end
//        将轴点元素放入最终的位置
        array[begin] = pivot
        return begin
    }
    
}


