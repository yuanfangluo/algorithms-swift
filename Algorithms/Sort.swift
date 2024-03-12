//
//  Sort.swift
//  Algorithms
//
//  Created by sheng on 2022/5/19.
//

import Foundation
import QuartzCore

protocol Sortable {
    func sort()
}

class Sort: Sortable, CustomDebugStringConvertible, Comparable {
    static func < (lhs: Sort, rhs: Sort) -> Bool {
        lhs.time < rhs.time
    }
    
    static func == (lhs: Sort, rhs: Sort) -> Bool {
        lhs.time == rhs.time
    }
    
    func sort() {
        
    }
    
    var isStable: Bool {
        if type(of: self) == BubbleSort.self ||
            type(of: self) == BubbleSort1.self ||
            type(of: self) == BubbleSort2.self ||
            type(of: self) == InsertionSort.self ||
            type(of: self) == InsertionSort1.self ||
            type(of: self) == InsertionSort2.self ||
            type(of: self) == MergeSort.self
//            type(of: self) == CountingSort2.self ||
//            type(of: self) == RadixSort.self
        {
            return true
        }
//
        if  type(of: self) == SelectionSort.self ||
            type(of: self) == HeapSort.self
//            type(of: self) == ShellSort.self ||
//            type(of: self) == CountingSort1.self ||
//            type(of: self) == BucketSort.self

        {
            return false
        }
        
        return false
    }
    
    var debugDescription: String {
        let timeStr = "耗时：\(String(format: "%.3f", time))秒(\(String(format: "%.0f", time * 1000))毫秒)"
        let cmpCountStr = "比较：\(numberStr(cmpCount))"
        let swapCountStr = "交换：\(numberStr(swapCount))"
        let stableStr = "稳定性：\(isStable)"
       return "[\(type(of: self))]\n\(stableStr)\t\(timeStr)\t\(cmpCountStr)\t\(swapCountStr)"
    }
    
    var array: [Int] = []
    private var cmpCount = 0
    private var swapCount = 0
    private var time: TimeInterval = 0.0
    
    func cmp(_ i1: Int, _ i2: Int) -> Int {
        cmpCount += 1
        return array[i1] - array[i2]
    }
    
    func cmp(e1: Int,e2: Int) -> Int {
        cmpCount += 1
        return e1 - e2
    }
    
    func swap(_ i1: Int, _ i2: Int) {
        swapCount += 1
        let tmp = array[i1]
        array[i1] = array[i2]
        array[i2] = tmp
    }
    
    private func numberStr(_ number: Int) -> String {
        if number < 10000 {
            return "\(number)"
        }
        
        if number < 100000000 {
            return String(format: "%.2f", Double(number)/10000.0) + "万"
        }
        
        return String(format: "%.0f", Double(number)/100000000.0) + "亿"
    }
    
    func sort(_ array: [Int]) {
        self.array = array
        let begin = CACurrentMediaTime()
        sort()
        time = CACurrentMediaTime() - begin
    }
}


class BubbleSort: Sort {
   override func sort() {
        for end in stride(from: array.count - 1, to: 0, by: -1) { // [array.count - 1, 0)
            for begin in 1...end {
                if cmp(begin - 1, begin) > 0 {
                    swap(begin - 1, begin)
                }
            }
        }
    }
}

// 优化1：如果序列已经完全有序，可以提前终止冒泡排序
class BubbleSort1: Sort {
    override func sort() {
        for end in stride(from: array.count - 1, to: 0, by: -1) { // [array.count - 1, 0)
            var sorted = true
            for begin in 1...end {
                if cmp(begin - 1, begin) > 0 {
                    swap(begin - 1, begin)
                    sorted = false
                }
            }
            if sorted {
                break
            }
        }
    }
}

// 优化2：尾部已经局部有序，可以记录最后一次交换的位置，减少比较次数
class BubbleSort2: Sort {
    override func sort() {
        for var end in stride(from: array.count - 1, to: 0, by: -1) { // [array.count - 1, 0), [array.count - 1, 1]
            // sortedIndex的初始值在数组完全有序的时候有用
            var sortedIndex = 1
            for begin in 1...end {
                if cmp(begin - 1, begin) > 0 {
                    swap(begin - 1, begin)
                    sortedIndex = begin
                }
            }
            end = sortedIndex
        }
    }
}

/// 最坏：O(n^2)
/// 平均：O(n^2)
/// 最好：O(n)，完全有序的情况下
/// 空间复杂度：O(1)

/// 排序算法的稳定性
/// 原地排序
/// 选择排序（找出最大值和最后一个元素交换）
class SelectionSort: Sort {
    override func sort() {
        for end in stride(from: array.count - 1, to: 0, by: -1) { // stride(from: , to: , by: ) 包含from，但是不包括to
            var maxIndex = 0
            for begin in 1...end {
                if cmp(maxIndex, begin) < 0 {
                    maxIndex = begin
                }
            }
            // 将最大值和扫描数组的最后一个位置元素交换
            swap(maxIndex, end)
        }
    }
}

// 选择排序2：找出最小的一个元素和首元素交换
class SelectionSort1: Sort {
    override func sort() {
        
    }
}


// 堆排序:使用堆的数据结构对选择排序的找出最大值的过程做优化
/*
 执行流程：
 1. 对序列进行原地建堆（heapify）：n
 2. 重复执行以下操作，直到堆的元素数量为1：nlong
 - 交换堆顶元素和尾元素
 - 堆的元素数量减1
 - 对0位置进行一次siftDown操作（需要将最大值放在0位置）：logn
 时间复杂度：nlong + n，也就是nlogn
 */

class HeapSort: Sort {
    private var heapSize: Int = 0
    
    override func sort() {
        heapSize = array.count
        // 首先原地建堆：O(n)
        for i in stride(from: (heapSize >> 1) - 1, to: -1, by: -1) {
            siftdown(i)
        }
        
        while heapSize > 1 {
            // 1. 将首元素和末尾元素交换
            swap(0, heapSize - 1)
            // 2. 堆的大小减一
            heapSize -= 1
            // 3.对0位置进行siftdown（恢复堆的性质）
            siftdown(0)
        }
    }
    
    private func siftdown(_ index: Int) {
        var i = index
        let element = array[i];
        let half = heapSize >> 1
        while i < half { // i必须是非叶子节点
            // 默认是左边跟父节点比
            var childIndex = (i << 1) + 1
            var child = array[childIndex]
            
            let rightIndex = childIndex + 1
            // 右子节点比左子节点大
            if rightIndex < heapSize && cmp(e1:array[rightIndex],e2: child) > 0 {
                childIndex = rightIndex
                child = array[childIndex]
            }
            // 大于等于子节点
            if cmp(e1:element, e2:child) >= 0 {
                break
            }
            array[i] = child
            i = childIndex
        }
        array[i] = element
    }
}

// 插入排序: 类似于扑克牌
class InsertionSort: Sort {
    override func sort() {
        for begin in 1..<array.count {
            var cur = begin
            while cur > 0 && cmp(cur, cur - 1) < 0 {
                swap(cur, cur - 1)
                cur -= 1
            }
        }
    }
}

// 插入排序的优化1：将交换变为挪动
class InsertionSort1: Sort {
    override func sort() {
        for begin in 1..<array.count {
            var cur = begin
            let value = array[cur]
            while cur > 0 && cmp(e1: value, e2: array[cur - 1]) < 0 {
                array[cur] = array[cur - 1]
                cur -= 1
            }
            // 最终交换
            array[cur] = value
        }
    }
}

// 二分搜索
class BinarySearch {
    // [begin, end)
    // 找出元素v在数组的位置
  static func indexOf(_ array: [Int], _ v: Int) -> Int {
        var begin = 0
        var end = array.count
        while begin < end {
            let mid = (begin + end) >> 1
            if v < array[mid] {
                end = mid
            } else if v > array[mid] {
                begin = mid + 1
            } else {
                return mid
            }
        }
        // 到这里就是
//        beign == end
        return -1
    }
    
    /// 找出第一个大于元素v的位置
    /// [begin, end)
   static func search(_ array: [Int], _ v: Int) -> Int {
        var begin = 0
        var end = array.count
        while begin < end {
            let mid = (begin + end) >> 1
            if v < array[mid] {
                end = mid
            } else {
                begin = mid + 1
            }
        }
        return begin
    }
}

// 插入排序的优化2：使用二分搜索优化了比较次数
class InsertionSort2: Sort {
    override func sort() {
        for begin in 1..<array.count { // 从index为1开始
            insert(begin, search(begin))
        }
    }
    
    // 将source位置的元素放入dest位置
    private func insert(_ source: Int, _ dest: Int) { // source比dest大
        let v = array[source]
        for i in stride(from: source, to: dest, by: -1) {
            array[i] = array[i - 1]
        }
        array[dest] = v
    }
    
    // 利用二分搜索找到index位置元素的待插入位置
    // 也就是找出第一个大于index位置元素的元素位置
    // 已经排好序的数组的区间范围是[0, index)
    func search(_ index: Int) -> Int {
        var begin = 0
        var end = index
        while begin < end {
            let mid = (begin + end) >> 1
            if cmp(e1: array[index], e2: array[mid]) < 0 {
                end = mid
            } else {
                begin = mid + 1
            }
        }
        return begin
    }
}

// 归并排序
// nlogn
class MergeSort: Sort {
    var leftArray: [Int] = []
    
    override func sort() {
        // 对整个数组进行排序
        sort(0, array.count)
    }
    
    // 对[begin, end)范围的数据进行归并排序
    func sort(_ begin: Int, _ end: Int) {
        if end - begin < 2 {
            return
        }
        
        let mid = (begin + end) >> 1
        sort(begin, mid)
        sort(mid, end)
        merge(begin, mid, end)
    }
    
    // 将[begin, mid) ]  和 [mid, end)范围的序列合并成一个有序序列
    func merge(_ begin: Int, _ mid: Int, _ end: Int) {
        var li = 0, le = mid - begin
        var ri = mid, re = end
        var ai = begin
        
        // 备份左边数组
        leftArray.removeAll()
        for i in li..<le {
            leftArray.append(array[begin + i])
        }
        
        while li < le {
            if ri < re && cmp(e1: array[ri], e2: leftArray[li]) < 0 {
                array[ai] = array[ri]
                ai += 1
                ri += 1
            } else {
                array[ai] = leftArray[li]
                ai += 1
                li += 1
            }
        }
    }
}

// 快排
class QuickSort: Sort {
    override func sort() {
        sort(0, array.count)
    }
    
    /// 对   [begin, end)    范围内的元素进行快速排序
    func sort(_ begin: Int, _ end: Int) {
        if end - begin < 2 {
            return
        }
//        确定轴点位置
        let mid = pivotIndex(begin, end)
//      对子序列进行快速排序
        sort(begin, mid)
        sort(mid + 1, end)
    }
    
    /// 构造出轴点元素，并且返回位置
    ///  [begin, end)
    func pivotIndex(_ beginIndex: Int, _ endIndex:Int) -> Int {
//       优化：随机选择一个元素跟begin位置进行交换
        swap(beginIndex, beginIndex + Int(Double.random(in: 0...1) * Double(endIndex - beginIndex)))
        
        var begin = beginIndex
        var end = endIndex - 1
//      备份begin位置的元素
        let pivot = array[begin]
        
        while begin < end {
            while begin < end  {
                // 因为轴点元素是开始位置，需要和end元素比较
    //            从右往左
                if cmp(e1: pivot, e2: array[end]) < 0 {
                    end -= 1
                } else { // 右边元素<=轴点元素
                    array[begin] = array[end]
                    begin += 1
                    break
                }
            }
            
            while begin < end {
    //            从左往右
                if cmp(e1: pivot, e2: array[begin]) > 0 {
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

class ShellSort: Sort {
    override func sort() {
        
    }
    
}

/// 计数排序
/// 适合对一定范围内的整数进行排序
///
class CountingSort1: Sort {
    override func sort() {
//        找出最大值
        var max = array[0]
        for i in 1..<array.count {
            if cmp(e1: array[i], e2: max) > 0 {
                max = array[i]
            }
        }
        
        var counts: [Int] = Array(repeating: 0, count: max + 1)
//        统计每个整数出现的次数
        for i in 0..<array.count {
            let index = array[i]
            counts[index] += 1
        }
        
//        根据整数出现的次数，对整数排序
        var index = 0
        for i in 0..<counts.count {
            while counts[i] > 0 {
                array[index] = i
                index += 1
                counts[i] -= 1
            }
        }
    }
}
/// 计数排序：
///
///
class CountingSort2: Sort {
    override func sort() {
        // 找出最值
        var max = array[0]
        var min = array[0]
        for i in 1..<array.count {
            if cmp(e1: array[i], e2: max) > 0 {
                max = array[i]
            }
            
            if cmp(e1: array[i], e2: min) < 0 {
                min = array[i]
            }
        }
        
        var counts: [Int] = Array(repeating: 0, count: max - min + 1)
        // 统计每个整数出现的次数
        for i in 0..<array.count {
            let index = array[i] - min
            counts[index] += 1
        }
        
        // 累加次数
        for index in 1..<counts.count {
            counts[index] += counts[index - 1]
        }
        
//        从后往前遍历元素，将它放到有序数组中的合适位置
        var newArray: [Int] = Array(repeating: 0, count: array.count)

        for i in stride(from: array.count - 1, through: 0, by: -1) {
            counts[array[i] - min] -= 1
            newArray[counts[array[i] - min]] = array[i]
        }
        
        for i in 0..<newArray.count {
            array[i] = newArray[i]
        }
    }
}

// 针对非负整数，基数排序
class RadixSort: Sort {
    override func sort() {
        sort2()
    }
    
    func sort1() {
        //        找出最大值
        var max = array[0]
        for i in 1..<array.count {
            if cmp(e1: array[i], e2: max) > 0 {
                max = array[i]
            }
        }
//        对每一位基数来计数排序
        var divider = 1
        while divider <= max {
            countSort(divider)
            divider *= 10
        }
    }
    
    private func countSort(_ divider: Int) {
        // 0-9排序
        var counts: [Int] = Array(repeating: 0, count: 10)
        // 统计每个整数出现的次数
        for i in 0..<array.count {
            let index = array[i] / divider % 10
            counts[index] += 1
        }
        
        // 累加次数
        for index in 1..<counts.count {
            counts[index] += counts[index - 1]
        }
        
//        从后往前遍历元素，将它放到有序数组中的合适位置
        var newArray: [Int] = Array(repeating: 0, count: array.count)

        for i in stride(from: array.count - 1, through: 0, by: -1) {
            let index = array[i] / divider % 10
            counts[index] -= 1
            newArray[counts[index]] = array[i]
        }
        
        for i in 0..<newArray.count {
            array[i] = newArray[i]
        }
    }
    
    func sort2() {
        // 找出最大值
        var max = array[0]
        for i in 1..<array.count {
            if cmp(e1: array[i], e2: max) > 0 {
                max = array[i]
            }
        }
//        桶数组
        var buckets: [[Int]] = Array(repeating: Array(repeating: 0, count: array.count), count: 10)
//        每个桶的元素数量
        var bucketSizes = Array(repeating: 0, count: buckets.count)
        var divider = 1
        while divider <= max {
            for i in 0..<array.count {
                let no = array[i] / divider % 10
                buckets[no][bucketSizes[no]] = array[i]
                bucketSizes[no] += 1
            }
            var index = 0
            for i in 0..<buckets.count {
                for j in 0..<bucketSizes[i] {
                    array[index] = buckets[i][j]
                    index += 1
                }
                bucketSizes[i] = 0
            }
            divider *= 10
        }
    }
}

/// 桶排序
///
/// 
class BucketSort: Sort {
    override func sort() {
        
    }
}


func testSorts(_ array:[Int], _ sorts: [Sort]) {
    for sort in sorts {
        sort.sort(array)
        assert(Int.isAscOrder(sort.array))
    }
    
    for sort in sorts.sorted(by: <) {
        print(sort)
    }
}
