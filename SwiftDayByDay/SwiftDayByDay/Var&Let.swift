//
//  Var&Let.swift
//  SwiftDayByDay
//
//  Created by caijing on 2017/6/30.
//  Copyright © 2017年 caijing. All rights reserved.
//

import Foundation

class VarAndConstant {
    
    
    func varLet () {
        // 如果一定要使用 系统关键字作为变量名, 用 ``
        let `var`:String = ""
        print(`var`)
        
//        “For hexadecimal numbers with an exponent of exp, the base number is multiplied by 2exp:
//        0xFp2 means 15 x 22, or 60.0.
//        0xFp-2 means 15 x 2-2, or 3.75.”
        let hexadecimalDouble = 0xC.3p0
        print(hexadecimalDouble)
        // 可以使用额外的0
        let paddedDouble = 000123.456
        let oneMillion = 1_000_000
        let justOverOneMillion = 1_000_000.000_000_1
        
        let pi = Double(oneMillion) + paddedDouble
        // 别名 类似 typedef
        typealias AudioType = UInt16
        let http200Status = (statusCode: 200, description: "OK")
        print(http200Status.statusCode)
        
//        摘录来自: Apple Inc. “The Swift Programming Language (Swift 3.1)”。 iBooks.
        
    }
    
}
