//
//  ViewController.swift
//  IntertekForm
//
//  Created by Filip Brej on 9/23/18.
//  Copyright © 2018 Intertek. All rights reserved.
//

import UIKit

class UserInfoViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    // **BUTTONS**
    @IBOutlet weak var nextPageButton: UIButton!
    
    // **TEXT FIELDS**
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var doctorNameField: UITextField!
    @IBOutlet weak var hospitalNameField: UITextField!
    
    // **PICKER VIEWS**
    
    @IBOutlet weak var hospitalCountryPicker: UIPickerView!
    @IBOutlet weak var incidentDatePicker: UIDatePicker!
    @IBOutlet weak var genderPicker: UIPickerView!
    @IBOutlet weak var agePicker: UIPickerView!
    
    
    // **PICKER SETUP BEGINS**
    // gathers country codes to be selected from country picker
    let countries = NSLocale.isoCountryCodes.map { (code:String) -> String in
        let id = NSLocale.localeIdentifier(fromComponents: [NSLocale.Key.countryCode.rawValue: code])
        return NSLocale(localeIdentifier: "en_US").displayName(forKey: NSLocale.Key.identifier, value: id) ?? "Country not found for code: \(code)"
    }
    
    // genders for the gender picker
    let genders = ["Male",
                   "Female"]
    
    // ages for ages picker
    var ages = ["1 month old",
                "2 months old",
                "3 months old",
                "4 months old",
                "5 months old",
                "6 months old",
                "7 months old",
                "8 months old",
                "9 months old",
                "10 months old",
                "11 months old",
                "12 months old",
                "13 months old",
                "14 months old",
                "15 months old",
                "16 months old",
                "17 months old",
                "18 months old",
                "19 months old",
                "20 months old",
                "21 months old",
                "22 months old",
                "23 months old",
                "24 months old",
                "3 years old",
                "4 years old",
                "5 years old",
                "6 years old",
                "7 years old",
                "8 years old",
                "9 years old",
                "10 years old",
                "11 years old",
                "12 years old",
                "13 years old",
                "14 years old",
                "15 years old",
                "16 years old",
                "17 years old"]
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // returns correct amount of rows for each picker
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        var countRows = Int()
        
        if pickerView == hospitalCountryPicker {
            countRows = self.countries.count
            
        } else if pickerView == genderPicker {
            countRows = self.genders.count
            
        } else if pickerView == agePicker {
            countRows = self.ages.count
        }
        return countRows
    }
    
    // returns correct data for picker views
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if pickerView == hospitalCountryPicker {
            return countries[row]
        } else if pickerView == genderPicker {
            return genders[row]
        } else if pickerView == agePicker {
            return ages[row]
        }
        return ""
    }
    // ** END OF PICKER SETUP FUNCTIONS **
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController!.navigationBar.barTintColor = UIColor(red:1.00, green:0.77, blue:0.04, alpha:1.0)
        addLogoTitle()
        
        // sets United States as default selection in picker
        hospitalCountryPicker.selectRow(238, inComponent: 0, animated: true)
        
        // sets age default to 6 months old
        agePicker.selectRow(19, inComponent: 0, animated: true)
        
        // nextPageButton attributes
        nextPageButton.layer.cornerRadius = 15
        
        scrollView.keyboardDismissMode = .onDrag
    }
    
    // adds company logo to navigation title
    func addLogoTitle() {
        
        let navController = navigationController!
        
        let image = UIImage(named: "logo.png")
        let imageView = UIImageView(image: image)
        
        let width = navController.navigationBar.frame.size.width
        let height = navController.navigationBar.frame.size.height
        
        let bannerX = width / 2 - image!.size.width / 2
        let bannerY = height / 2 - image!.size.height / 2
        
        imageView.frame = CGRect(x: bannerX, y: bannerY, width: width, height: height)
        imageView.contentMode = .scaleAspectFit
        
        navigationItem.titleView = imageView
    }
}

