//
//  RecordingButtonAnimation.swift
//  IntertekForm
//
//  Created by Filip Brej on 11/4/18.
//  Copyright © 2018 Intertek. All rights reserved.
//

import Foundation
import UIKit

// TODO: - Make button animate by flashing while recording audio
extension UIButton {
    
    // makes button blink when audio is being recorded
    func flash() {
        let flash = CABasicAnimation(keyPath: "opacity")
        flash.fromValue = 1
        flash.toValue = 0.1
        flash.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        flash.autoreverses = true
        flash.duration = 0.5
        
        layer.add(flash, forKey: nil)
    }
    
}
