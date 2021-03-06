//
//  Objects&Classes.swift
//  SwiftDayByDay
//
//  Created by caijing on 2017/6/29.
//  Copyright © 2017年 caijing. All rights reserved.
//

import Foundation

// 1. Swift 中的结构体可以直接给子属性进行赋值(sub-properties), OC 则不行
// 2. 所有的结构体可以自动生成 成员初始化器 (Memberwise Initializers), 类不行
// 3. 比较两个变量或者常量是否来之同一个类的实例 可以使用 === or !== 来进行比较 ()
// Identical to (===)
// Not identical to (!==)
// 4. Swift 中的引用类似于 c c++ oc 中的指针, 但实际上并不是指针地址

// 5. 类和结构体的使用选择
// 5.1 结构体的主要目的是储存相近的值
// 5.2 从你对所封装的值的使用方式来决定, 是引用还是值传递
// 5.3 结构体的任何属性储存的值都是他们自己的类型, 被预计复制传值比引用传递要好
// 5.4 不用考虑继承
// 6. 目前 Swift 中的 Strings, Arrays, Dictionarys 都是 Struct, 所以在传值的过程中只是以 copy 的方式进行传值
// 7. 声明某个结构体的实例为常量, 它的所有属性都不能被改变了

// 8. Swift 中的 lazy loading properties (非线程安全)
// 9. Stored Properties and Instance Variables (被储存的属性 和 实例变量), Swift 只有一种方式(这段翻译起来不通)
// 10. Computed Properties (Getter & Setter)
// 10.1 read-only 只实现 getter 方法即为 read-only 属性 (只能使用 var 关键字进行定义)
// Property Observers(属性观察) (懒加载属性不能使用属性观察, 主要关键字是 willSet 和 didSet, 即使连续赋同一个值也是会调用的)
// 当我们传递属性 (Property Observers) 给函数的 in-out 类型的参数时, willSet 和 didSet 会被调用, 因为 in-out 参数会被 copy-in copy-out, 在函数结束后总是会被写回给属性
// 全局的变量实际上就是懒加载属性, 不需要 lazy 修饰符

class StepCounter {
    
    var totalSteps: Int = 0 {
        // 自定义的值 newTotalSteps
        willSet(newTotalSteps) {
            print("About to set totalSteps to \(newTotalSteps)")
        }
        didSet {
            // 隐式有 oldValue, 默认
            if totalSteps > oldValue  {
                print("Added \(totalSteps - oldValue) steps")
            }
        }
    }
    
    func step() {
        
        let stepCounter = StepCounter()
        stepCounter.totalSteps = 200
        // About to set totalSteps to 200
        // Added 200 steps
        stepCounter.totalSteps = 360
        // About to set totalSteps to 360
        // Added 160 steps
        stepCounter.totalSteps = 896
        // About to set totalSteps to 896
        // Added 536 steps
        
    }
}

// 11. 全局和局部变量 
// 全局变量和局部变量也支持 (Property Observers)

struct Point {
    var x = 0.0, y = 0.0
}
struct Size {
    var width = 0.0, height = 0.0
}
struct Rect {
    var origin = Point()
    var size = Size()
    var center: Point {
        get {
            let centerX = origin.x + (size.width / 2)
            let centerY = origin.y + (size.height / 2)
            return Point(x: centerX, y: centerY)
        }
        set(newCenter) {
            origin.x = newCenter.x - (size.width / 2)
            origin.y = newCenter.y - (size.height / 2)
        }
    }
}
class Comp {
    func comp(){
        var square = Rect(origin: Point(x: 0.0, y: 0.0),
                          size: Size(width: 10.0, height: 10.0))
        let initialSquareCenter = square.center
        square.center = Point(x: 15.0, y: 15.0)
        print("square.origin is now at (\(square.origin.x), \(square.origin.y))")
        // Prints "square.origin is now at (10.0, 10.0)
    }
}

// 12. Type Properties (类型属性) 类似 static var a:Int , 不过需要给一个默认值
struct SomeStructure {
    static var storedTypeProperty = "Some value."
    // read-only
    static var computedTypeProperty: Int {
        return 1
    }
}
enum SomeEnumeration {
    static var storedTypeProperty = "Some value."
    static var computedTypeProperty: Int {
        return 6
    }
}
class SomeClass {
    static var storedTypeProperty = "Some value."
    static var computedTypeProperty: Int {
        return 27
    }
    // 可以使用 class 关键字进行代替, 方便子类继承
    class var overrideableComputedTypeProperty: Int {
        return 107
    }
}


// 10.1 Shorthand Setter Declaration (Setter中隐式值 newValue)
struct AlternativeRect {
    var origin = Point()
    var size = Size()
    var center: Point {
        get {
            let centerX = origin.x + (size.width / 2)
            let centerY = origin.y + (size.height / 2)
            return Point(x: centerX, y: centerY)
        }
        set {
            origin.x = newValue.x - (size.width / 2)
            origin.y = newValue.y - (size.height / 2)
        }
    }
}

class DataImporter {
    /*
     DataImporter is a class to import data from an external file.
     The class is assumed to take a non-trivial amount of time to initialize.
     */
    var filename = "data.txt"
    // the DataImporter class would provide data importing functionality here
}

class DataManager {
    // 使用 lazy 关键字, 加在 var 关键字之前代表懒加载
    lazy var importer = DataImporter()
    var data = [String]()
    
    func test() {
        
        let manager = DataManager()
        manager.data.append("Some data")
        manager.data.append("Some more data")
        
    }
    
    // the DataManager class would provide data management functionality here
}


// the DataImporter instance for the importer property has not yet been created


class Shape {
    var numberOfSides = 0
    var numberOfSides1 = 0
    func simpleDescription() -> String {
        var a = NamedShape(name: "1")
        var b = NamedShape(name: "2")
        var c = (a === b)
        
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
// 13. Querying and Setting Type Properties (查找和设置类型属性)
struct AudioChannel {
    static let thresholdLevel = 10
    static var maxInputLevelForAllChannels = 0
    var currentLevel: Int = 0 {
        didSet {
            print("didSet")
            if currentLevel > AudioChannel.thresholdLevel {
                // cap the new audio level to the threshold level
                currentLevel = AudioChannel.thresholdLevel
            }
            if currentLevel > AudioChannel.maxInputLevelForAllChannels {
                // store this as the new overall maximum input level
                AudioChannel.maxInputLevelForAllChannels = currentLevel
            }
        }
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
        
        // 13. Querying and Setting Type Properties (查找和设置类型属性)
        // 通过点语法
        print(SomeStructure.storedTypeProperty)
        // Prints "Some value."
        SomeStructure.storedTypeProperty = "Another value."
        print(SomeStructure.storedTypeProperty)
        // Prints "Another value."
        print(SomeEnumeration.computedTypeProperty)
        // Prints "6"
        print(SomeClass.computedTypeProperty)
        // Prints "27”
        
        
    }
    // 析构
    deinit {
        // 对象被清理或者回收时会调用这个函数
    }
    
}
