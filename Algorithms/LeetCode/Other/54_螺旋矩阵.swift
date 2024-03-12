//
//  54_螺旋矩阵.swift
//  Algorithms
//
//  Created by sheng on 2022/10/13.
//

import Foundation
// https://leetcode.cn/problems/spiral-matrix/

class SpiralMatrix: Runnable {
    
    func run() {
        print(spiralOrder(
            [
                [1, 2, 3, 4],
                [5, 6, 7, 8],
                [9, 10, 11, 12],
                [13, 14, 15, 16]
            ]
        )
        )
        
        print(spiralOrder(
            [
                [1, 2, 3, 4],
                [5, 6, 7, 8],
                [9, 10, 11, 12],
            ]
        )
        )
        
        print(spiralOrder(
            [
                [1, 2, 3],
                [4, 5, 6],
                [7, 8, 9],
                [10, 11, 12],
            ]
        )
        )
    }
    
   private func spiralOrder(_ matrix: [[Int]]) -> [Int] {
        var res: [Int] = []
        var top = 0
        var bottom = matrix.count - 1
        var left = 0
        var right = matrix[0].count - 1
        
        while top <= bottom && left <= right {
            // left top -> right top
            for i in left...right {
                res.append(matrix[top][i])
            }
            top += 1
            
            // right top -> right bottom
            for i in stride(from: top, through: bottom, by: 1) {
                res.append(matrix[i][right])
            }
            right -= 1
            
            // 解决bug：行和列不一致的问题
            if top > bottom || left > right {
                break
            }
            
            // right bottom -> left bottom
            for i in stride(from: right, through: left, by: -1) {
                res.append(matrix[bottom][i])
            }
            bottom -= 1
            
            // left bottom -> left top
            for i in stride(from: bottom, through: top, by: -1) {
                res.append(matrix[i][left])
            }
            left += 1
        }
        
        return res
       }
}
