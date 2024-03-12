//
//  计算最大公因数（辗转相除:欧几里得算法）.swift
//  Algorithms
//
//  Created by sheng on 2022/10/29.
//

import Foundation


class GCD {
    // 计算最大公因数（辗转相除/欧几里得算法）
    func gcd(_ a: Int, _ b: Int) -> Int {
        if a < b {
            // 需要保证 a > b
            return gcd(b, a)
        }
        
        if b == 0 {
            return a
        }
        
        return gcd(b, a % b)
    }
}
