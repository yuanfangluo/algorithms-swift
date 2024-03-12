//
//  150_逆波兰表达式求值.swift
//  Algorithms
//
//  Created by sheng on 2022/10/23.
//

import Foundation
// https://leetcode.cn/problems/evaluate-reverse-polish-notation/

class EvalRPN: Runnable {
    func run() {
        print(evalRPN(["2", "1", "+", "3", "*"]))
    }
    
    func isOperator(_ token: String) -> Bool {
        "+-*/".contains(token)
    }
    
    func calculator(_ left: Int, _ right: Int, _ operate: String) -> Int {
        switch operate {
        case "+":
            return left + right
        case "-":
            return left - right
        case "*":
            return left * right
        default:
            return left / right
        }
    }
    
    let stack = Stack<Int>()
    private func evalRPN(_ tokens: [String]) -> Int {
        for token in tokens {
            if isOperator(token) {
                let right = stack.pop()!
                let left = stack.pop()!
                let result = calculator(left, right, token)
                stack.push(result)
            } else {
                stack.push(Int(token)!)
            }
        }
        return stack.top!
    }
}




