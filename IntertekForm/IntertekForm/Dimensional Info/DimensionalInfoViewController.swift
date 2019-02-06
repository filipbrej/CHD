//
//  DimensionalViewController.swift
//  IntertekForm
//
//  Created by Filip Brej on 10/7/18.
//  Copyright © 2018 Intertek. All rights reserved.
//

import UIKit

// Third page of the survey
class DimensionalViewController: UIViewController {
    
    // Picker Views
    @IBOutlet weak var lengthPicker: UIPickerView!
    @IBOutlet weak var widthPicker: UIPickerView!
    @IBOutlet weak var depthPicker: UIPickerView!
    
    // Table Views
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var nextPageButton: UIButton!
    
    var dimensions: Dimensions?
    var objectDescription: ObjectDescription?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        scrollView.keyboardDismissMode = .onDrag
        
        nextPageButton.isEnabled = false
        nextPageButton.layer.backgroundColor = UIColor.lightGray.cgColor
        nextPageButton.layer.cornerRadius = 15
        
        tableView.layer.cornerRadius = 12.0
        tableView.layer.borderWidth = 1.0
        tableView.layer.borderColor = UIColor.black.cgColor
    }
    
    // adds company logo to navigation bar
    func setupNavBar() {
        let navController = navigationController!
        
        navController.navigationBar.barTintColor = UIColor(red: 1.0, green: 0.78, blue: 0.04, alpha: 1)
        navController.navigationBar.tintColor = UIColor.black
        
        let image = UIImage(named: "logo")
        let imageView = UIImageView(image: image)
        
        let bannerWidth = navController.navigationBar.frame.size.width
        let bannerHeight = navController.navigationBar.frame.size.height
        
        let bannerX = bannerWidth / 2 - image!.size.width  / 2
        let bannerY = bannerHeight / 2 - image!.size.height / 2
        
        imageView.frame = CGRect(x: bannerX, y: bannerY, width: bannerWidth, height: bannerHeight)
        imageView.contentMode = .scaleAspectFit
        
        navigationItem.titleView = imageView
    }
}


// Picker View Controller
extension DimensionalViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // returns correct amount of rows for picker views
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        var countRows = Int()
        
        if pickerView == lengthPicker {
            countRows = Dimensions.all.count
        }
        else if pickerView == widthPicker {
            countRows = Dimensions.all.count
        }
        else if pickerView == depthPicker {
            countRows = Dimensions.all.count
        }
        return countRows
    }
    
    // returns correct data for corresponding picker views
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == lengthPicker {
            guard let length = Optional(Dimensions.all[row].length) else { return nil }
            
            return "\(length)"
        }
        else if pickerView == widthPicker {
            guard let width = Optional(Dimensions.all[row].width) else { return nil }
            return "\(width)"
        }
        else if pickerView == depthPicker {
            guard let depth = Optional(Dimensions.all[row].depth) else { return nil }
            return "\(depth)"
        }
        return ""
    }
}


// Table View Controller 
extension DimensionalViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ObjectDescription.all.count
    }
    
    // returns correct data for table view
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = ObjectDescription.all[indexPath.row].description
        cell.tintColor = UIColor(red: 1.0, green: 0.78, blue: 0.04, alpha: 1)
        return cell
    }
    
    // handles table cell selection
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let cell = tableView.cellForRow(at: indexPath) {
            cell.accessoryType = .checkmark
            cell.selectionStyle = .none
            nextPageButton.isEnabled = true
            nextPageButton.layer.backgroundColor = UIColor.blue.cgColor
        }
    }
    
    // handles table cell deselection
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath as IndexPath) {
            cell.accessoryType = .none // gets rid of checkmark when deselected
            cell.selectionStyle = .none
            nextPageButton.isEnabled = false
            nextPageButton.layer.backgroundColor = UIColor.lightGray.cgColor
        }
    }
}
