//
//  Generics.swift
//  SwiftDayByDay
//
//  Created by caijing on 2017/6/30.
//  Copyright © 2017年 caijing. All rights reserved.
//

import Foundation

/** 
 *  关于 Generics 的概念, 可以参考 https://www.ibm.com/developerworks/cn/java/Java_and_Generics/index.html
 *  类似 OC 中的 id, c++ Template, java 中的 <T>
 */

class Generics {
    
    func makeArray<Item>(repeating item: Item, numberOfTimes: Int) -> [Item] {
        var result = [Item]() // 创建对应 item 的容器
        for _ in 0..<numberOfTimes {
            result.append(item) // 存放 item
        }
        return result
    }
    
    // 你也可以使用 Generics 在函数, 方法, 类, 枚举, 结构体
    
    // Reimplement the Swift standard library's optional type
    enum OptionalValue<Wrapped> {
        case none
        case some(Wrapped)
    }
    /**
     * public protocol Equatable {
     
     /// Returns a Boolean value indicating whether two values are equal.
     ///
     /// Equality is the inverse of inequality. For any values `a` and `b`,
     /// `a == b` implies that `a != b` is `false`.
     ///
     /// - Parameters:
     ///   - lhs: A value to compare.
     ///   - rhs: Another value to compare.
     public static func ==(lhs: Self, rhs: Self) -> Bool
     }
     *
     */
    func anyCommonElements<T: Sequence, U: Sequence>(_ lhs: T, _ rhs: U) -> Bool
        where T.Iterator.Element: Equatable, T.Iterator.Element == U.Iterator.Element {
            for lhsItem in lhs {
                for rhsItem in rhs {
                    if lhsItem == rhsItem {
                        return true
                    }
                }
            }
            return false
    }
    
    func generics(){
        
        _ = makeArray(repeating: "knock", numberOfTimes: 4)
        var possibleInteger: OptionalValue<Int> = .none
        possibleInteger = .some(100)
        print(possibleInteger);
        _ = anyCommonElements([1, 2, 3], [3])

    }
    
}
