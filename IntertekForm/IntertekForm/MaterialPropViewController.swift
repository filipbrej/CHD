//
//  Page4VC.swift
//  IntertekForm
//
//  Created by Filip Brej on 10/7/18.
//  Copyright © 2018 Intertek. All rights reserved.
//

import UIKit

class MaterialPropViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIPickerViewDelegate, UIPickerViewDataSource {
    
    // **BUTTONS**
    @IBOutlet weak var nextPageButton: UIButton!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    // **TABLE VIEWS**
    @IBOutlet weak var consistencyTable: UITableView!
    @IBOutlet weak var objectShapeTable: UITableView!
    
    // **PICKER VIEWS**
    @IBOutlet weak var materialPicker: UIPickerView!
    
    // material picker data
    let materials = ["Wood",
                     "Metal",
                     "Plastic",
                     "Battery",
                     "Textile (Cloth)",
                     "Coated Paper",
                     "Film",
                     "String",
                     "Food",
                     "Other (enter below)"]
    
    // consistency table data
    let consistencies = ["Deformable",
                         "Slightly Deformable",
                         "Rigid"]
    
    // object shape table data
    let objectShapes = ["Pointed",
                        "Round",
                        "Square",
                        "Solid",
                        "With Points",
                        "With Air Spaces"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nextPageButton.isEnabled = false
        nextPageButton.layer.backgroundColor = UIColor.lightGray.cgColor
        
        addLogoTitle()
        
        navigationController!.navigationBar.barTintColor = UIColor(red: 253/255, green: 186/255, blue: 19/255, alpha: 1)
        navigationController!.navigationBar.tintColor = UIColor.black
        
        scrollView.keyboardDismissMode = .onDrag
        
        // nextPageButton attributes
        nextPageButton.layer.cornerRadius = 15
        
        // consistency table attributes
        consistencyTable.layer.borderColor = UIColor.black.cgColor
        consistencyTable.layer.borderWidth = 1.0
        consistencyTable.layer.cornerRadius = 12.0
        
        // object shape table attributes
        objectShapeTable.layer.borderColor = UIColor.black.cgColor
        objectShapeTable.layer.borderWidth = 1.0
        objectShapeTable.layer.cornerRadius = 12.0
    }
    
    
    // **TABLE VIEW SETUP**
    // returns correct amount of rows for table views
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        var countRows = Int()
        if tableView == consistencyTable {
            countRows = consistencies.count
        }
        else if tableView == objectShapeTable {
            countRows = objectShapes.count
        }
        
        return countRows
    }
    
    // returns correct data for table views
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        if tableView == consistencyTable {
            cell?.textLabel?.text = consistencies[indexPath.row]
        } else if tableView == objectShapeTable {
            cell?.textLabel?.text = objectShapes[indexPath.row]
        }
        
        cell?.tintColor = UIColor(red: 253/255, green: 186/255, blue: 19/255, alpha: 1)
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
    // **END OF TABLE VIEW SETUP**
    
    
    // **PICKER VIEW SETUP**
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return materials.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return materials[row]
    }
    // **END OF PICKER VIEW SETUP**
    
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
    
    
}
