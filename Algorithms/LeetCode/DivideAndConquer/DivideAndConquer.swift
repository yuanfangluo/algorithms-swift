//
//  DivideAndConquer.swift
//  Algorithms
//
//  Created by sheng on 2022/9/13.
//

import Foundation
// 分治
/**
 （1）将原问题分解成若干个规模较小的子问题（子问题和原问题就是数据规模不一样）
 （2）子问题又不断分解成规模较小的子问题，直到不能再分解（直到可以轻易计算出子问题的解）
 （3）利用子问题的解推导出原问题的解
 因此，分治策略非常适用递归
 注意：子问题是相互独立的
 应用：
 - 归并排序
 - 快速排序
 - Karatsuba算法（大数乘法）
 主定理（Master Theorem）
 - 分治策略通常遵守一种通用模式
 */

// 最大子数组合(最大连续子序列和)

// 大数乘法
/**
    A B
    C D
 AC
    BD
   BC
   AD
 之前是O(n^2)
 BC + AD = AC + BD - (A-B)(C-D)
  A B
  C D
AC
  BD
 AC
 BD
 (A-B)(C-D)
 O(n^log2(3)) = O(n^1.585)
 */






