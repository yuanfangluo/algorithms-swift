//
//  Extensions.swift
//  Algorithms
//
//  Created by sheng on 2022/8/5.
//

import Foundation

extension Int {
    public static func random() -> Int {
        Int(arc4random())  // 这里只能生成正整数。
    }
    
    public static func random(count: Int, in range: CountableClosedRange<Int>) -> [Int] {
        var array: [Int] = []
        let delta = range.upperBound - range.lowerBound + 1
        for _ in 0..<count {
            array.append(range.lowerBound + (Int.random() % delta))
        }
        return array
    }
    
    public static func isAscOrder(_ array: [Int]) -> Bool {
        for i in 1..<array.count {
            if array[i-1] > array[i] {
                return false
            }
        }
        return true
    }
}

extension Character {
    var intValue: Int {
        return Int(unicodeScalars.first!.value)
    }
}

extension String {
    func substring(_ begin: Int, _ len: Int) -> String {
        let start = index(startIndex, offsetBy: begin)
        let end = index(start, offsetBy: len)
        let range = start..<end
        let str = self[range]
        return String(str)
    }
    func charAt(_ index: Int) -> Character {
        return Character(substring(index, 1))
    }
}

extension String {
    func substringSafe(_ begin: Int, _ len: Int) -> String? {
        if begin >= self.count || begin < 0 {
            return nil
        }
        var realLen = len
        if (begin + len) > count {
            realLen = count - begin
        }
        let start = index(startIndex, offsetBy: begin)
        let end = index(start, offsetBy: realLen)
        let range = start..<end
        let str = self[range]
        return String(str)
    }
    
    func charAtSafe(_ index: Int) -> Character? {
        if index < count && index >= 0 {
            if let str = substringSafe(index, 1) {
                return Character(str)
            }
        }
        return nil
    }
}

