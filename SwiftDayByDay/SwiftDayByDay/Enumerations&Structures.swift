//
//  Enumerations&Structures.swift
//  SwiftDayByDay
//
//  Created by caijing on 2017/6/29.
//  Copyright © 2017年 caijing. All rights reserved.
//

import Foundation
import UIKit

enum Rank: Int {
    // 定义多个 case, 也可以是中文
    case ace = 1 // 默认0
    // 各个 case 之间可以使用 ',' 进行分割
    case two, three, four, five, six, seven, eight, nine, ten
    case jack, queen, king, 你不懂我的心
    func simpleDescription() -> String {
        // 可以使用 self 作为 switch 的变量
        switch self {
        case .ace:
            return "ace"
        case .jack:
            return "jack"
        case .queen:
            return "queen"
        case .king:
            return "king"
        default:
//            print(self.rawValue)
            // 会有隐式的 rawValue 属性, 与 oc 中的 enum 一样都是按1递增的
            return String(self.rawValue)
        }
    }
}
// 不是隐式从 0, 1, 2, 3 开始的, 没有生命是否是 Int 类型
enum Suit {
    case spades, hearts, diamonds, clubs
    func simpleDescription() -> String {
        switch self {
        case .spades:
            return "spades"
        case .hearts:
            return "hearts"
        case .diamonds:
            return "diamonds"
        case .clubs:
            return "clubs"
        }
    }
    
    func color() -> UIColor {
        switch self {
        case .spades:
            return UIColor.cyan
        default:
            return UIColor.red
        }
    }
}

enum ServerResponse {
    case result(String, String)
    case failure(String)
}

let success = ServerResponse.result("6:00 am", "8:09 pm")
let failure = ServerResponse.failure("Out of cheese.")

// 结构体和类挺像的, 最大的区别在于 结构体被传递的是以 copy 的形式进行传递, 而类是以 reference 的形式进行传递
struct Card {
    var rank:Rank
    var suit:Suit
    
    func simpleDescription() -> String {
        return "The \(rank.simpleDescription()) of \(suit.simpleDescription())"
    }
    
}

enum Planet: Int {
    case mercury = 1, venus, earth, mars, jupiter, saturn, uranus, neptune
}


// north 的隐式值为 "north"
enum CompassPoint: String {
    case north, south, east, west
}


enum ASCIIControlCharacter: Character {
    case tab = "\t"
    case lineFeed = "\n"
    case carriageReturn = "\r"
}

// 递归枚举, 递归的 case 前面必须加上 indirect, 或者在枚举名字上加上 indirect 
enum ArithmeticExpression {
    case number(Int)
    indirect case addition(ArithmeticExpression, ArithmeticExpression)
    indirect case multiplication(ArithmeticExpression, ArithmeticExpression)
}


class Enum {
    func enumTest() {
        
        let ace = Rank.ace
        _ = ace.rawValue
        
        let hearts = Suit.hearts
        _ = hearts.simpleDescription()
        
        if let convertedRank = Rank(rawValue: 3) {
            _ = convertedRank.simpleDescription()
        }
        print(Rank.ten.rawValue)
        
        switch success {
            // 1. 此类型的 case 前面需要加 let
            case let .result(sunrise, sunset):
                print("Sunrise is at \(sunrise) and sunset is at \(sunset).")
            // 2. 或者去掉前面的 let, 给参数加上 let
            // 很明显 第一种在处理大量参数时有压倒性优势
            case .failure(let message):
                print("Failure...  \(message)")
        }
        
        let threeOfSpades = Card(rank: .three, suit: .spades)
        _ = threeOfSpades.simpleDescription()
        // 根据 rowValue 取得对应的 case, 不存在的 rowValue 则返回 nil
        let possiblePlanet = Planet(rawValue: 11)
//        possiblePlanet 是 Planet? or Oprional Planet
        // 1. 递归枚举
        
    }
}






























