//
//  Time.swift
//  Algorithms
//
//  Created by sheng on 2022/8/18
//

import Foundation
import QuartzCore

class Time {
    static var time: TimeInterval = 0
    static func test(_ label: String, completion: ()->Void) {
        let begin = CACurrentMediaTime()
        completion()
        time = CACurrentMediaTime() - begin
        let timeStr = "耗时：\(String(format: "%.3f", time))秒(\(String(format: "%.0f", time * 1000))毫秒)"
        print(label, timeStr)
    }
}
