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
    case ace = 1 // 默认是 0开始
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
            // 此类型的 case 前面需要加 let
            case let .result(sunrise, sunset):
                print("Sunrise is at \(sunrise) and sunset is at \(sunset).")
            case let .failure(message):
                print("Failure...  \(message)")
        }
        
        let threeOfSpades = Card(rank: .three, suit: .spades)
        _ = threeOfSpades.simpleDescription()
            
    }
}
