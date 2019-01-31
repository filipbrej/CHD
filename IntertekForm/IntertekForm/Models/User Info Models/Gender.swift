//
//  Gender.swift
//  IntertekForm
//
//  Created by Filip Brej on 1/21/19.
//  Copyright © 2019 Intertek. All rights reserved.
//

import Foundation

enum Gender: Int, CaseIterable {
    case male
    case female
    static var count: Int { return Gender.female.hashValue + 1 }
    
    var gender: String {
        switch self {
        case .male:
            return "Male"
        case .female:
            return "Female"
        }
    }
}
