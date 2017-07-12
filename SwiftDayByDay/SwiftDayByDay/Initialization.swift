//
//  Initialization.swift
//  SwiftDayByDay
//
//  Created by caijing on 2017/7/12.
//  Copyright © 2017年 caijing. All rights reserved.
//

import Foundation

class Initialization {
    
    // 1. 默认值属性或者在初始化器中进行进行赋值是不会调用任何属性观察器的
    
    func _initialization() {
        // MARK: 1
        var f = Fahrenheit()
        print("The default temperature is \(f.temperature)° Fahrenheit")
        // MARK: 3.1
        let boilingPointOfWater = Celsius(fromFahrenheit: 212.0)
        // boilingPointOfWater.temperatureInCelsius is 100.0
        let freezingPointOfWater = Celsius(fromKelvin: 273.15)
        // freezingPointOfWater.temperatureInCelsius is 0.0
        
        // MARK: 3.2
        let magenta = Color(red: 1.0, green: 0.0, blue: 1.0)
        let halfGray = Color(w: 2.0)
        // 去掉 argument label
        let bodyTemperature = Celsius(37.0)
        
        // MARK: 3.3
        let cheeseQuestion = SurveyQuestion(text: "Do you like cheese?")
        cheeseQuestion.ask()
        // Prints "Do you like cheese?"
        cheeseQuestion.response = "Yes, I do like cheese."
        
        // MARK: 3.4
        let beetsQuestion = SurveyQuestion(text: "How about beets?")
        beetsQuestion.ask()
        // Prints "How about beets?"
        beetsQuestion.response = "I also like beets. (But not with cheese.)"
        
        // MARK: 3.5
        let basicRect = _Rect()
        // basicRect's origin is (0.0, 0.0) and its size is (0.0, 0.0)
        let originRect = _Rect(origin: _Point(x: 2.0, y: 2.0),
                                 size: _Size(width: 5.0, height: 5.0))
        // originRect's origin is (2.0, 2.0) and its size is (5.0, 5.0)
        let centerRect = _Rect(center: _Point(x: 4.0, y: 4.0),
                                 size: _Size(width: 3.0, height: 3.0))
//        let a = Rect(
        // centerRect's origin is (2.5, 2.5) and its size is (3.0, 3.0)
        
        
    }
    
    init() {
        
        // 在这里执行需要的初始化操作
        
    }
    
}

struct Fahrenheit {
    var temperature: Double
    init() {
        temperature = 32.0
    }
}

// Prints "The default temperature is 32.0° Fahrenheit

// 2. Default Property Value (属性默认值)
// Note: 如果一个属性总是初始化同样的值, 设置属性默认值比在初始化器中设置值更好, 他们的结果是一样的, 但是默认值的声明相对属性的初始化来说连接的更近
// 也对 初始化和初始化继承更友好

struct Fahrenheit1 {
    var temperature = 32.0
}

// 3. Customizing Initalization 自定义初始化

// 3.1 Initalization Parameters 初始化参数

struct Celsius {
    var temperatureInCelsius: Double
    init(fromFahrenheit fahrenheit: Double) {
        temperatureInCelsius = (fahrenheit - 32.0) / 1.8
    }
    init(fromKelvin kelvin: Double) {
        temperatureInCelsius = kelvin - 273.15
    }
    init(_ celsius: Double) {
        temperatureInCelsius = celsius
    }
    
    
}

// 3.2 Parameter Names and Argument Labels 函数参数名和实际调用参数名标签
// 简略描述为：parameter=形参(formal parameter)， argument=实参(actual parameter)。
// 和函数一样也有 parameter 和 argument label
// 初始化器没有验证函数名的功能, 所以在会根据参数来选择性的调用不同的初始化器
// 可以在设置参数标签为 _ 来去掉标签

struct Color {
    let red, green, blue: Double
    init(red: Double, green: Double, blue: Double) {
        self.red   = red
        self.green = green
        self.blue  = blue
    }
    // w: argument, white: parameter
    init(w white: Double) {
        red   = white
        green = white
        blue  = white
    }
}

// 3.3 Optional Property Types 因为某些原因不能及时赋值的自定义属性或其他, 需要设置属性为可选
// 可选属性在初始化时会自动被置为 nil

class SurveyQuestion {
    let text: String
    var response: String?
    init(text: String) {
        self.text = text
    }
    func ask() {
        print(text)
    }
}

// 3.4 Assigning Constant Properties During Initialization 初始化的时候给常量赋值
// 你可以在初始化的时候给常量进行复制操作, 只要在初始化期间被设置了明确的值, 在初始化结束之后就不能被改变了
// NOTE: 对于类实例, 一个常量属性能被改变在初始化期间, 但是不能被子类修改

// 4. Default Initializers
// 如下例 所有属性都有初始值, 并且没有父类, 所以有有默认的初始化器, 但是如果有常量属性的话, 就需要自定义初始化器对常量进行赋值了
class ShoppingListItem {
    var name: String?
    var quantity = 1
    var purchased = false
}
var item = ShoppingListItem()


// 4.1 “Memberwise Initializers for Structure Types” 结构体有讲过, 在此略过
// 4.2 Initializers Delegateion for Values Types
// 初始化其中可以调用其他的初始化器, 这种处理方式被称为 "代理初始化器", 避免写重复的代码

struct _Size {
    var width = 0.0, height = 0.0
}
struct _Point {
    var x = 0.0, y = 0.0
}

struct _Rect {
    // 初始值
    var origin = _Point()
    var size = _Size()
    init() {}
    init(origin: _Point, size: _Size) {
        self.origin = origin
        self.size = size
    }
    init(center: _Point, size: _Size) {
        let originX = center.x - (size.width / 2)
        let originY = center.y - (size.height / 2)
        self.init(origin: _Point(x: originX, y: originY), size: size)
    }
}


// 5. Class Inheritance and Initialization
// 所有的类的储存值的属性包括所有从父类继承来的属性
// Swift 定义了两种初始化器来确保所有的需要储存值的属性都收到一个初始化值
// Designated Initializers and Convenience Initializers (指定的初始化器 和 简便初始化器)
// 略过...
// 1. Designated Initializers
//init(parameters) {
//    statements
//}
// 2. Convenience Intializers
//convenience init(parameters) {
//    statements
//}
// 5.1 类类型的初始化器 delegation 有三个规则
//
//Rule 1 (指定的必须调用父类的指定方法)
//A designated initializer must call a designated initializer from its immediate superclass.
//
//Rule 2 (简便的初始化器必须调用其他的初始化器在同一个类内的)
//A convenience initializer must call another initializer from the same class.
//
//Rule 3 (简便的初始化器最终必须调用指定的初始化器)
//A convenience initializer must ultimately call a designated initializer.
//
//A simple way to remember this is:
//
//Designated initializers must always delegate up.
//Convenience initializers must always delegate across.”






























