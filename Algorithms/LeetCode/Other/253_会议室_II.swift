//
//  253_会议室_II.swift
//  Algorithms
//
//  Created by sheng on 2022/10/14.
//

import Foundation
// https://leetcode.cn/problems/meeting-rooms-ii/
// 给定一组会议安排时间，问至少需要多少会议室能安排这些会议
class MeetingRoomsII: Runnable {
    func run() {
        print(minMeetingRooms2([[1, 2], [3, 10], [11, 13]]), minMeetingRooms2([[1, 7], [3, 10]]))
    }
    
    private func minMeetingRooms(_ intervals: [[Int]]) -> Int {
        // 开始时间从小到大排序
        let _ = intervals.sorted { i1, i2 in
            i1[0] < i2[0]
        }
        
        // 最小堆
        let heap = PriorityQueue()
        
        //  先添加0号会议的结束时间
        
        
        // 如果我的开始时间大于堆顶的时间（目前的占用会议室最早的结束时间），说明可以利用该会议室
        // 将堆顶元素删了，将我的结束时间加入堆
        
        // 如果我的开始时间小于堆顶的时间，说明之前会议还没结束，我这边又需要开会，我们需要新开会议室
        // 将我的结束时间加入堆

        
        return heap.size
    }
    
    class PriorityQueue {
        var size: Int {
            0
        }
    }
    
    private func minMeetingRooms2(_ intervals: [[Int]]) -> Int {
        var begins: [Int] = []
        var ends: [Int] = []
        for interval in intervals {
            begins.append(interval[0])
            ends.append(interval[1])
        }
        
        begins.sort()
        ends.sort()
        
        var rooms = 0
        var endIdx = 0

        for begin in begins {
            if begin >= ends[endIdx] {
                endIdx += 1
            } else {
                rooms += 1
            }
        }
        
        return rooms
    }
}
