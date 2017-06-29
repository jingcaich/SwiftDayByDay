//
//  Objects&Classes.swift
//  SwiftDayByDay
//
//  Created by caijing on 2017/6/29.
//  Copyright © 2017年 caijing. All rights reserved.
//

import Foundation

class Shape {
    var numberOfSides = 0
    func simpleDescription() -> String {
        return "A shape with \(numberOfSides) sides."
    }
}

class NamedShape {
    var numberOfSides: Int = 0
    var name: String
    
    init(name: String) {
        self.name = name
    }
    
    func simpleDescription() -> String {
        return "A shape with \(numberOfSides) sides."
    }
}

class Square: NamedShape {
    var sideLength: Double
    
    init(sideLength: Double, name: String) {
        self.sideLength = sideLength
        super.init(name: name)
        numberOfSides = 4
    }
    
    func area() -> Double {
        return sideLength * sideLength
    }
    // 继承使用 override
    override func simpleDescription() -> String {
        return "A square with sides of length \(sideLength)."
    }
}

class EquilateralTriangle: NamedShape {
    var sideLength: Double = 0.0
    
    init(sideLength: Double, name: String) {
        self.sideLength = sideLength
        super.init(name: name)
        numberOfSides = 3
    }
    
    // 重写 getter 和 setter 方法
    var perimeter: Double {
        get {
//            return perimeter;
            return 3.0 * sideLength
        }
        set {
            // set的新值隐式的名字叫做 newValue,
            sideLength = newValue / 3.0
        }
    }
    
    override func simpleDescription() -> String {
        return "An equilateral triangle with sides of length \(sideLength)."
    }
}

class TriangleAndSquare {
    // willSet 和 didSet 也是隐式的 newValue 代表新值, 当值变化的时候会调用, 但是在 initializer 中不会触发
    var triangle: EquilateralTriangle {
        willSet {
            square.sideLength = newValue.sideLength
        }
    }
    var square: Square {
        willSet {
            triangle.sideLength = newValue.sideLength
        }
    }
    init(size: Double, name: String) {
        square = Square(sideLength: size, name: name)
        triangle = EquilateralTriangle(sideLength: size, name: name)
    }
}

class  ObjectsAndClasses{
    
    // 每个属性都需要去初始化, 可以 initializer 中进行初始化, 也可以以下面的方式进行初始化
    var name = "ede"
    var nicke: String = "ch"
    
    func Tips() {
        
        let test = Square(sideLength: 5.2, name: "my test square")
        _ = test.area()
        _ = test.simpleDescription()
        
        let triangle = EquilateralTriangle(sideLength: 3.1, name: "a triangle")
        print(triangle.perimeter)
        triangle.perimeter = 9.9
        print(triangle.sideLength)
        
    }
    // 析构
    deinit {
        // 对象被清理或者回收时会调用这个函数
    }
    
}
