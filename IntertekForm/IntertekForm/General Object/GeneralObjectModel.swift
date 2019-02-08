//
//  GeneralObjectModel.swift
//  IntertekForm
//
//  Created by Filip Brej on 2/1/19.
//  Copyright © 2019 Intertek. All rights reserved.
//

import Foundation

// Shipping Options Model
struct ShippingOptions {
    
    var option: String
    
    static var all: [ShippingOptions] {
        return [ShippingOptions(option: "Yes"),
                ShippingOptions(option: "No")
        ]
    }
}

// Shape Cell Model
struct Shape {
    
    var image: String
    var name: String
    
    static var all: [Shape] {
        return [Shape(image: "cube", name: "Cube"),
                Shape(image: "sphere", name: "Sphere"),
                Shape(image: "hollow-cylinder", name: "Hollow Cylinder"),
                Shape(image: "needle", name: "Needle"),
                Shape(image: "cuboid", name: "Cuboid"),
                Shape(image: "hemisphere", name: "Hemisphere"),
                Shape(image: "tweezer", name: "Tweezer"),
                Shape(image: "raindrop", name: "Raindrop"),
                Shape(image: "ring", name: "Ring"),
                Shape(image: "star", name: "Star"),
                Shape(image: "pyramid", name: "Pyramid"),
                Shape(image: "egg", name: "Egg"),
                Shape(image: "coin", name: "Coin"),
                Shape(image: "peg", name: "Peg"),
                Shape(image: "cell-battery", name: "Cell Battery"),
                Shape(image: "other", name: "(enter below)")
        ]
    }
}
