//
//  最小公倍数.swift
//  Algorithms
//
//  Created by sheng on 2022/10/29.
//

import Foundation

class LCM {
    func lcm(_ a: Int, _ b: Int) -> Int {
        // 最小公倍数就是乘积除以最大公因数
        return a * b / GCD().gcd(a, b);
    }
}
