//
//  Consistency.swift
//  IntertekForm
//
//  Created by Filip Brej on 1/25/19.
//  Copyright © 2019 Intertek. All rights reserved.
//

import Foundation

// Consistency Model
struct Consistency {
    var consistency: String
    
    static var all: [Consistency] {
        return [Consistency(consistency: "Deformable"),
                Consistency(consistency: "Slightly Deformable"),
                Consistency(consistency: "Rigid")
        ]
    }
}

// Material Model
struct Material {
    var material: String
    
    static var all: [Material] {
        return [Material(material: "Wood"),
                Material(material: "Metal"),
                Material(material: "Plastic"),
                Material(material: "Battery"),
                Material(material: "Textile (Cloth)"),
                Material(material: "Coated Paper"),
                Material(material: "Film"),
                Material(material: "String"),
                Material(material: "Food"),
                Material(material: "Other (enter below)")
        ]
    }
}

// Object Shape Model
struct ObjectShape {
    var shape: String
    
    static var all: [ObjectShape] {
        return [ObjectShape(shape: "Pointed"),
                ObjectShape(shape: "Round"),
                ObjectShape(shape: "Square"),
                ObjectShape(shape: "Solid"),
                ObjectShape(shape: "With Points"),
                ObjectShape(shape: "With Air Spaces"),
        ]
    }
}
