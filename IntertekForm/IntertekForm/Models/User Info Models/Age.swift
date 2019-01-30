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
}
