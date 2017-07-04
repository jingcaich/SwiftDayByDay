//
//  Optional.swift
//  SwiftDayByDay
//
//  Created by caijing on 2017/7/3.
//  Copyright © 2017年 caijing. All rights reserved.
//

import Foundation

class Optional1 {
    
    func optional1 (){
        
        
        // Int? 代表不一定有值 可以被赋值为 nil, 如果去掉 ?, 则不能被赋值为 nil, 无论 var or let
        var var1:String? //默认赋值为 nil
        
        // 隐式可选解包, 在类型后面加 !, unowned property 可以使用, 确保在 initializer 之后一直有值
        // 也可以当正常可选值的来对待
        let possibleString: String? = "An optional string."
        let forcedString: String = possibleString! // requires an exclamation mark
        // 在读取 隐式可选解包时, 如果为nil, 则会引起 runtime error
        let assumedString: String! = "An implicitly unwrapped optional string."
        let implicitString: String = assumedString // no need for an exclamation mark”
        
        
        /* 可选绑定 (Optional Binding)
         * 可选绑定使用来判断是否一个 optional 有值, 如果有, 创建一个临时变量或者常量
         */
        // 强制解包 (Forced unwrapping)
        // 使用 ! 来强制解包
        if let a = var1 {
            print("a+\(a)")
            
        }
        // if中使用多个条件可以使用 , 进行分割, 类似 &&, 必须全为 ture 才能继续执行
        if let firstNumber = Int("4"), let secondNumber = Int("42"), firstNumber < secondNumber && secondNumber < 100 {
            print("\(firstNumber) < \(secondNumber) < 100")
        }
    // Prints "4 < 42 < 100"
        // 同上
        if let firstNumber = Int("4") {
            if let secondNumber = Int("42") {
            if firstNumber < secondNumber && secondNumber < 100 {
            print("\(firstNumber) < \(secondNumber) < 100")
            }
            }
        }
        // unowned 关键字, 类似 weak 关键字, 并不会强引用对象, 但是必须保证属性生命周期比 self 长或者相同, 如果访问的时候没值, 则会报 runtime error
        unowned let viewC:ViewController
        
    
    }
    
}
