//
//  1451_重新排列句子中的单词.swift
//  Algorithms
//
//  Created by sheng on 2022/10/26.
//

import Foundation
// https://leetcode.cn/problems/rearrange-words-in-a-sentence/

class ArrangeWords: Runnable {
    
    func run() {
        print(arrangeWords("Leetcode is cool"))
    }
    
    private func arrangeWords(_ text: String) -> String {
        let words = text.lowercased().split(separator: " ")
        print(words)
        var map: [Int : [String]] = [:]
        for word in words {
            if var array = map[word.count] {
                array.append(String(word))
                map[word.count] = array
            } else {
                let arr: [String] = [String(word)]
                map[word.count] = arr
            }
        }
        
        print(map)
        
        let m = map.sorted { e1, e2 in
            e1.key < e2.key
        }
        
        print(m)
        
        let ws = m.map { (key: Int, value: [String]) in
            value
        }
        
        print(ws)
        
        var fm =  ws.flatMap {
            $0
        }
        
        fm[0] = fm[0].capitalized
        
        print(fm)
        
        let result = fm.joined(separator: " ")
        print(result)
        return result
    }
}
