//
//  ControlFlow.swift
//  SwiftDayByDay
//
//  Created by caijing on 2017/6/29.
//  Copyright © 2017年 caijing. All rights reserved.
//

import Foundation


class ControlFlow {
    
    func Tips() {
        
        let vegetable = "red pepper"
        switch vegetable {
        case "celery":
            print("Add some raisins and make ants on a log.")
        case "cucumber", "watercress":
            print("That would make a good tea sandwich.")
        case let x where x.hasSuffix("pepper"):
            print("Is it a spicy \(x)?")
        default:
            print("Everything tastes good in soup.")
        }
        // 如果 switch 去掉 default 会报错
        // 如果 case 匹配会隐式的 break, 无数手动加
        
        let nickName: String? = "ad"
        let fullName: String = "John Appleseed"
        _ = "Hi \(nickName ?? fullName)"
        // 可以使用 ?? 来代替 oc 中的 ?:
        
        var m = 2
        repeat {
            m *= 2
        } while m < 100
        print(m)
        // repeat while 代替了 do while
        
        var total = 0
        for i in 0..<4 {
            total += i
        }
        print(total)
        // 使用 ..< 代表某个值范围 用 ... 则包两个值也包含
        
    }
    
}
