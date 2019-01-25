//
//  Age.swift
//  IntertekForm
//
//  Created by Filip Brej on 1/21/19.
//  Copyright © 2019 Intertek. All rights reserved.
//

import Foundation

struct Age {
    
    var age: String
    
    
    static var all: [Age] {
        var ageArray = [Age]()
        ageArray.append(Age(age: "1 month old"))
        for month in 2...24 {
            ageArray.append(Age(age: "\(month) months old"))
        }
        for year in 3...17 {
            ageArray.append(Age(age: "\(year) years old"))
        }
        return ageArray
    }
    
    
    //                Age(age: "1 month old"),
    //                Age(age: "2 months old"),
    //                Age(age: "3 months old"),
    //                Age(age: "4 months old"),
    //                Age(age: "5 months old"),
    //                Age(age: "6 months old"),
    //                Age(age: "7 months old"),
    //                Age(age: "8 months old"),
    //                Age(age: "9 months old"),
    //                Age(age: "10 months old"),
    //                Age(age: "11 months old"),
    //                Age(age: "12 months old"),
    //                Age(age: "13 months old"),
    //                Age(age: "14 months old"),
    //                Age(age: "15 months old"),
    //                Age(age: "16 months old"),
    //                Age(age: "17 months old"),
    //                Age(age: "18 months old"),
    //                Age(age: "19 months old"),
    //                Age(age: "20 months old"),
    //                Age(age: "21 months old"),
    //                Age(age: "22 months old"),
    //                Age(age: "23 months old"),
    //                Age(age: "24 months old"),
    //                Age(age: "3 years old"),
    //                Age(age: "4 years old"),
    //                Age(age: "5 years old"),
    //                Age(age: "6 years old"),
    //                Age(age: "7 years old"),
    //                Age(age: "8 years old"),
    //                Age(age: "9 years old"),
    //                Age(age: "10 years old"),
    //                Age(age: "11 years old"),
    //                Age(age: "12 years old"),
    //                Age(age: "13 years old"),
    //                Age(age: "14 years old"),
    //                Age(age: "15 years old"),
    //                Age(age: "16 years old"),
    //                Age(age: "17 years old")
    
}
