//
//  UserInfoViewController.swift
//  IntertekForm
//
//  Created by Filip Brej on 9/23/18.
//  Copyright © 2018 Intertek. All rights reserved.
//

import UIKit

class UserInfoViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    // Buttons
    @IBOutlet weak var nextPageButton: UIButton!
    
    // Text fields
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var doctorNameField: UITextField!
    @IBOutlet weak var hospitalNameField: UITextField!
    
    // Picker Views
    @IBOutlet weak var hospitalCountryPicker: UIPickerView!
    @IBOutlet weak var incidentDatePicker: UIDatePicker!
    @IBOutlet weak var genderPicker: UIPickerView!
    @IBOutlet weak var agePicker: UIPickerView!
    
    var age: Age?           // ages for age picker
    var gender: Gender?     // genders for gender picker
    var country: Country?   // countries for country picker
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        
        // sets United States as default selection in picker
        hospitalCountryPicker.selectRow(238, inComponent: 0, animated: true)
        
        // sets age default to 6 months old
        agePicker.selectRow(23, inComponent: 0, animated: true)
        
        // nextPageButton attributes
        nextPageButton.layer.cornerRadius = 15
        
        scrollView.keyboardDismissMode = .onDrag
    }
    
    // adds company logo to navigation bar
    func setupNavBar() {
        let navController = navigationController!
        navController.navigationBar.barTintColor = UIColor(red: 1.0, green: 0.78, blue: 0.04, alpha: 1)
        
        let image = UIImage(named: "logo")
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


// MARK: - Picker View Controller
extension UserInfoViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // returns correct amount of rows for each picker
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        var countRows = Int()
        
        if pickerView == hospitalCountryPicker {
            countRows = Country.all.count
        } else if pickerView == genderPicker {
            countRows = Gender.allCases.count
        } else if pickerView == agePicker {
            countRows = Age.all.count
        }
        return countRows
    }
    
    // returns correct data for picker views
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == hospitalCountryPicker {
            return Country.all[row].country
        }
        else if pickerView == genderPicker {
            return Gender.allCases[row].gender
        }
        else if pickerView == agePicker {
            guard let age = Optional(Age.all[row].ageMonths) else { return nil }
            
            switch age {
            case 1:
                return "\(age) month old"
            case 2..<36:
                return "\(age) months old"
            default:
                return "\(Int(floor(Double(age)/12))) years old"
            }
        }
        return ""
    }
}
