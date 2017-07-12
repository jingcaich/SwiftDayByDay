//
//  Inheritance.swift
//  SwiftDayByDay
//
//  Created by caijing on 2017/7/12.
//  Copyright © 2017年 caijing. All rights reserved.
//

import Foundation

class Inheritance {
    
    func inheritance(){
        // MARK: 1
        let someVehicle = Vehicle()
        print("Vehicle: \(someVehicle)")
        // MARK: 2
        let bicycle = Bicycle()
        bicycle.hasBasket = true
        
        // MARK: 5
        let train = Train()
        train.makeNoise()
        
        // MARK: 6
        let car = Car()
        car.currentSpeed = 25.0
        car.gear = 3
        print("Car: \(car.description)")
        // Car: traveling at 25.0 miles per hour in gear 3
        
    }
    
    
}

// 1. 所创建的类不继承自任何父类就是基类
class Vehicle {
    var currentSpeed = 0.0
    var description: String {
        return "traveling at \(currentSpeed) miles per hour"
    }
    func makeNoise() {
        // do nothing - an arbitrary vehicle doesn't necessarily make a noise
    }
}

// 2. Subclassing (子类)

class Bicycle: Vehicle {
    
    var hasBasket = false
    
}

// 3. Overriding (重载) , 我们可以通过加 override 关键字来重载基类的方法、类型方法、实例属性、类属性或者下标 (subscript)
// 4. 可以通过在方法中使用 super 关键字来调用父类的方法 (OC 类型)
// 5. 重载方法

class Train: Vehicle {
    override func makeNoise() {
        print("Choo Choo")
    }
}

// 6. 重载属性 可以自定义属性的 setter & getter 或者 添加 observe
// note: 如果你重载父类的 setter, so 你也必需要写 getter, 可以简单的 return super.someProperty

class Car: Vehicle {
    var gear = 1
    override var description: String {
        return super.description + " in gear \(gear)"
    }
}

// 7. Overriding Property Observers
// note: 你不能观察继承自常量或者只读的属性, 这些都是不能设置值的
// 也不能同时重载 setter 和 Observers ... (似乎很没有必要 ?)

class AutomaticCar: Car {
    override var currentSpeed: Double {
        didSet {
            gear = Int(currentSpeed / 10.0) + 1
        }
    }
}

// 8. Preventing Override 防止被重载 
// 我们可以属性、方法、下标等前面加上 final 关键字, 任何尝试去继承 final 关键字的属性等都会报编译错误
// 如果防止整个类的任何东西被重载 可以在 class 前面加上 final


final class PreventingClass {
    
    
    
}





































