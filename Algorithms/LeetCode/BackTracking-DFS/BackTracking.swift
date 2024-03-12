//
//  BackTracking.swift
//  Algorithms
//
//  Created by sheng on 2022/9/8.
//

import Foundation
// 八皇后问题
// 在8x8的国际象棋上摆放八个皇后，使其不能互相攻击：任意两个皇后不能处于同一行，同一列，同一斜线上
// 可以先看看四皇后的问题

/**
 思路一：暴力法
 从64个格子选出任意8个盒子，然后判断这种摆法是否符合要求
 思路二：根据题意减少暴力程度
 因为每一行只能放一个皇后，所以有8^8种摆法，检查每一种摆法的可能性
 思路三：回溯法（很适合用递归）+ 剪枝（Pruning）
 */
class Queues: Runnable {
    func run() {
        placeQueues(4)
    }
    
    /// 数组索引是行号，数组元素是列号：col[4] =  5；表示第4行的皇后放在第5列
    var cols: [Int] = []
    /// 一共有多少种摆法
    var ways: Int = 0
    
    func placeQueues(_ n: Int) {
        if n < 1 {
            return
        }
        cols = Array(repeating: -1, count: n)
        place(0)
        print("\(n)皇后一共有\(ways)种摆法")
    }
    
    /// 从第row行开始摆法皇后
    /// - Parameter row: 行
    func place(_ row: Int) {
       if row == cols.count {
           ways += 1
           show()
           return
       }
       
       for col in 0..<cols.count {
           // 这里是剪枝
           if isValid(row, col) {
               // 摆放皇后
               cols[row] = col
               // 直接摆放下一行
               place(row + 1)
               // 到这里就是回溯了
           }
       }
    }
    
    /// 判断第row行，第col列是否能摆放皇后
    /// - Parameters:
    ///   - row: 行
    ///   - col: 列
    /// - Returns: 是否能摆放皇后
    func isValid(_ row: Int, _ col: Int) -> Bool {
        for i in 0..<row {
            // 1. 先判断行：因为这个行是新的，所以不需要判断了
            // 2. 再判断类：如果第col列已经有皇后了
            if cols[i] == col {
                print("[\(row)][\(col)]=false")
                return false
            }
            // 3. 判断斜线
            if (row - i) == abs(col - cols[i]) {
                print("[\(row)][\(col)]=false")
                return false
            }
        }
        // 能来到这里，代表是可以放的
        print("[\(row)][\(col)]=true")
        return true
    }
    func show(){
        for row in 0..<cols.count {
            for col in 0..<cols.count {
                if cols[row] == col {
                    print(1, terminator: "")
                } else {
                    print(0, terminator: "")
                }
            }
            print("")
        }
        print("------------------")
    }
}

// 优化
class Queues2: Runnable {
    func run() {
        placeQueues(4)
    }
    /// 数组索引是行号，数组元素是列号：queues[4] =  5；表示第4行的皇后放在第5列
    var queues: [Int] = []
    
    /// 标记着某一列是否有皇后了
    var cols: [Bool] = []
    
    /// 标记着某一对角线是否有皇后了（左上角到右下角, left top -> right bottom）
    var leftTop: [Bool] = []
    
    /// 标记着某一对角线是否有皇后了（右上角到左下角, right top -> left bottom）
    var rightTop: [Bool] = []
    
    /// 一共有多少种摆法
    var ways: Int = 0
    
    func placeQueues(_ n: Int) {
        if n < 1 {
            return
        }
        queues = Array(repeating: -1, count: n)
        cols = Array(repeating: false, count: n)
        leftTop = Array(repeating: false, count: (n << 1) - 1)
        rightTop = Array(repeating: false, count: leftTop.count)
        place(0)
        print("\(n)皇后一共有\(ways)种摆法")
    }
    
    /// 从第row行开始摆法皇后
    /// - Parameter row: 行
    func place(_ row: Int) {
       if row == cols.count {
           ways += 1
           show()
           return
       }
       
       for col in 0..<cols.count {
           // 这里是剪枝
           // 当前位置
           if cols[col] {
               continue
           }
           // 斜线
           // 从左上角->右下角的对角线索引： row - col + (n-1)
           let ltIndex = row - col + cols.count - 1
           if leftTop[ltIndex] {
               continue
           }
           // 从右上角->左下角的对角线索引: row + col
           let rtIndex = row + col
           if rightTop[rtIndex] {
               continue
           }
           
           // 来到这边代表没有皇后，可以摆皇后
           queues[row] = col
           // 摆放皇后
           cols[col] = true
           leftTop[ltIndex] = true
           rightTop[rtIndex] = true
           // 直接摆放下一行
           place(row + 1)
           // 来到这里代表是回溯
           // 需要重置
           cols[col] = false
           leftTop[ltIndex] = false
           rightTop[rtIndex] = false
       }
    }
    
    func show(){
        for row in 0..<cols.count {
            for col in 0..<cols.count {
                if queues[row] == col {
                    print(1, terminator: "")
                } else {
                    print(0, terminator: "")
                }
            }
            print("")
        }
        print("------------------")
    }
}

// 位运算优化空间，针对八皇后
class Queues3: Runnable {
    func run() {
        place8Queues()
    }
    /// 数组索引是行号，数组元素是列号：queues[4] =  5；表示第4行的皇后放在第5列
    var queues: [Int] = []
    
    /// 标记着某一列是否有皇后
    var cols: UInt8 = 0// 8位
    
    /// 标记着某一对角线是否有皇后了（左上角到右下角, left top -> right bottom）
    var leftTop: UInt16 = 0// 16位
    
    /// 标记着某一对角线是否有皇后了（右上角到左下角, right top -> left bottom）
    var rightTop: UInt16 = 0 // 16位
    
    /// 一共有多少种摆法
    var ways: Int = 0
    
     func place8Queues() {
        queues = Array(repeating: -1, count: 8)
        place(0)
        print("8皇后一共有\(ways)种摆法")
    }
    
    /// 从第row行开始摆法皇后
    /// - Parameter row: 行
    func place(_ row: Int) {
       if row == 8 {
           ways += 1
           show()
           return
       }
       
       for col in 0..<8 {
           // 这里是剪枝
           // 当前位置
           
           if ((cols & (1 << col)) != 0) {
               continue
           }
           // 斜线
           // 从左上角->右下角的对角线索引： row - col + (n-1)
           let ltIndex = row - col + 8 - 1
           if ((leftTop & (1 << ltIndex)) != 0) {
               continue
           }
           // 从右上角->左下角的对角线索引: row + col
           let rtIndex = row + col
           if ((rightTop & (1 << rtIndex)) != 0) {
               continue
           }
           
           // 来到这边代表没有皇后，可以摆皇后
           queues[row] = col
           // 摆放皇后
           cols = cols | (1 << col)
           leftTop = leftTop | (1 << ltIndex)
           rightTop = rightTop | (1 << rtIndex)
           // 直接摆放下一行
           place(row + 1)
           // 来到这里代表是回溯
           // 需要重置
           
           cols = cols & (~(1 << col))
           leftTop = leftTop & (~(1 << ltIndex))
           rightTop = rightTop & (~(1 << rtIndex))
       }
    }
    
    func show(){
        for row in 0..<8 {
            for col in 0..<8 {
                if queues[row] == col {
                    print(1, terminator: "")
                } else {
                    print(0, terminator: "")
                }
            }
            print("")
        }
        print("------------------")
    }
}
