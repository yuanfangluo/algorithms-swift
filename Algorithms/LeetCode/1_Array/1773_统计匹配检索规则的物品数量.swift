//
//  1773_统计匹配检索规则的物品数量.swift
//  Algorithms
//
//  Created by sheng on 2022/10/29.
//

import Foundation
// https://leetcode.cn/problems/count-items-matching-a-rule/

class CountMatches {

    func countMatches(_ items: [[String]], _ ruleKey: String, _ ruleValue: String) -> Int {
        var res = 0
        switch ruleKey {
        case "type":
            for item in items {
                if item[0] == ruleValue {
                    res += 1
                }
            }
            
        case "color":
            for item in items {
                if item[1] == ruleValue {
                    res += 1
                }
            }
            
        case "name":
            for item in items {
                if item[2] == ruleValue {
                    res += 1
                }
            }
        default:
            break
        }
        return res
    }
    
    
}
