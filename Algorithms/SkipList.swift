//
//  SkipList.swift
//  Algorithms
//
//  Created by sheng on 2022/9/18.
//

import Foundation
// 跳表
/**
 提问：一个有序链表搜索，添加，删除的平均时间复杂度是多少？
 O(n)
 
 提问：能否利用二分搜索优化有序链表，将搜索、添加、删除的平均时间复杂度降至O(logn)？
 不能
 
 跳表（SkipList）：
 在有序链表的基础上增加了“跳跃”的功能。
 设计的初衷是为了取代平衡树（比如红黑树）
 
 Redis中的sorted，LevelDB中的MemTable都用到了跳表
 Redis，LevelDB都是著名的key-value数据库
 
 - 对比平衡树
 - 跳表的实现和维护会更加简单
 - 跳表的搜索、删除、添加的平均时间复杂度是O(logn)
 */

