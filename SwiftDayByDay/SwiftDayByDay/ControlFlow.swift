//
//  ControlFlow.swift
//  SwiftDayByDay
//
//  Created by caijing on 2017/6/29.
//  Copyright © 2017年 caijing. All rights reserved.
//

import Foundation


class ControlFlow {
    
    func tips() {
        
        let vegetable = "red pepper"
        switch vegetable {
        case "celery":
            print("Add some raisins and make ants on a log.")
        case "cucumber", "watercress": // 使用 , 分割多个 case
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
    
    func _switch() {
        
        // 1. 不会 Implicit Fallthrough, 在 c 或者 oc 中 case 中没加 break就会默认 fallthrough
        // 2. break 虽然在 swift 中不是必须, 你可以中断某个 case 的语句
        // 3. 支持范围匹配
        let approximateCount = 66
        let countedThings = "moons orbiting Saturn"
        var naturalCount: String
        switch approximateCount {
        case 0:
            naturalCount = "no"
        case 1..<5:
            naturalCount = "a few"
        case 5..<12:
            naturalCount = "several"
        case 12..<100:
            naturalCount = "dozens of"
        case 100..<1000:
            naturalCount = "hundreds of"
        default:
            naturalCount = "many"
        }
        print("There are \(naturalCount) \(countedThings).")
        // Prints "There are dozens of moons orbiting Saturn.
        
        // 4. 支持 Tuple 匹配
        let somePoint = (1, 1)
        switch somePoint {
        case (0, 0):
            print("(0, 0) is at the origin")
        case (_, 0): // 只需要匹配单个
            print("(\(somePoint.0), 0) is on the x-axis")
        case (0, _):
            print("(0, \(somePoint.1)) is on the y-axis")
        case (-2...2, -2...2): // 范围匹配
            print("(\(somePoint.0), \(somePoint.1)) is inside the box")
        default:
            print("(\(somePoint.0), \(somePoint.1)) is outside of the box")
        }
        
        // 5. 值绑定
        let anotherPoint = (2, 0)
        switch anotherPoint {
        case (let x, 0):
            print("on the x-axis with an x value of \(x)")
        case (0, let y):
            print("on the y-axis with a y value of \(y)")
        case let (x, y):
            print("somewhere else at (\(x), \(y))")
        }
        // Prints "on the x-axis with an x value of 2
        
        // 6. 使用 where 进行条件检查
        let yetAnotherPoint = (1, -1)
        switch yetAnotherPoint {
        case let (x, y) where x == y:
            print("(\(x), \(y)) is on the line x == y")
        case let (x, y) where x == -y:
            print("(\(x), \(y)) is on the line x == -y")
        case let (x, y):
            print("(\(x), \(y)) is just some arbitrary point")
        }
        // 7. 复合 case (个人认为等价于 fall through)
        let someCharacter: Character = "e"
        switch someCharacter {
        case "a", "e", "i", "o", "u":
            print("\(someCharacter) is a vowel")
        case "b", "c", "d", "f", "g", "h", "j", "k", "l", "m",
             "n", "p", "q", "r", "s", "t", "v", "w", "x", "y", "z":
            print("\(someCharacter) is a consonant")
        default:
            print("\(someCharacter) is not a vowel or a consonant")
        }
        // 7.1 复合 case 也支持 value binding
        let stillAnotherPoint = (9, 0)
        switch stillAnotherPoint {
        case (let distance, 0), (0, let distance):
            print("On an axis, \(distance) from the origin")
        default:
            print("Not on an axis")
        }
        
        func controlTransferStatement() {
            
            // 1. 控制转移状态 (Control Transfer Statement)有 5 种
            /**
             * continue
             * break
             * fallthrough
             * return
             * throw
             */
            
            // 2. 主要记下 fallthrough
            let integerToDescribe = 5
            var description = "The number \(integerToDescribe) is"
            switch integerToDescribe {
            case 2, 3, 5, 7, 11, 13, 17, 19:
                description += " a prime number, and also"
                fallthrough // 对 default 进行 fallthrough 比较多
            default:
                description += " an integer."
            }
            print(description)
            // Prints "The number 5 is a prime number, and also an integer.”
            
        }
        
    }
    
    // 被标记的语句
    func labeledStatement() {
        // 对某个 loops or conditional statement . U can use Labeled Statement
        // 主要针对于嵌套循环或者条件语句, 来看下例子吧
        
        // 文档上还是以 Snakes and Ladders 为例
        let finalSquare = 25
        // 创建空棋盘
        var board = [Int](repeating: 0, count: finalSquare + 1)
        // 设置对应格子的 Snakes and Ladders
        board[03] = +08; board[06] = +11; board[09] = +09; board[10] = +02
        board[14] = -10; board[19] = -11; board[22] = -02; board[24] = -08
        var square = 0
        var diceRoll = 0
        
        // gameLoop 为 while 循环的标记
        gameLoop: while square != finalSquare {
            diceRoll += 1
            if diceRoll == 7 { diceRoll = 1 }
            switch square + diceRoll {
            case finalSquare: // 正好达到终点
                // diceRoll will move us to the final square, so the game is over
                break gameLoop // 跳出循环
            case let newSquare where newSquare > finalSquare: // 大于终点数无效
                // diceRoll will move us beyond the final square, so roll again
                continue gameLoop //循环 (每个 case 下面必须得有些什么, 不然会报 compile error)
            default:
                // this is a valid move, so find out its effect
                square += diceRoll
                square += board[square]
            }
        }
        print("Game over!")
        
    }
    
    // Early Exit (提前退出)
    func _guard() {
        
        // guard 和 if 其实差不多的, 都是依赖于表达式的返回的 bool 值进行后续操作
        // 但是和 if 不一样的是, guard 后面总是会有 else 分句, 如果给予的表达式为 false 时则执行 else 后面的代码块
        
        func greet(person: [String: String]) {
            guard let name = person["name"] else {
                return
            }
            
            print("Hello \(name)!")
            
            guard let location = person["location"] else {
                print("I hope the weather is nice near you.")
                return
            }
            
            print("I hope the weather is nice in \(location).")
        }
        
        greet(person: ["name1":"123", "location":"shanghai"])
        //什么都不打印
        greet(person: ["name": "John"])
        // Prints "Hello John!"
        // Prints "I hope the weather is nice near you."
        greet(person: ["name": "Jane", "location": "Cupertino"])
        // Prints "Hello Jane!"
        // Prints "I hope the weather is nice in Cupertino.
        
        
    }
    
    // 相比 OC 来说还是方便点
    func checkingAPI_Availablity() {
        
        if #available(iOS 10, macOS 10.12, *) {
            // Use iOS 10 APIs on iOS, and use macOS 10.12 APIs on macOS
        } else {
            // Fall back to earlier iOS and macOS APIs
        }
        
    }
}
