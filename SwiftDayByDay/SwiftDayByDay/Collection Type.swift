//
//  Collection Type.swift
//  SwiftDayByDay
//
//  Created by caijing on 2017/7/4.
//  Copyright © 2017年 caijing. All rights reserved.
//

import Foundation

class CollectionTypes {
    
    // swift 专门为我们提供了3种主要的 collection, array & set & dictionary
    // variable of collections, 都是 mutable, so you can add or remove object and so on
    // constant 则不能
    func collectionType() {
        

        
    }
    // 字典的 key 必须遵守 Hashable 协议
    func dictionary() {
        // 创建字典
        var namesOfIntegers = [Int: String]()
        namesOfIntegers[1] = "123"
        namesOfIntegers = [:]// 置空 但是依然是 Int: String 类型的字典
        
        // 字面语法的创建字典
        var airports: [String: String] = ["YYZ": "Toronto Pearson", "DUB": "Dublin"]
        
        // 更新某个 key 对应的 value, 如果有旧值就会返回旧值, 不然就会返回 nil
        if let oldValue = airports.updateValue("Dublin Airport", forKey: "DUB") {
            print("The old value for DUB was \(oldValue).")
        }
        
        // Optional binding
        if let airportName = airports["DUB"] {
            print("The name of the airport is \(airportName).")
        } else {
            print("That airport is not in the airports dictionary.")
        }
        
    }
    
    func array() {
        
        var someInts = [Int]() // Int 类型的数组
        print("someInts is of type [Int] with \(someInts.count) items.")
        
        // 创建数组并赋予默认值
        var threeDoubles = Array(repeating: 0.0, count: 3)
        // threeDoubles is of type [Double], and equals [0.0, 0.0, 0.0] 
        
        var shoppingList = ["Eggs", "Milk"]
         print("The shopping list contains \(shoppingList.count) items.")
        // Prints "The shopping list contains 2 items. 
        
         
        
         if shoppingList.isEmpty {
            print("The shopping list is empty.")
        } else {
            print("The shopping list is not empty.")
        } 
        
         
         shoppingList.append("Flour")
        // shoppingList now contains 3 items, and someone is making pancakes 
        
         
        // 这种读取方法很新奇
         shoppingList += ["Baking Powder"]
        // shoppingList now contains 4 items
        shoppingList += ["Chocolate Spread", "Cheese", "Butter"]
        // shoppingList now contains 7 items 
        
          var firstItem = shoppingList[0]
        // firstItem is equal to "Eggs  
        
          shoppingList[0] = "Six eggs"
        
          // 会减少数组中的元素个数, 但是不能通过这种方式单独拼接一个元素在末尾
          shoppingList[4...6] = ["Bananas", "Apples"]
        // shoppingList now contains 6 items  
        
        // 同时打印 index 和 value
        for (index, value) in shoppingList.enumerated() {
            print("Item \(index + 1): \(value)")
        }
        
    }
    
    // 内部类似 NSSet, 同 hashvalue 的不能同时存在一个 Set 中
    
    func set() {
        
        // 与创建数组一样的 字面语法 创建
        var favoriteGenres: Set<String> = ["Rock", "Classical", "Hip hop"]
        // 很棒的 api, 返回的时被 remove 的 object, 如果 object 不存在, 则返回 nil
        if let removedGenre = favoriteGenres.remove("Rock") {
            print("\(removedGenre)? I'm over it.")
        } else {
            print("I never much cared for that.")
        }
        // Prints "Rock? I'm over it.
        // 排序 (默认 (by: <)
        for genre in favoriteGenres.sorted() {
            print("\(genre)")
        }
        
        // 可以执行基本的 集合 操作, 例如并集、交集、差集, 以及去掉公共部分的集合(忘记术语叫什么了...)
        let oddDigits: Set = [1, 3, 5, 7, 9]
        let evenDigits: Set = [0, 2, 4, 6, 8]
        let singleDigitPrimeNumbers: Set = [2, 3, 5, 7]
        
        oddDigits.union(evenDigits).sorted()
        // [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
        oddDigits.intersection(evenDigits).sorted()
        // []
        oddDigits.subtracting(singleDigitPrimeNumbers).sorted()
        // [1, 9]
        oddDigits.symmetricDifference(singleDigitPrimeNumbers).sorted()
        // [1, 2, 9]
        
        // 并且有现实的子集、超集关系 
        let houseAnimals: Set = ["🐶", "🐱"]
        let farmAnimals: Set = ["🐮", "🐔", "🐑", "🐶", "🐱"]
        let cityAnimals: Set = ["🐦", "🐭"]
        
        houseAnimals.isSubset(of: farmAnimals) // 是子集
        // true
        farmAnimals.isSuperset(of: houseAnimals) // 是超集
        // true
        farmAnimals.isDisjoint(with: cityAnimals) // 没交集
        // true
        
    }
}
