//
//  DimensionalModel.swift
//  IntertekForm
//
//  Created by Filip Brej on 2/1/19.
//  Copyright © 2019 Intertek. All rights reserved.
//

import Foundation

// Dimension Model
struct Dimensions {
    var length: Int
    var width: Int
    var depth: Int
    
    static var all: [Dimensions] {
        var dimensionsArray = [Dimensions]()
        for nums in 1...100 {
            dimensionsArray.append(Dimensions(length: nums, width: nums, depth: nums))
        }
        return dimensionsArray
    }
}

// Object Model
struct ObjectDescription {
    var description: String
    
    static var all: [ObjectDescription] {
        return [ObjectDescription(description: "One Dimensional (i.e. straight pin)"),
                ObjectDescription(description: "Two Dimensional (i.e. coin)"),
                ObjectDescription(description: "Three Dimensional (i.e. ball)")
        ]
    }
}
