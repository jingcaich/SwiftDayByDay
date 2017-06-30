//
//  ErrorHandling.swift
//  SwiftDayByDay
//
//  Created by caijing on 2017/6/30.
//  Copyright © 2017年 caijing. All rights reserved.
//

import Foundation

// 我们一般遵守 Error 协议来显示错误
enum PrinterError: Error {
    case outOfPaper // 没纸
    case noToner // 没墨盒
    case onFire // 着火
    case 打印机爆炸了
    
    func decription1() -> String{
        switch self {
        case .outOfPaper:
            return "妹纸了"
        default:
            return "坏了"
        }
        
    }
}

class ErrorHandling {
    
    // 使用 throw 关键字来抛出异, 并且用 throws 来标记这个函数能抛出异常, 如果你在函数中抛出异常, 这个函数会理解 return, 并且能捕捉到异常
    func send(job: Int, toPrinter printerName: String) throws -> String {
        if printerName == "Never Has Toner" {
            throw PrinterError.noToner
        }
        
        if printerName == "Never Has Paper" {
            throw PrinterError.打印机爆炸了
        }
        
        return "Job sent"
    }
    
    
    func errorHandling() {
        
        // 这里有几种方式去捕捉异常, 其中一种就是 do-catch, 在 do block中, 你可以在代码前面写上 try 来标记这段代码能抛出异常, 在 catch block 中, 异常会被自己命名 error 除非你自定义了一个名字
        do {
            let printerResponse = try send(job: 1040, toPrinter: "Never Has Toner")
            print(printerResponse)
        } catch {
            print(error)
        }
        
        // 我们也可以使用多个 catch 来捕捉指定异常,
        do {
            let printerResponse = try send(job: 1440, toPrinter: "Never Has Paper")
            print(printerResponse)
        } catch PrinterError.onFire {
            print("I'll just put this over here, with the rest of the fire.")
        } catch let printerError as PrinterError {
            print("Printer error: \(printerError).")
        } catch {
            print(error)
        }
        
        // 另一种用来捕捉异常的方法就是 try? 来转换结果为 optional, 如果的函数抛出异常, 具体的异常被抛弃并且得到的结果为nil, 不然这个结果是一个包含返回的值
        // 为 nil 时说明抛出了异常
        let printerSuccess = try? send(job: 1884, toPrinter: "Mergenthaler")
        let printerFailure = try? send(job: 1885, toPrinter: "Never Has Toner")
        
        // 使用 defer 来写一个代码块, 这个代码块会再函数的最后执行, 仅仅在 return 语句之前。并且这个代码会无视抛出异常被执行。你可以使用 defer 来写 setup 接着写 cleanup, 即使他们需要被执行不同的次数
        var fridgeIsOpen = false
        let fridgeContent = ["milk", "eggs", "leftovers"]
        
        func fridgeContains(_ food: String) -> Bool {
            fridgeIsOpen = true
            defer {
                fridgeIsOpen = false
            }
            
            let result = fridgeContent.contains(food)
            return result
        }
        _ = fridgeContains("banana")
        print(fridgeIsOpen)
    }
    
}
