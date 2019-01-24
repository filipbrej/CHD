//
//  Page2VC.swift
//  IntertekForm
//
//  Created by Filip Brej on 9/30/18.
//  Copyright © 2018 Intertek. All rights reserved.
//

import UIKit

class GeneralObjectViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource, UITextFieldDelegate {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var nextPageButton: UIButton!
    
    //required fields
    @IBOutlet weak var objectTextField: UITextField!
    @IBOutlet weak var optionsTableView: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var otherTextField: UITextField! // only needs value if collectionview has no selection
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // adds company logo to navigation bar
        addLogoTitle()
        
        // changes color of nav bar
        navigationController!.navigationBar.barTintColor = UIColor(red: 253/255, green: 186/255, blue: 19/255, alpha: 1)
        navigationController!.navigationBar.tintColor = UIColor.black
        
        // nextPageButton attributes
        nextPageButton.layer.cornerRadius = 15
        scrollView.keyboardDismissMode = .onDrag
        
        // table view attributes
        optionsTableView.layer.borderColor = UIColor.black.cgColor
        optionsTableView.layer.borderWidth = 1.0
        optionsTableView.layer.cornerRadius = 12.0
        
        
        objectTextField.delegate = self
        shapesCollectionView.delegate = self
        
        if objectTextField.text?.isEmpty == true {
            nextPageButton.isEnabled = false
            nextPageButton.layer.backgroundColor = UIColor.lightGray.cgColor
        } else if objectTextField.text?.isEmpty == false {
            nextPageButton.isEnabled = true
            nextPageButton.layer.backgroundColor = UIColor.blue.cgColor
        }
        
    }
    
    
    
    // options for table view cells
    let canBeShippedOptions = ["Yes", "No"]
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return canBeShippedOptions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = canBeShippedOptions[indexPath.row]
        cell.tintColor = UIColor(red: 253/255, green: 186/255, blue: 19/255, alpha: 1)
        
        return cell
    }
    
    // puts checkmarks for selected cells
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let currentCell = optionsTableView.cellForRow(at: indexPath)
        currentCell?.accessoryType = .checkmark
        currentCell?.selectionStyle = .none
        nextPageButton.isEnabled = true
        nextPageButton.layer.backgroundColor = UIColor.blue.cgColor
        
    }
    
    // deselects cell
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        
        let currentCell = optionsTableView.cellForRow(at: indexPath)
        currentCell?.accessoryType = .none
        
        let selectedRows = tableView.indexPathsForSelectedRows as [NSIndexPath]?
        if selectedRows == nil {
            nextPageButton.isEnabled = false
            nextPageButton.layer.backgroundColor = UIColor.lightGray.cgColor
        }
        
        
    }
    //  **END OF TABLE VIEW SETUP**
    
    
    
    
    //**COLLECTION VIEW SETUP**
    @IBOutlet weak var shapesCollectionView: UICollectionView!
    
    // shapes for image view in collection view
    let shapesArray: [String] = ["cube",
                                 "sphere",
                                 "hollow-cylinder",
                                 "needle",
                                 "cuboid",
                                 "hemisphere",
                                 "tweezer",
                                 "raindrop",
                                 "ring",
                                 "star",
                                 "pyramid",
                                 "egg",
                                 "coin",
                                 "peg",
                                 "cell-battery",
                                 "other"]
    
    // names of shapes to display imaages of shapes in collection view cells
    let shapeNames: [String] = ["Cube",
                                "Sphere",
                                "Hollow Cylinder",
                                "Needle", "Cuboid",
                                "Hemisphere",
                                "Tweezer",
                                "Raindrop",
                                "Ring",
                                "Star",
                                "Pyramid",
                                "Egg",
                                "Coin",
                                "Peg",
                                "Cell Battery",
                                "(enter below)"]
    
    // returns correct amount of cells
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return shapesArray.count
    }
    
    // sets content inside of collection cells
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = shapesCollectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ShapeCell
        cell.shapeImageView.image = UIImage(named: shapesArray[indexPath.row] + ".png")
        cell.shapeLabel.text = shapeNames[indexPath.row]
        cell.shapeLabel.textAlignment = .center
        
        return cell
    }
    
    // deselects collection cell when tapped a second time
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        
        let item = collectionView.cellForItem(at: indexPath)
        if item?.isSelected ?? false {
            collectionView.deselectItem(at: indexPath, animated: true)
            nextPageButton.isEnabled = false
            nextPageButton.layer.backgroundColor = UIColor.lightGray.cgColor
            
        } else {
            collectionView.selectItem(at: indexPath, animated: true, scrollPosition: [])
            nextPageButton.isEnabled = true
            nextPageButton.layer.backgroundColor = UIColor.blue.cgColor
        }
        return false
    }
    
    // **END OF COLLECTION VIEW SETUP
    
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
    
    //disables next page button if text field is empty
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let text = (objectTextField.text! as NSString).replacingCharacters(in: range, with: string)
        
        if !text.isEmpty {
            nextPageButton.isEnabled = true
            nextPageButton.layer.backgroundColor = UIColor.blue.cgColor
        } else {
            nextPageButton.isEnabled = false
            nextPageButton.layer.backgroundColor = UIColor.lightGray.cgColor
        }
        
        return true
    }
}
