//
//  Country.swift
//  IntertekForm
//
//  Created by Filip Brej on 1/21/19.
//  Copyright © 2019 Intertek. All rights reserved.
//

import Foundation

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
