//
//  395_至少有K个重复字符的最长子串.swift
//  Algorithms
//
//  Created by sheng on 2022/11/3.
//

import Foundation
// https://leetcode.cn/problems/longest-substring-with-at-least-k-repeating-characters/?show=1

class LongestSubstring: Runnable {
    
    func run() {
        print(longestSubstring("aaabb", 3))
    }
    
    
    /**
     输入：s = "aaabb", k = 3
     输出：3
     解释：最长子串为 "aaa" ，其中 'a' 重复了 3 次。
     
     1. 什么时候扩大窗口？
     2. 什么时候缩小窗口？
     3. 什么时候得到一个合理的答案？
     
     在本题的场景中，我们想尽可能多地装字符，即扩大窗口，但不知道什么时候应该开始收缩窗口。

     为什么呢？比如窗口中有些字符出现次数不满足 k，但有可能再扩大扩大窗口就能满足 k 了呀？但要这么说的话，你干脆一直扩大窗口算了，所以你说不准啥时候应该收缩窗口。

     理论上讲，这种情况就不能用滑动窗口模板了，但有时候我们可以自己添加一些约束，来进行窗口的收缩。

     题目说让我们求每个字符都出现至少 k 次的子串，我们可以再添加一个约束条件：
     求每个字符都出现至少 k 次，仅包含 count 种不同字符的最长子串。

     // 在 s 中寻找仅含有 count 种字符，且每种字符出现次数都大于 k 的最长子串
     func logestKLetterSubstr(_ s: String, _ k: Int, _ count: Int) {
     
     }
     
     回答滑动窗口算法的三个问题：
     1. 什么时候扩大窗口？
        窗口中字符种类小于count时扩大窗口
     2. 什么时候缩小窗口？
     窗口中字符种类大于count时缩小窗口
     3. 什么时候得到一个合理的答案？
     窗口中所有字符出现的次数都大于等于k时，得到一个合法的子串
     
     然后就可以套用滑动窗口算法模板实现 logestKLetterSubstr 函数了。
     
     当然，题目没有 count 的约束，那没关系呀，count 能有几种取值？
     因为 s 中只包含小写字母，所以 count 的取值也就是 1~26，所以最后用一个 for 循环把这些值都输入 logestKLetterSubstr 计算一遍，求最大值就是题目想要的答案了。
     
     这充分体现了前文 我的刷题经验总结 中所说：算法的本质是穷举。
     
     滑动窗口算法的时间复杂度是 O(N)，循环 26 次依然是 O(26N) = O(N)。
     
     */
    func longestSubstring(_ s: String, _ k: Int) -> Int {
        var len = 0
        for i in 1...26 {
            len = max(len, longestKLetterSubstr(s, k, i))
        }
        return len
    }
    
    // 在 s 中寻找仅含有 count 种字符，且每种字符出现次数都大于 k 的最长子串
    func longestKLetterSubstr(_ s: String, _ k: Int, _ count: Int) -> Int {
        var res = 0
        
        var left = 0
        var right = 0
        // 因为只有26个小写字母，可以使用数字记录字符出现的次数
        var windowCount = Array(repeating: 0, count: 26)
        
        // 记录窗口中存在几种不同的字符
        var windowUniqueCount = 0
        // 记录窗口中存在几种字符的出现次数达标(大于等于k)
        var windowValidCount = 0
        
        while right < s.count {
            // 移入字符，扩大窗口
            let c = Array(s)[right]
            let index = c.intValue - Character("a").intValue
            
            if windowCount[index] == 0 {
                // 窗口中新增了一种字符
                windowUniqueCount += 1
            }
            
            windowCount[index] += 1
            
            // 判断有几种字符出现的次数达标
            if windowCount[index] == k {
                windowValidCount += 1
            }
            
            right += 1
            
            // 当窗口中字符种类大于k时，需要缩小窗口
            while windowUniqueCount > count {
                // 移除字符，缩小窗口
                let d = Array(s)[left]
                let idx = d.intValue -  Character("a").intValue
                if windowCount[idx] == k {
                    // 窗口中减小了一种达标的字符
                    windowValidCount -= 1
                }
                
                windowCount[idx] -= 1
                
                if windowCount[idx] == 0 {
                    // 窗口中少了一种字符
                    windowUniqueCount -= 1
                }
                left += 1
            }
            
            // 到这里代表每个字符出现次数都满足 k
            // 因此当窗口中有效字符种类为 count，更新一个答案
            if windowValidCount == count {
                res = max(res, right - left)
            }
        }
        return res
    }
}
