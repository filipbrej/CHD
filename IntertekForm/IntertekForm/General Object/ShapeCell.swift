//
//  ShapeCell.swift
//  IntertekForm
//
//  Created by Filip Brej on 10/21/18.
//  Copyright © 2018 Intertek. All rights reserved.
//

import UIKit

class ShapeCell: UICollectionViewCell {
    
    @IBOutlet weak var shapeImageView: UIImageView!
    @IBOutlet weak var shapeLabel: UILabel!
    
    // prevents multiple cells being selected
    override var isSelected: Bool {
        didSet {
            if self.isSelected {
                self.layer.backgroundColor =  UIColor(red: 253/255, green: 186/255, blue: 19/255, alpha: 1 ).cgColor
            }
            else {
                self.layer.backgroundColor =  UIColor.white.cgColor
            }
        }
    }
}
