//
//  36_有效的数独.swift
//  Algorithms
//
//  Created by sheng on 2022/10/25.
//

import Foundation
// https://leetcode.cn/problems/valid-sudoku/

class ValidSudoku: Runnable {
    
    func run() {
        print(isValidSudoku2([["5","3",".",".","7",".",".",".","."]
                             ,["6",".",".","1","9","5",".",".","."]
                             ,[".","9","8",".",".",".",".","6","."]
                             ,["8",".",".",".","6",".",".",".","3"]
                             ,["4",".",".","8",".","3",".",".","1"]
                             ,["7",".",".",".","2",".",".",".","6"]
                             ,[".","6",".",".",".",".","2","8","."]
                             ,[".",".",".","4","1","9",".",".","5"]
                             ,[".",".",".",".","8",".",".","7","9"]]))
    }
    
    // 思路1：使用string的contains
   private func isValidSudoku1(_ board: [[Character]]) -> Bool {
        
        var rows = Array(repeating: "", count: 9)
        var cols = Array(repeating: "", count: 9)
        var boxes = Array(repeating: "", count: 9)
        
        for row in 0..<9 {
            for col in 0..<9 {
                let char = board[row][col]
                if char == Character(".") {
                    continue
                }
                if rows[row].contains(String(char)) {
                    return false
                }
                
                if cols[col].contains(String(char)) {
                    return false
                }
                let boxIndex = (row / 3) * 3 + col / 3
                if boxes[boxIndex].contains(String(char)) {
                    return false
                }
                
                rows[row].append(char)
                cols[col].append(char)
                boxes[boxIndex].append(char)
            }
        }
        return true
    }
    // 思路2：使用bool数组
    private func isValidSudoku2(_ board: [[Character]]) -> Bool {
         
         var rows = Array(repeating: Array(repeating: false, count: 9), count: 9)
         var cols = Array(repeating: Array(repeating: false, count: 9), count: 9)
         var boxes = Array(repeating: Array(repeating: false, count: 9), count: 9)
         
         for row in 0..<9 {
             for col in 0..<9 {
                 let char = board[row][col]
                 if char == Character(".") {
                     continue
                 }
                 let index = Int(String(char))! - 1
                 if rows[row][index] {
                     return false
                 }
                 
                 if cols[col][index] {
                     return false
                 }
                 let boxIndex = (row / 3) * 3 + col / 3
                 if boxes[boxIndex][index] {
                     return false
                 }
                 
                 rows[row][index] = true
                 cols[col][index] = true
                 boxes[boxIndex][index] = true
             }
         }
         return true
     }
    
    // 思路3：使用位运算
    private func isValidSudoku3(_ board: [[Character]]) -> Bool {
         // 使用Int16来存放9位
         var rows = Array(repeating: Int16(), count: 9)
         var cols = Array(repeating: Int16(), count: 9)
         var boxes = Array(repeating: Int16(), count: 9)
         
         for row in 0..<9 {
             for col in 0..<9 {
                 let char = board[row][col]
                 if char == Character(".") {
                     continue
                 }
                 
                 let bit = Int16(1 << (Int(String(char))! - 1))
                 // 按位与 &
                 if ((rows[row] & bit) != 0)  {
                     return false
                 }
                 
                 if (cols[col] & bit) != 0 {
                     return false
                 }
                 let boxIndex = (row / 3) * 3 + col / 3
                 if (boxes[boxIndex] & bit) != 0 {
                     return false
                 }
//                 rows[row] += bit
//                 cols[col] += bit
//                 boxes[boxIndex] += bit
                 // 可以使用按位或 |，只要有一个是1就是1
                 rows[row] |= bit
                 cols[col] |= bit
                 boxes[boxIndex] |= bit
             }
         }
         return true
     }
}
