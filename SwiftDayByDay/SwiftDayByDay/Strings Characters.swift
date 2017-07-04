//
//  Strings Characters.swift
//  SwiftDayByDay
//
//  Created by caijing on 2017/7/3.
//  Copyright © 2017年 caijing. All rights reserved.
//

import Foundation

class StringsCharacters {
    
    // String 与 NSString 是桥接的
    // String 是值类型, 在传递之后只有在必要的情况下才进行 copy, 优化
    func strings() {
        
        
        var emptyString = ""               // empty string literal
        var anotherEmptyString = String()  // initializer syntax
        // these two strings are both empty, and are equivalent to each other”
        
        if emptyString.isEmpty {
            print("Nothing to see here")
        }
        // Prints "Nothing to see here”
        
        // 可变字符串 只要声明 var 的变量即可
        var variableString = "Horse"
        variableString += " and carriage"
        // variableString is now "Horse and carriage"
        
//        let constantString = "Highlander"
//        constantString += " and another Highlander"
        // this reports a compile-time error - a constant string cannot be modified”
        
        // String Interpolation 字符串插改
        let multiplier = 3
        let message = "\(multiplier) times 2.5 is \(Double(multiplier) * 2.5)"
        
        let wiseWords = "\"Imagination is more important than knowledge\" - Einstein"
        // "Imagination is more important than knowledge" - Einstein
        let dollarSign = "\u{24}"        // $,  Unicode scalar U+0024
        let blackHeart = "\u{2665}"      // ♥,  Unicode scalar U+2665
        let sparklingHeart = "\u{1F496}" // 💖, Unicode scalar U+1F496”
        
        let precomposed: Character = "\u{D55C}" //  한
        
        // String indices ,String 有 index type, 可以通过下标简语法来访问
        
        let greeting = "Guten Tag!"
        _ = greeting[greeting.startIndex]
        // G
        _ = greeting[greeting.index(before: greeting.endIndex)]
        // !
        _ = greeting[greeting.index(after: greeting.startIndex)]
        // u
        let index = greeting.index(greeting.startIndex, offsetBy: 7)
        _ = greeting[index]
        // a
        
        for index in greeting.characters.indices {
            print("\(greeting[index]) ", terminator:"")
        }
        // String 类型的比较直接用 比较运算符就好
        
        //标准等价（canonically equivalent） 只要 extended grapheme clusters 是标准等价即相等, extended grapheme clusters 相等只要在语言上的意思和展现相同即可
        // "Voulez-vous un café?" using LATIN SMALL LETTER E WITH ACUTE
        let eAcuteQuestion = "Voulez-vous un caf\u{E9}?"
        
        // "Voulez-vous un café?" using LATIN SMALL LETTER E and COMBINING ACUTE ACCENT
        let combinedEAcuteQuestion = "Voulez-vous un caf\u{65}\u{301}?"
        
        if eAcuteQuestion == combinedEAcuteQuestion {
            print("These two strings are considered equal")
        }
        // Prints "These two strings are considered equal
        
        // 相反的如果语言上的意思不同，则判断不相同
        let latinCapitalLetterA: Character = "\u{41}" // 拉丁文 大写 A, 通常用于英语
        
        let cyrillicCapitalLetterA: Character = "\u{0410}" // 西里尔字母的大写 A, 通常用于俄语
        
        if latinCapitalLetterA != cyrillicCapitalLetterA {
            print("These two characters are not equivalent.")
        }
        // Prints "These two characters are not equivalent."
        
        
        
    }
    
    func characters() {
        
        // 遍历字符
        for character in "Dog!🐶".characters {
            print(character)
        }
        // 定义单个字符
        let exclamationMark: Character = "!"
        let catCharacters: [Character] = ["C", "a", "t", "!", "🐱"]
        // 可以直接转
        let catString = String(catCharacters)
        print(catString)
        // Prints "Cat!🐱
        // Character 类型的变量 不能 append 任何 String 或者 Character, 因为 Character 只能是单个的字符
        let dogString = "Dog‼🐶"
        // 可以打印 unicode 标量, 这里会将标量转化为 🐶
        for scalar in dogString.unicodeScalars {
            print("\(scalar) ")
        }
        
    }
    
    
}
