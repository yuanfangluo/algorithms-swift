//
//  B+.swift
//  Algorithms
//
//  Created by sheng on 2022/9/18.
//

import Foundation
/**
 B树上一种平衡的多路搜索树，多用于文件系统，数据库的实现
B树的特点：
 - 1个节点可以存储超过2个元素、可以拥有超过2个子节点
 - 也就是如果节点的元素个数是x，那么这个节点的子节点个数是 x+1
 - 拥有二叉搜索树的一些性质（左子节点小于父节点，中间子节点在中间大小，右子节点大于父子节点）
 - 平衡，每个节点的所有子树高度一致
 - 比较矮
 - 例如：3阶B树，就是指最多有3个子节点，4阶B树就是指最多有4个子节点
 
 B+树是B树的变体，常用于数据库和操作系统的文件系统中
 MySQL数据库的索引就是基于B+树实现的
 特点：
 - 分为内部节点（非叶子节点），叶子节点2种节点
    - 内部节点只存储key，不存储具体数据
    - 叶子节点存储key和具体数据
 - 所有的叶子节点形成一条有序链表
 - 如果父节点的元素数量为x，那么子节点的数量也为x,子节点的元素数量是 m/2 <= x <= m
 
 提问：为什么MySQL的索引底层使用B+树？
 为了减少IO操作数量，一般把一个节点的大小设计成最小读取单位的大小
 MySQL的存储引擎InnoDB的最小读写单位是16k
 
 对比B树，B+树的优势是
 - 每个节点存储的key数量更多，树的高度更低
 - 所有的具体数据都存放在叶子节点上，所以每次查询都要查询到叶子节点，查询速度比较稳定
 - 所有的叶子节点构成了一个有序链表，做区间查询时更方便
 
 B*树：
 是B+树的变体：给内部节点增加了指向兄弟节点的指针
 */