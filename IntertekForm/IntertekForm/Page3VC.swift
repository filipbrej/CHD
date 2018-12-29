//
//  Page3VC.swift
//  IntertekForm
//
//  Created by Filip Brej on 10/7/18.
//  Copyright © 2018 Intertek. All rights reserved.
//

import UIKit

class Page3VC: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITableViewDelegate, UITableViewDataSource {
    
    // **PICKER VIEWS**
    @IBOutlet weak var lengthPicker: UIPickerView!
    @IBOutlet weak var widthPicker: UIPickerView!
    @IBOutlet weak var depthPicker: UIPickerView!
    
    // **TABLEVIEWS**
    @IBOutlet weak var tableView: UITableView!
    
    
    
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var nextPageButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nextPageButton.isEnabled = false
        nextPageButton.layer.backgroundColor = UIColor.lightGray.cgColor
        
        addLogoTitle()
        navigationController!.navigationBar.barTintColor = UIColor(red: 253/255, green: 186/255, blue: 19/255, alpha: 1)
        navigationController!.navigationBar.tintColor = UIColor.black
        
        scrollView.keyboardDismissMode = .onDrag
        
        nextPageButton.layer.cornerRadius = 15
        
        // tableview attributes
        tableView.layer.cornerRadius = 12.0
        tableView.layer.borderWidth = 1.0
        tableView.layer.borderColor = UIColor.black.cgColor
        
    }
    
    
    // **PICKER VIEW SETUP**
    
    // ranges for picker views
    let lengths = 1...100
    let widths = 1...100
    let depths = 1...100
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // returns correct amount of rows for picker views
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        var countRows = Int()
        
        if pickerView == lengthPicker {
            countRows = self.lengths.count
            
        } else if pickerView == widthPicker {
            countRows = self.widths.count
            
        } else if pickerView == depthPicker {
            countRows = self.depths.count
        }
        return countRows
    }
    
    // returns correct data for corresponding picker views
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        // convert integers in arrays to strings
        var lengthsArray = lengths.map { String($0) }
        var widthsArray = widths.map { String($0) }
        var depthArray = depths.map { String($0) }
        
        if pickerView == lengthPicker {
            return lengthsArray[row]
            
        } else if pickerView == widthPicker {
            return widthsArray[row]
        } else if pickerView == depthPicker {
            return depthArray[row]
        }
        return ""
    }
    // ** END OF PICKER VIEW SETUP **
    
    
    // ** TABLE VIEW SETUP BEGINS **
    let objectDescriptions = ["One Dimensional (i.e. straight pin)",
                              "Two Dimensional (i.e. coin)",
                              "Three Dimesional (i.e. ball)"]
    
    // returns correct amount of rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objectDescriptions.count
    }
    
    // returns correct data for table view
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = objectDescriptions[indexPath.row]
        cell.tintColor = UIColor(red: 253/255, green: 186/255, blue: 19/255, alpha: 1)
        return cell
    }
    
    // puts checkmarks for selected cells
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let cell = tableView.cellForRow(at: indexPath) {
            cell.accessoryType = .checkmark
            cell.selectionStyle = .none
            nextPageButton.isEnabled = true
            nextPageButton.layer.backgroundColor = UIColor.blue.cgColor
        }
    }
    
    // gets rid of checkmarks
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        
        if let cell = tableView.cellForRow(at: indexPath as IndexPath) {
            cell.accessoryType = .none // gets rid of checkmark when deselected
            cell.selectionStyle = .none
            nextPageButton.isEnabled = false
            nextPageButton.layer.backgroundColor = UIColor.lightGray.cgColor
            
        }
    }
    // ** TABLE VIEW SETUP ENDS **
    
    
    
    // adds company logo to navigation title
    func addLogoTitle() {
        
        let navController = navigationController!
        
        let image = UIImage(named: "logo.png")
        let imageView = UIImageView(image: image)
        
        let bannerWidth = navController.navigationBar.frame.size.width
        let bannerHeight = navController.navigationBar.frame.size.height
        
        let bannerX = bannerWidth / 2 - image!.size.width  / 2
        let bannerY = bannerHeight / 2 - image!.size.height / 2
        
        imageView.frame = CGRect(x: bannerX, y: bannerY, width: bannerWidth, height: bannerHeight)
        imageView.contentMode = .scaleAspectFit
        
        navigationItem.titleView = imageView
    }
    //**END OF VIEW SETUP**
}
