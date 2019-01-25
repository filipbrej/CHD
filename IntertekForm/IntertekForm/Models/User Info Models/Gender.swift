//
//  Gender.swift
//  IntertekForm
//
//  Created by Filip Brej on 1/21/19.
//  Copyright © 2019 Intertek. All rights reserved.
//

import Foundation

struct Gender {
    
    var gender: String
    
    static var all: [Gender] {
        return [Gender(gender: "Male"),
                Gender(gender: "Female")
        ]
    }
}
