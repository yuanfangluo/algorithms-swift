//
//  Recursion.swift
//  Algorithms
//
//  Created by sheng on 2022/8/17.
//

import Foundation

func recursion() {
//    print(sum(4), sum1(4), sum2(4))
//    print(fib(4), fib1(4))
    
    let n = 44
    Time.test("fib") {
        print(fib(n))
    }
    
    Time.test("fib1") {
        print(fib1(n))
    }
    
    Time.test("fib2") {
        print(fib2(n))
    }
    
    Time.test("fib3") {
        print(fib3(n))
    }
    
    Time.test("fib4") {
        print(fib4(n))
    }
}

// 求 1+2+3+...+(n-1)+n的和，(n>0)
func sum(_ n: Int) -> Int {
    if n <= 1 { return n }
    return n + sum(n - 1)
}

// 总消耗时间T(n) = T(n-1) + O(1)
// 时间复杂度是：O(n)
// 空间复杂度：O(n)

// 可以改成非递归调用，或者叫做递推方法
func sum1(_ n: Int) -> Int {
    var result = 0
    for i in 1...n {
        result += i
    }
    return result
}
// 时间复杂度是：O(n)
// 空间复杂度:O(1)

func sum2(_ n: Int) -> Int {
    if n <= 1 {
        return n
    }
    return (1+n) * n >> 1
}
// 时间复杂度:O(1)
// 空间复杂度：O(1)

// 注意：我们使用递归，不是为了求得最优解，而是为了简化解决问题的思路，代码会更加简洁
// 但是我们很多时候使用递归求出来的并不是最优解。当然也有可能是最优的

// 递归的基本思想：
// 拆解问题
/*
 把规模大的问题变成规模较小的同类型问题
 把规模较小的问题又不断变成规模更小的问题
 规模小到一定程度可以直接得出它的解
 */
// 求解
/*
 由最小规模问题的解得出较大规模问题的解
 由较大规模问题的解不断得出规模更大问题的解
 最后得出原来问题的解
 */
// 凡是可以利用上述思想解决问题的，都可以尝试使用递归
// 很多链表，二叉树相关的问题都可以使用递归来解决
// 因为链表\二叉树本身就是递归的结构(链表中包含链表,二叉树中包含二叉树)

// 递归的使用套路
/*
 1. 明确函数的功能
 2. 明确原问题和子问题的关系:寻找f(n)与f(n-1)的关系
 3. 明确递归基(边界条件):规模小到什么程度就能求出解
 */

// 斐波那契数列: 1, 1, 2, 3, 5, 8, 13, 21, 34, ...
@discardableResult
func fib(_ n: Int) -> Int {
    if n <= 2 {
        return 1
    }
    return fib(n-1) + fib(n-2)
}
// T(n) = T(n-1) + T(n-2) + O(1),根据递推公式,可得时间复杂度:O(2^n)
// 空间复杂度:O(n)
// 递归调用的空间复杂度 = 递归深度 * 每次调用所需的辅助空间

// fib函数的调用过程有特别多的重复计算
// 这是一种"自顶向下"的调用工程
@discardableResult
func fib1(_ n: Int) -> Int {
    if n <= 2 {
        return 1
    }
    var array = Array(repeating: 0, count: n + 1)
    array[1] = 1
    array[2] = 1
    return fib1(n, &array)
}

func fib1(_ n: Int, _ array: inout [Int]) -> Int {
    if array[n] == 0 {
        array[n] = fib1(n-1, &array) + fib1(n-2, &array)
    }
    return array[n]
}
// 时间复杂度：O(n)
// 空间复杂度：O(n)

// 去除递归调用
@discardableResult
func fib2(_ n: Int) -> Int {
    if n <= 2 {
        return 1
    }
    var array = Array(repeating: 0, count: n + 1)
    array[1] = 1
    array[2] = 1
    for i in 3...n {
        array[i] = array[i-1] + array[i-2]
    }
    return array[n]
}
// 时间复杂度：O(n)
// 空间复杂度：O(n)
// 这是一种”自底向上“的计算过程

// 优化3
// 由于每次运算只需要用到数组中的2个元素，所以可以使用滚动数组来优化
@discardableResult
func fib3(_ n: Int) -> Int {
    if n <= 2 {
        return 1
    }
    var array = Array(repeating: 0, count: 2)
    array[1] = 1
    array[0] = 1
    for i in 3...n {
        array[i % 2] = array[(i-1) % 2] + array[(i-2) % 2]
    }
    return array[n % 2]
}

// 尽量不要使用模运算,模2可以改为 &1
func fib4(_ n: Int) -> Int {
    if n <= 2 {
        return 1
    }
    var array = Array(repeating: 0, count: 2)
    array[1] = 1
    array[0] = 1
    for i in 3...n {
        array[i & 1] = array[(i-1) & 1] + array[(i-2) & 1]
    }
    return array[n & 1]
}

// 因为就用到两个变量，不需要使用数组
func fib5(_ n: Int) -> Int {
    if n <= 2 {
        return 1
    }
    var first = 1
    var second = 1
    for _ in 3...n {
        second = first + second
        first = second - first
    }
    return second
}

// 斐波那契数列也有个线性代数解法：特征方程

// 上楼梯（跳台阶）
// 楼梯有n阶台阶，上楼可以一步上1阶，也可以一步上2阶，走完n阶台阶共有多少种不同走法。
// 假设n阶台阶有f(n)种走法，第一步有2种走法：
// 当第一步走1阶的时候，还剩n-1阶，共 f(n-1)
// 当第一步走2阶的时候，还剩n-2阶，共 f(n-2)
// f(n) = f(n-1) + f(n-2)
func climbStairs(_ n: Int) -> Int {
    if n <= 2 {
        return n
    }
    return climbStairs(n - 1) + climbStairs(n - 2)
}

// 借鉴斐波那契数列使用迭代
func climbStairs1(_ n: Int) -> Int {
    if n <= 2 {
        return n
    }
    var first = 1
    var second = 2
    for _ in 3...n {
        second = first + second
        first = second - first
    }
    return second
}

// 汉诺塔（Hanoi）移动盘子
/**
 当n == 1时，直接将盘子从A移动到C
 当n > 1时，可以拆分成3大步骤：
 （1）将n-1个盘子从 p1 移动到 p2
 （2）将第n个盘子从 p1 移动到 p3
 （3）将n-1个盘子从 p2 移动到 p3
 步骤1和3明显是个递归调用
 */

class Hanoi {
    // 这个函数的定义是：将n个盘子从p1移动到p3，其中p2是中间柱子
    func hanoi(_ n: Int, _ p1: String, _ p2: String, _ p3: String) {
        
        if n == 1 {
            move(n, p1, p3)
            return
        }
        
        // 将 n-1 个盘子从p1移动到p2，其中p3是中间柱子
        hanoi(n - 1, p1, p3, p2)
        
        move(n, p1, p3)
        
        hanoi(n - 1, p2, p1, p3)
    }

    func move(_ no: Int, _ from: String, _ to: String) {
        print("将\(no)号盘子从\(from)移动到\(to)")
    }
}
/**
 时间复杂度：T(n) = 2T(n-1) +O(1)
 T(n) = O(2^n)
 空间复杂度：O(n)
 */

// 递归转非递归
func log(_ n: Int){
    if n < 1 {
        return
    }
    log(n - 1)
    let v = n + 10
    print(v)
}

// 万能方法
// 自己维护一个栈，来保存参数，局部变量
// 但是空间复杂度依然没有得到优化
class Frame {
    let n: Int
    let v: Int
    init(n: Int, v: Int) {
        self.n = n
        self.v = v
    }
}

func log1(_ letn: Int){
    var n = letn
    var frames: [Frame] = []
    while n > 0 {
        frames.append(Frame(n: n, v: n + 10))
        n -= 1
    }
    
    while !frames.isEmpty {
        let frame = frames.removeLast()
        print(frame.v)
    }
}

// 在某些时候，也可以重复使用一组相同的变量来保存每个栈帧的内容
func log2(_ n: Int){
    for i in 1...n {
        print(i + 10)
    }
}
// 这里重复使用变量i保存原来栈帧中的参数
// 空间复杂度从O(n)降到了O(1)

// 尾调用（Tail Call）:最后调用函数
// 尾递归（Tail Recursion）：最后调用自己
// 一些编译器对尾调用进行优化，已达到节省栈空间的目的
// 因此如果遇到递归调用，可以改写成尾递归

// 示例1：
// 求n的阶乘： 1*2*3*...*(n-1)*n，其中n>0
// 这里面有递归调用，但是不是尾递归，我们需要改成尾递归
func factorial(_ n: Int) -> Int {
    if n <= 1 {return n}
    return n * factorial(n-1)
}
// 下面是尾递归
func factorial1(_ n: Int) -> Int {
    return factorial1(n, 1)
}

func factorial1(_ n: Int, _ result: Int) -> Int {
    if n <= 1 {return result}
    return factorial1(n - 1, result * n)
}

// 示例2：斐波那契数列
func fib6(_ n: Int) -> Int {
    fib(n, 1, 1)
}
func fib(_ n: Int, _ first: Int, _ second: Int) -> Int {
    if n <= 1 {
        return first
    }
    return fib(n-1, second, first + second)
}

/**
 1. 使用递归不是为了求得最优解，而是为了简化解决问题的思路，代码会更加简洁
 2. 递归求出来的很有可能不是最优解，也有可能是最优解
 总结：如果可以迭代，那就直接用迭代，如果不能迭代，那递归看看能不能转成尾递归
 */

