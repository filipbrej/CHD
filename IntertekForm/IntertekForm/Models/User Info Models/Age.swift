//
//  Age.swift
//  IntertekForm
//
//  Created by Filip Brej on 1/21/19.
//  Copyright © 2019 Intertek. All rights reserved.
//

import Foundation

struct Age {
    var ageMonths: String
    
    static var all: [Age] {
        var ageArray = [Age]()
        for months in 1...24 { // adds months 1 through 24
            ageArray.append(Age(ageMonths: String(months)))
        }
        for months in Array(stride(from: 36, through: 204, by: 12)) { // adds years 3 through 17
            ageArray.append(Age(ageMonths: String(months)))
        }
        return ageArray
    }
}
