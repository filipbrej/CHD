//
//  MaterialPropViewController.swift
//  IntertekForm
//
//  Created by Filip Brej on 10/7/18.
//  Copyright © 2018 Intertek. All rights reserved.
//

import UIKit

class MaterialPropViewController: UIViewController {
    
    // Buttons
    @IBOutlet weak var nextPageButton: UIButton!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    // Table Views
    @IBOutlet weak var consistencyTable: UITableView!
    @IBOutlet weak var objectShapeTable: UITableView!
    
    // Picker Views
    @IBOutlet weak var materialPicker: UIPickerView!
    
    
    var material: Material?         // material picker data
    var consistency: Consistency?   // consistency table data
    var objectShape: ObjectShape?   // object shape table data
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        
        nextPageButton.isEnabled = false
        nextPageButton.layer.backgroundColor = UIColor.lightGray.cgColor
        
        scrollView.keyboardDismissMode = .onDrag
        
        nextPageButton.layer.cornerRadius = 15
        
        consistencyTable.layer.borderColor = UIColor.black.cgColor
        consistencyTable.layer.borderWidth = 1.0
        consistencyTable.layer.cornerRadius = 12.0
        
        objectShapeTable.layer.borderColor = UIColor.black.cgColor
        objectShapeTable.layer.borderWidth = 1.0
        objectShapeTable.layer.cornerRadius = 12.0
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

// Table Views Controller
extension MaterialPropViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var countRows = Int()
        
        if tableView == consistencyTable {
            countRows = Consistency.all.count
        }
        else if tableView == objectShapeTable {
            countRows = ObjectShape.all.count
        }
        return countRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        
        if tableView == consistencyTable {
            cell?.textLabel?.text = Consistency.all[indexPath.row].consistency
        }
        else if tableView == objectShapeTable {
            cell?.textLabel?.text = ObjectShape.all[indexPath.row].shape
        }
        cell?.tintColor = UIColor(red: 1.0, green: 0.78, blue: 0.04, alpha: 1)
        return cell!
    }
    
    // handles row selection
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.selectionStyle = .none // gets rid of gray when selecting cell
        
        // only one selection
        if tableView == consistencyTable {
            if let cell = consistencyTable.cellForRow(at: indexPath) {
                cell.accessoryType = .checkmark
                cell.selectionStyle = .none
                nextPageButton.isEnabled = true
                nextPageButton.layer.backgroundColor = UIColor.blue.cgColor
            }
        }
        // multiple selections
        if tableView == objectShapeTable {
            // gets rid of checkmark when tapped, if already present
            if objectShapeTable.cellForRow(at: indexPath)?.accessoryType == .checkmark {
                objectShapeTable.cellForRow(at: indexPath)?.accessoryType = .none
            }
            // adds checkmark to cell when selected
            else {
                objectShapeTable.cellForRow(at: indexPath)?.accessoryType = .checkmark
                nextPageButton.isEnabled = true
                nextPageButton.layer.backgroundColor = UIColor.blue.cgColor
            }
        }
        
    }
    
    // handles row deselection
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if tableView == consistencyTable {
            if let cell = consistencyTable.cellForRow(at: indexPath as IndexPath) {
                cell.accessoryType = .none
                cell.selectionStyle = .none
            }
        }
        if tableView == objectShapeTable {
            objectShapeTable.deselectRow(at: indexPath, animated: true)
            objectShapeTable.cellForRow(at: indexPath)?.selectionStyle = .none // gets rid of gray when deselecting cell
        }
    }
}

// Picker View  Controller
extension MaterialPropViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return Material.all.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return Material.all[row].material
    }
}
