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
        
        // MARK: 5.3
        let vehicle = Vehicle()
        print("Vehicle: \(vehicle.description)")
        let bicycle = _Bicycle()
        print("Bicycle: \(bicycle.description)")
        // Bicycle: 2 wheel(s)
        
        // MARK: 5.5
        let namedMeat = Food(name: "Bacon")
        // namedMeat's name is "Bacon
        let mysteryMeat = Food()
        // mysteryMeat's name is "[Unnamed]
        // 以下三种方法都可以创建 RecipeIngredient 实例
        let oneMysteryItem = RecipeIngredient()
        let oneBacon = RecipeIngredient(name: "Bacon")
        let sixEggs = RecipeIngredient(name: "Eggs", quantity: 6)
        // 也可以以三种方式进行初始化
        let list = _ShoppingListItem()
        let list1 = _ShoppingListItem(name: "123", quantity: 1)
        let list2 = _ShoppingListItem(name: "333")
        
        
        
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
//Convenience initializers must always delegate across.
// 5.2 Two-Phase Initialization 两相初始化 (暂时理解为两个阶段吧)
// 安全检查1
// 一个指定的初始化器必须保证所有被引进的属性在超类初始化之前被初始化
// 安全检查2
// 置顶的初始化器在初始化重载的属性前必须调用超类的初始化器
// 安全检查3
// 简便初始化器必须在给任何属性赋值之前调用其他初始化器
// 安全检查4
// 一个初始化器不能调用任何的实例方法和读任何实例属性的值,或者在第一 阶段之后给self 赋值
// Phase1 (阶段1)
//A designated or convenience initializer is called on a class.
// * 初始化器被类调用
//Memory for a new instance of that class is allocated. The memory is not yet initialized.
// * 为新实例分配了内存, 但是内存没有初始化
//A designated initializer for that class confirms that all stored properties introduced by that class have a value. The memory for these stored properties is now initialized.
// * 类的指定初始化器确认所有被储存属性都会有值, 这些被储存的属性正式被初始化
//The designated initializer hands off to a superclass initializer to perform the same task for its own stored properties.
// * 指定初始化器调用父类的初始化器去执行它自己同样的被储存的属性的任务,
//This continues up the class inheritance chain until the top of the chain is reached.
// * 会继续执行直到继承链的顶端
//Once the top of the chain is reached, and the final class in the chain has ensured that all of its stored properties have a value, the instance’s memory is considered to be fully initialized, and phase 1 is complete.
// * 一旦到了继承链的顶端, 并且最后的类保证所有被储存的属性都有值, 这个实例才会被认为彻底的初始化了, 第一阶段完毕

// Phase 2 (阶段2)
//Working back down from the top of the chain, each designated initializer in the chain has the option to customize the instance further. Initializers are now able to access self and can modify its properties, call its instance methods, and so on.
// *从继承链的顶端开始工作回来, 每个指定的初始化器在继承链中都可以在以后自定义初始化, 初始化器现在可以去访问 self 和修改其他属性并能调用实例方法
//Finally, any convenience initializers in the chain have the option to customize the instance and to work with self.
// * 最终任何在继承链中的简便初始化器都能取自定义实例与 self 一起工作

// 5.3 Initializer Inheritance and Overriding (初始化器与重载)
// NOTE: 总是在重载父类的初始化器时加上 override 修饰符, 即使子类声明的是一个简便初始化器

class _Vehicle {
    var numberOfWheels = 0
    var description: String {
        return "\(numberOfWheels) wheel(s)"
    }
}

class _Bicycle: _Vehicle {
    // 重载父类的制定初始化器 使用 override 修饰符
    override init() {
        super.init()
        numberOfWheels = 2
    }
}

// 5.4 自动初始化继承
// 接上文, 子类默认不会自动继承父类的初始化器
// 1. 你的子类没有任何指定的初始化器
// 2. 如果你的子类实现了所有父类的制定初始化器, 通过集成他们, 或者提供一个自定义的实现作为其定义的一部分，然后它会自动继承父类的简便初始化器

// 5.5 Designated and Convenience Initializers in Action

class Food {
    var name: String
    init(name: String) {
        self.name = name
    }
    convenience init() {
        self.init(name: "[Unnamed]")
    }
}

class RecipeIngredient: Food {
    var quantity: Int
    init(name: String, quantity: Int) {
        self.quantity = quantity
        super.init(name: name)
    }
    override convenience init(name: String) {
        self.init(name: name, quantity: 1)
    }
}

class _ShoppingListItem: RecipeIngredient {
    var purchased = false
    var description: String {
        var output = "\(quantity) x \(name)"
        output += purchased ? " ✔" : " ✘"
        return output
    }
}
// 5.6 Failable Initializers (可失败的初始化器)
// 初始化的时候使用 init? 关键字


struct Animal {
    let species: String
    init?(species: String) {
        // 可以失败
        if species.isEmpty { return nil }
        self.species = species
    }
}

class _FailabelInitializers {
    
    func failable(){
        
        let wholeNumber: Double = 12345.0
        let pi = 3.14159
        
        if let valueMaintained = Int(exactly: wholeNumber) {
            print("\(wholeNumber) conversion to int maintains value")
        }
        // Prints "12345.0 conversion to int maintains value"
        
        let valueChanged = Int(exactly: pi)
        // valueChanged is of type Int?, not Int
        
        if valueChanged == nil {
            print("\(pi) conversion to int does not maintain value")
        }
        func animal(){
            let someCreature = Animal(species: "Giraffe")
            // someCreature is of type Animal?, not Animal
            
            if let giraffe = someCreature {
                print("An animal was initialized with a species of \(giraffe.species)")
            }
            
        }
        
        // 创建可失败的枚举
        let fahrenheitUnit = TemperatureUnit(symbol: "F")
        if fahrenheitUnit != nil {
            print("This is a defined temperature unit, so initialization succeeded.")
        }
        // Prints "This is a defined temperature unit, so initialization succeeded."
        
        let unknownUnit = TemperatureUnit(symbol: "X")
        if unknownUnit == nil {
            print("This is not a defined temperature unit, so initialization failed.")
        }
        // Prints "This is not a defined temperature unit, so initialization failed”
        
        // 可失败的枚举 rowValue
        
        let fahrenheitUnit1 = TemperatureUnit1(rawValue: "F")
        if fahrenheitUnit1 != nil {
            print("This is a defined temperature unit, so initialization succeeded.")
        }
        // Prints "This is a defined temperature unit, so initialization succeeded."
        
        // 对于不存在的 raw value 也会返回 nil 即使并没有显示设置对应的 case
        let unknownUnit1 = TemperatureUnit1(rawValue: "X")
        if unknownUnit1 == nil {
            print("This is not a defined temperature unit, so initialization failed.")
        }
        // Prints "This is not a defined temperature unit, so initialization failed.”
    }
    
}

//Failable Initializers for Enumerations
// 也可以返回可失败的枚举
enum TemperatureUnit {
    case kelvin, celsius, fahrenheit
    init?(symbol: Character) {
        switch symbol {
        case "K":
            self = .kelvin
        case "C":
            self = .celsius
        case "F":
            self = .fahrenheit
        default:
            return nil
        }
    }
}

enum TemperatureUnit1: Character {
    case kelvin = "K", celsius = "C", fahrenheit = "F"
}

// Propagation of Initialization Failure
// 我们的初始化器内部可能是代理了其他的初始化器来进行初始化, 所以也可能代理了可失败的初始化器或者不可失败的初始化器

class Product {
    let name: String
    init?(name: String) {
        if name.isEmpty { return nil }
        self.name = name
    }
}

class CartItem: Product {
    let quantity: Int
    // 必须 quantity 和 name valid
    init?(name: String, quantity: Int) {
        if quantity < 1 { return nil }
        self.quantity = quantity
        super.init(name: name)
    }
}

//Overriding a Failable Initializer
// 我们可以重载某个可失败的初始化器

class Document {
    var name: String?
    // this initializer creates a document with a nil name value
    init() {}
    // this initializer creates a document with a nonempty name value
    init?(name: String) {
        if name.isEmpty { return nil }
        self.name = name
    }
}

class AutomaticallyNamedDocument: Document {
    override init() {
        super.init()
        self.name = "[Untitled]"
    }
    // 用 不可失败初始化 方法重载基类的 failable 方法
    override init(name: String) {
        super.init()
        if name.isEmpty {
            self.name = "[Untitled]"
        } else {
            self.name = name
        }
    }
}

// 你也可以使用强制解包来调用父类的 failable 初始化器来作为自己的 nonfailable 初始化器
class UntitledDocument: Document {
    override init() {
        super.init(name: "[Untitled]")!
    }
}

//The init! Failable Initializer
// 强制解包的 failable 初始化器

// Required Initializer
// 1. 加上 required 关键字, 之后每个子类必须实现这个初始化器
// 2. 子类在实现基类的 required 方法时, 不要写 Override 关键字

// Setting a Default Property Value with a Closure or Function
// 使用闭包或者方法设置属性的默认值

class _SomeClass {
    let someProperty: Int = {
        // create a default value for someProperty inside this closure
        // 闭包中可以创建对应的值
        // someValue must be of the same type as SomeType
        // 返回值必须和属性的类型相同
        
        return 2
    }() // 这里括号告诉 swift 立即去执行这个闭包
}

// 要注意的是使用闭包进行属性初始化, 实例还有没有进行初始化, 并且也不能隐式使用 self property 或者调用其他的实例方法

struct Chessboard {
    // boardColors 这个数组属性就是使用 闭包方法啊进行默认赋值的 (似乎使用懒加载会比较好一点)
    let boardColors: [Bool] = {
        var temporaryBoard = [Bool]()
        var isBlack = false
        for i in 1...8 {
            for j in 1...8 {
                temporaryBoard.append(isBlack)
                isBlack = !isBlack
            }
            isBlack = !isBlack
        }
        return temporaryBoard
    }()
    func squareIsBlackAt(row: Int, column: Int) -> Bool {
        return boardColors[(row * 8) + column]
    }
}














