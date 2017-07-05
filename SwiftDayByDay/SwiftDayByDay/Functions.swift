//
//  Functions.swift
//  SwiftDayByDay
//
//  Created by caijing on 2017/6/29.
//  Copyright © 2017年 caijing. All rights reserved.
//

import Foundation

class Functions {
    
    var numbers = [20, 19, 7, 12]
    // 函数实际上是特殊的闭包
    func functions() {
        
        _ = greet(person: "Bob", day: "Tuesday")
        _ = greet1("Bob", day: "Thursday")
        let statistics = calculateStatistics(scores: [5, 3, 100, 3, 9])
        print(statistics.sum) // 指定 tuple 中具体的某个 label
        print(statistics.0) // 也指定 tuple index (会进行校验, index 超过总数则会报错)
        _ = returnFifteen()
        let increment = makeIncrementer()
        _ = increment(7)
        _ = hasAnyMatches(list: numbers, condition: lessThanTen)
        // 闭包
        numbers = numbers.map({ (number: Int) -> Int in
            let result = 3 * number
            return result;
        })
        // 简化后的闭包，可以没有参数及返回值, 但默认会返回唯一的语句
        let mappedNumbers = numbers.map({ number in 3 * number })
        print(mappedNumbers)
        // 可以依靠指定数字来代替名字, 一下方法在比较简单的闭包内非常有用, 当闭包是某个函数的唯一参数时, 可以去掉 ()
        let sortedNumbers = numbers.sorted { $0 > $1 }
        print(sortedNumbers)

    }
    
    // 函数可以拿另一个函数当参数
    func hasAnyMatches(list: [Int], condition: (Int) -> Bool) -> Bool {
        for item in list {
            if condition(item) {
                return true
            }
        }
        return false
    }
    func lessThanTen(number: Int) -> Bool {
        return number < 10
    }
    
    // 以函数为返回值
    func makeIncrementer() -> ((Int) -> Int) {
        func addOne(number: Int) -> Int {
            return 1 + number
        }
        return addOne
    }
    
    
    func greet(person: String, day: String) -> String {
        return "Hello \(person), today is \(day)."
    }
    
    // 可以函数参数中加 _ 取消 label 的显示
    func greet1(_ person: String, day: String) -> String {
        return "Hello \(person), today is \(day)."
    }
    
    // 可以返回 tuple 来表达复合值
    func calculateStatistics(scores: [Int]) -> (min: Int, max: Int, sum: Int) {
        var min = scores[0]
        var max = scores[0]
        var sum = 0
        
        for score in scores {
            if score > max {
                max = score
            } else if score < min {
                min = score
            }
            sum += score
        }
        
        return (min, max, sum)
    }
    // 函数中也可以 增加函数 (Nested functions), 用来分割较长或者复杂的代码
    func returnFifteen() -> Int {
        var y = 10
        func add() {
            y += 5
        }
        add()
        return y
    }
    // 针对文档中提到的 first class function
    /**
     First Class。该类型的值可以作为函数的参数和返回值，也可以赋给变量。
     Second Class。该类型的值可以作为函数的参数，但不能从函数返回，也不能赋给变量。
     Third Class。该类型的值作为函数参数也不行
     */
    
    func greetAgain(person: String) -> String {
        return "Hello again, " + person + "!"
    }
    
    func greet(person: String) -> String {
        let greeting = "Hello, " + person + "!"
        return greeting
    }
    // 函数可以同名, 但是不能连参数也相同
    func greet(person: String, alreadyGreeted: Bool) -> String {
        if alreadyGreeted {
            return greetAgain(person: person)
        } else {
            return greet(person: person)
        }
    }
    // 函数可以有默认值
    func someFunction(argumentLabel parameterName: Int) {
        // In the function body, parameterName refers to the argument value
        // for that parameter.
    }
    
    // Variadic Parameters (可变参数, 不多最多只能有一个这样的参数)
    func variadic() {
        
        func arithmeticMean(_ numbers: Double...) -> Double {
            var total: Double = 0
            for number in numbers {
                total += number
            }
            return total / Double(numbers.count)
        }
        
        arithmeticMean(1, 2, 3, 4, 5)
        // returns 3.0, which is the arithmetic mean of these five numbers
        arithmeticMean(3, 8.25, 18.75)
        // returns 10.0, which is the arithmetic mean of these three numbers
        
    }
    
    // In-Out Parameters 普遍来说函数参数都是常量, 尝试着去修改可能会引起 compile-time error
    // 可以在前面加上 inout 来解决, 所以相对来说你就不能传常量或者字面语法的值
    func _inout (){
        func swapTwoInts(_ a: inout Int, _ b: inout Int) {
            let temporaryA = a
            a = b
            b = temporaryA
        }
        
        var a:Int = 1
        var b:Int = 2
        // 会自动加上 & label
        swapTwoInts(&a, &b)
        
    }
    
    // function type (将函数的参数、返回值数量及类型称作为一个函数的类型)
    // 相同函数类型的函数可以赋值
    func _functionType() {
        
        func addTwoInts(_ a: Int, _ b: Int) -> Int {
            return a + b
        }
        func multiplyTwoInts(_ a: Int, _ b: Int) -> Int {
            return a * b
        }
        
        var mathFunction: (Int, Int) -> Int = addTwoInts
        
        // 也可以将函数类型作为参数
        func printMathResult(_ mathFunction: (Int, Int) -> Int, _ a: Int, _ b: Int) {
            print("Result: \(mathFunction(a, b))")
        }
        printMathResult(addTwoInts, 3, 5)
        
        func stepForward(_ input: Int) -> Int {
            return input + 1
        }
        
        func stepBackward(_ input: Int) -> Int {
            return input - 1
        }
        // 可以作为返回值
        func chooseStepFunction(backward: Bool) -> (Int) -> Int {
            return backward ? stepBackward : stepForward
        }
        
        
    }
    
    
}
