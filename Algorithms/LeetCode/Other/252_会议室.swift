//
//  252_会议室.swift
//  Algorithms
//
//  Created by sheng on 2022/10/14.
//

import Foundation
// https://leetcode.cn/problems/meeting-rooms/
// 给定一组会议安排时间，问是否都能参与这些会议
class MeetingRooms: Runnable {
    
    func run() {
        print(canAttendMeetings([[1, 2], [3, 10], [11, 13]]), canAttendMeetings([[1, 7], [3, 10]]))
    }
    
    private func canAttendMeetings(_ intervals: [[Int]]) -> Bool {
        // 开始时间从小到大排序
        let intervals = intervals.sorted { i1, i2 in
            i1[0] < i2[0]
        }
        
        for i in 1..<intervals.count {
            if intervals[i][0] < intervals[i - 1][1] {
                return false
            }
        }
        
        
        return true
    }
}
