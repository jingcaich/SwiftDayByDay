//
//  Subscript.swift
//  SwiftDayByDay
//
//  Created by caijing on 2017/7/11.
//  Copyright © 2017年 caijing. All rights reserved.
//

import Foundation

class _Subscript {
    
    func _subscript() {
        // MARK: 1
        let threeTimesTable = TimesTable(multiplier: 3) // membership initializer
        print("six times three is \(threeTimesTable[6])")
        // 字典对下标语法的用法
        var numberOfLegs = ["spider": 8, "ant": 6, "cat": 4]
        numberOfLegs["bird"] = 2
        
        // MARK: 2
        var matrix = Matrix(rows: 2, columns: 2)
        var matrix1 = matrix[1,1]
        
    }
    
    // 1. 类、结构体、枚举能定义 下标 (Subscript)
    
    subscript(index: Int) -> Int {
        // 只有 getter 也是 read-only
        get {
            // return an appropriate subscript value here
            return index
        }
        set(newValue) {
            // perform a suitable setting action here
        }
    }
    
    struct TimesTable {
        let multiplier: Int
        subscript(index: Int) -> Int {
            return multiplier * index
        }
    }
    
    // 2. Subscript Options
    // 下标语法的参数可以是任意类型, 返回参数也可以是任意类型
    struct Matrix {
        let rows: Int, columns: Int
        var grid: [Double]
        init(rows: Int, columns: Int) {
            self.rows = rows
            self.columns = columns
            grid = Array(repeating: 0.0, count: rows * columns)
        }
        func indexIsValid(row: Int, column: Int) -> Bool {
            return row >= 0 && row < rows && column >= 0 && column < columns
        }
        subscript(row: Int, column: Int) -> Double {
            get {
                assert(indexIsValid(row: row, column: column), "Index out of range")
                return grid[(row * columns) + column]
            }
            set {
                assert(indexIsValid(row: row, column: column), "Index out of range")
                grid[(row * columns) + column] = newValue
            }
        }
    }
    
}
