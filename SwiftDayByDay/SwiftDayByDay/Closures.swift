//
//  Closures.swift
//  SwiftDayByDay
//
//  Created by caijing on 2017/7/5.
//  Copyright © 2017年 caijing. All rights reserved.
//

import Foundation

class Closures{
    
    
    // 1. 闭包分为三种
    //  1. 全局函数, 有名字并且没有捕获任何变量
    //  2. 嵌套行数, 有名字并且能在封闭的函数内捕获变量
    //  3. 匿名闭包...(常用的那种)
    
    func _sort() {
        
        let names = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]
        
        func backward(_ s1: String, _ s2: String) -> Bool {
            return s1 > s2
        }
        // 1. 可以传入方法, 根据方法来排序
        var reversedNames = names.sorted(by: backward)
        
        // 2. 闭包表达式, 参数可以是 in-out 参数, 但是他们不能有默认值, 能用可变参数, Tuple 也可以作为参数和返回值
//        { (parameters) -> return type in
//            statements
//        }
        // 3. 可以使用闭包来达到上述的效果
        reversedNames = names.sorted(by: { (s1: String, s2: String) -> Bool in
            _ = s1 + s2
            return s1 > s2
        })
        reversedNames = names.sorted(by: { ( s1: String, s2: String) -> Bool in return s1 < s2 })
        
        // Swift 可以推断所需要的参数类型, 所以它的参数一定是 (String, String) -> Bool 类型, 所以没必要写出对应参数类型, 返回右箭头 -> 和 () 也不需要写了
        reversedNames = names.sorted(by: { s1, s2 in return s1 > s2 } )
        
        // 4. 单个表达式的闭包, 可以隐式 return, 所以可以再进一步简化 去除 omit
        reversedNames = names.sorted(by: { s1, s2 in s1 > s2 } )
        
        // 5. Shorthand argument name (速记参数名), 我们制定闭包的参数by $0,$1,$2 所以我们可以对上述 sorted 进一步进行简化
        reversedNames = names.sorted(by: {$0 > $1})
        
        // 6. Operator Methods, 实际上这里有更简短的方式去写上述闭包表达式
        reversedNames = names.sorted(by: >)
        
    }
    
    
    // Trailing Closures (尾闭包)
    // description: 如果你想要传递闭包给某个函数, 作为这个函数最后一个参数并且这个闭包表达式很长, 这个时候使用尾闭包是非常好的
    // 尾闭包写在函数 () 后面
    func _trailingClosures() {
        
        func someFunctionThatTakesAClosure(closure: () -> Void) {
            // function body goes here
        }
        // Here's how you call this function without using a trailing closure:
        // 就目前来说, 系统会自动推荐使用尾闭包
        someFunctionThatTakesAClosure(closure: {
            // closure's body goes here
        })
    
        // Here's how you call this function with a trailing closure instead:
        
        someFunctionThatTakesAClosure() {
            // trailing closure's body goes here
        }
        let names = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]
        
        // 所以这里我们也可以使用尾闭包来进行 sort 操作
        var reversedNames = names.sorted() {$0 > $1}
        
        // 1. 如果一个闭包表达式被提供了仅仅一个参数且是你传参数的时候给的是尾闭包, 这个时候你甚至可以去除 ()
        reversedNames = names.sorted {$0 > $1}
        // 2.
        let digitNames = [
            0: "Zero", 1: "One", 2: "Two",   3: "Three", 4: "Four",
            5: "Five", 6: "Six", 7: "Seven", 8: "Eight", 9: "Nine"
        ]
        let numbers = [16, 58, 510]
        
        // 尾闭包 省去了多余的 map(_:)
        let strings = numbers.map { (number) -> String in
            var number = number
            var output = ""
            repeat {
                // 字典通过下标所取得的值都是可选的, 所以这里选择了强制解包
                output = digitNames[number % 10]! + output
                number /= 10
            } while number > 0
            return output
        }
        // strings is inferred to be of type [String]
        // its value is ["OneSix", "FiveEight", "FiveOneZero"]”
        
    }
    
    var completionHandlers: [() -> Void] = []

    // Capturing Values 能捕获到上下文的变量和常量
    func _capturingValues() {
        
        func makeIncrementer(forIncrement amount: Int) -> () -> Int {
            var runningTotal = 0
            // amount 与 runningTotal 会 incrementer 被引用, 保证其不会消失
            func incrementer() -> Int {
                runningTotal += amount
                return runningTotal
            }
            return incrementer
        }
        
        // 1. 作为优化, Swift 在闭包内没有改变外面的变量, 会采取拷贝对应值来代替捕获对应的变量
        let incrementByTen = makeIncrementer(forIncrement: 10)
        incrementByTen()
        // returns a value of 10
        
        incrementByTen()
        // returns a value of 20
        
        incrementByTen()
        // returns a value of 30
        
//        If you create a second incrementer, it will have its own stored reference to a new, separate runningTotal variable:
        // 再创建另外一个常量, 他将会引用自己的新的 runningTotal 变量
        let incrementBySeven = makeIncrementer(forIncrement: 7)
        incrementBySeven()
        // returns a value of 7
        incrementByTen()
        // returns a value of 40
        
        // 2. 闭包是引用类型, 类似上面的 incrementByTen
        
        // 3. Escaping Closures (逃离闭包)
        // 如果闭包作为参数传递给某个函数, 你可以在参数类型前加上 @escaping 表明该闭包可以逃离
        // 其中一种作用是闭包一直被存在函数外部的变量中, 作为例子, 许多函数会用闭包来作为同步操作的 completion handler. 
        // 闭包需要 escaping
        func someFunctionWithEscapingClosure(completionHandler:  @escaping () -> Void) {
            completionHandlers.append(completionHandler)
        }
        someFunctionWithEscapingClosure { 
            print("Doing something");
        }
        
        // 4. 加了 @escaping 之后意味着在使用属性时必须显示加上 self
        func someFunctionWithNonescapingClosure(closure: () -> Void) {
            closure()
        }
        
        func doSomething() {
            someFunctionWithEscapingClosure { self.x = 100 }
            someFunctionWithNonescapingClosure { x = 200 }
        }
        
        doSomething()
        print(x)
        // Prints "200"
        
        completionHandlers.first?()
        print(x)
        // Prints "100
        
        // 5. Autoclosures (被自动创建来封装被以参数传递给某个函数的表达式, 不需要参数. 当被调用的时候, 会返回内部表达式的值)
        var customersInLine = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]
        print(customersInLine.count)
        // Prints "5"
        
        let customerProvider = { customersInLine.remove(at: 0) }
        print(customersInLine.count)
        // Prints "5"
        
        print("Now serving \(customerProvider())!")
        // Prints "Now serving Chris!"
        print(customersInLine.count)
        // Prints "4”
        
        func serve(customer customerProvider: () -> String) {
            print("Now serving \(customerProvider())!")
        }
        
        serve(customer: { customersInLine.remove(at: 0) } )
        
        // customersInLine is ["Ewa", "Barry", "Daniella"]
        func serve1(customer customerProvider: @autoclosure () -> String) {
            print("Now serving \(customerProvider())!")
        }
        // 这里所有返回 String 的表达式都会被自动转换成闭包
        serve1(customer: customersInLine.remove(at: 0))
        serve1(customer: "123")
        // Prints "Now serving Ewa!"
        
        // 过度使用 autoclosures 会造成代码的可读性降低
        // 可以同时使用 @escaping 和 @autoclosure
        // customersInLine is ["Barry", "Daniella"]
        var customerProviders: [() -> String] = []
        func collectCustomerProviders(_ customerProvider: @autoclosure @escaping () -> String) {
            customerProviders.append(customerProvider)
        }
        collectCustomerProviders(customersInLine.remove(at: 0))
        collectCustomerProviders(customersInLine.remove(at: 0))
        
        print("Collected \(customerProviders.count) closures.")
        // Prints "Collected 2 closures."
        for customerProvider in customerProviders {
            print("Now serving \(customerProvider())!")
        }
        // Prints "Now serving Barry!"
        // Prints "Now serving Daniella!
        
        }
    
    
    var x = 10
    
}























