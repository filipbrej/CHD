//
//  UserModel.swift
//  IntertekForm
//
//  Created by Filip Brej on 1/21/19.
//  Copyright © 2019 Intertek. All rights reserved.
//

import Foundation

// Country model
struct Country {
    var country: String
    
    static var all: [Country] {
        var countryArray = [Country]()
        for code in NSLocale.isoCountryCodes as [String] {
            let id = NSLocale.localeIdentifier(fromComponents: [NSLocale.Key.countryCode.rawValue: code])
            let name = NSLocale(localeIdentifier: "en_US").displayName(forKey: NSLocale.Key.identifier, value: id) ?? "Country not found for code \(code)"
            countryArray.append(Country(country: name))
        }
        return countryArray
    }
}

// Age model
struct Age {
    var ageMonths: Int
    
    static var all: [Age] {
        var ageArray = [Age]()
        for months in 1...24 { // adds months 1 through 24
            ageArray.append(Age(ageMonths: months))
        }
        for months in Array(stride(from: 36, through: 204, by: 12)) { // adds years 3 through 17
            ageArray.append(Age(ageMonths: months))
        }
        return ageArray
    }
}

// Gender model
enum Gender: Int, CaseIterable {
    case male
    case female
    
    var gender: String {
        switch self {
        case .male:
            return "Male"
        case .female:
            return "Female"
        }
    }
}


