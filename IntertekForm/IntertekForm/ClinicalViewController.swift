//
//  Page5VC.swift
//  IntertekForm
//
//  Created by Filip Brej on 10/9/18.
//  Copyright © 2018 Intertek. All rights reserved.
//

import UIKit
import Speech
import AVFoundation

// cases for microphone status
enum SpeechStatus {
    case ready
    case recognizing
    case unavailable
}


class ClinicalViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITableViewDataSource, UITableViewDelegate, UITextViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var status = SpeechStatus.ready // ready to record audio
    
    // process the audio stream
    let audioEngine = AVAudioEngine()
    
    // does the speech recognition
    let speechRecognizer: SFSpeechRecognizer? = SFSpeechRecognizer()
    
    // allocates speech in real time
    let request = SFSpeechAudioBufferRecognitionRequest()
    
    // manages, cancels, or stops current recognition task
    var recognitionTask: SFSpeechRecognitionTask?
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    // **PICKER VIEWS**
    @IBOutlet weak var locationPickerView: UIPickerView!
    @IBOutlet weak var symptomsPickerView: UIPickerView!
    
    // **TABLE VIEWS**
    @IBOutlet weak var objectRemovalTableView: UITableView!
    @IBOutlet weak var impairmentsTableView: UITableView!
    
    // **BUTTONS**
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var uploadImageButton: UIButton!
    @IBOutlet weak var submitButton: UIButton!
    
    
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var selectedImage: UIImageView!
    
    // locations of object, for picker view
    let locations = ["Trachea",
                     "Right Bronchus",
                     "Left Bronchus",
                     "Right Lower Lung",
                     "Left Lower Lung",
                     "Oral Cavity",
                     "Nose",
                     "Nasopharynx",
                     "Larynx",
                     "Hypopharynx",
                     "Esophagus",
                     "Stomach",
                     "Bowel",
                     "Rectum"]
    
    let objectRemovalList = ["Spontaneous",
                             "After Surgical Intervention",
                             "Remained in Patient",
                             "Foley Manipulation",
                             "Unknown"]
    
    let symptoms = ["None",
                    "Mild",
                    "Moderate",
                    "Severe",
                    "In Extremis"]
    
    let impairments = ["No",
                       "Neurologically impaired",
                       "Mentally impaired",
                       "Physically impaired"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        submitButton.isEnabled = false
        submitButton.layer.backgroundColor = UIColor.lightGray.cgColor
        
        addLogoTitle()
        selectedImage.image = UIImage(named: "imageview-bg.png")
        selectedImage.contentMode = .scaleAspectFill
        // sets navigation bar color
        navigationController!.navigationBar.barTintColor = UIColor(red: 253/255, green: 186/255, blue: 19/255, alpha: 1)
        navigationController!.navigationBar.tintColor = UIColor.black
        
        // dismisses keyboard when user scrolls
        scrollView.keyboardDismissMode = .onDrag
        
        // button attributes
        submitButton.layer.cornerRadius = 15.0
        uploadImageButton.layer.cornerRadius = 15.0
        recordButton.layer.cornerRadius = 15.0
        
        // textview attributes
        textView.layer.borderColor = UIColor.black.cgColor
        textView.layer.borderWidth = 1.0
        textView.layer.cornerRadius = 12.0
        
        // object table attributes
        objectRemovalTableView.layer.borderColor = UIColor.black.cgColor
        objectRemovalTableView.layer.borderWidth = 1.0
        objectRemovalTableView.layer.cornerRadius = 12.0
        
        // impairments table attributes
        impairmentsTableView.layer.borderColor = UIColor.black.cgColor
        impairmentsTableView.layer.borderWidth = 1.0
        impairmentsTableView.layer.cornerRadius = 12.0
        
        SFSpeechRecognizer.requestAuthorization {
            [unowned self] (authStatus) in
            switch authStatus {
                
            case .authorized:
                self.recordButton.isEnabled = true
                
            case .denied:
                self.recordButton.backgroundColor = UIColor.lightGray
                self.status = .unavailable
                
            case .restricted:
                self.recordButton.backgroundColor = UIColor.lightGray
                self.status = .unavailable
                
                
            case .notDetermined:
                self.recordButton.backgroundColor = UIColor.lightGray
                self.status = .unavailable
                
            }
        }
        
    }
    
    
    // handles recording when button is first pressed
    @IBAction func recordButtonTapped(_ sender: UIButton) {
        
        SFSpeechRecognizer.requestAuthorization {
            [unowned self] (authStatus) in
            switch authStatus {
                
            case .authorized:
                sender.isEnabled = true // button is enabled if speech recognition permission granted
                
            case .denied: // speech permission denied, button is disabled
                self.status = .unavailable
                sender.backgroundColor = UIColor.lightGray
                
            case .restricted: // device has no microphone
                self.status = .unavailable
                self.recordButton.backgroundColor = UIColor.lightGray
                
            case .notDetermined: // authorization not yet set
                self.status = .unavailable
                sender.backgroundColor = UIColor.lightGray
                
            }
        }
        
        switch self.status {
        // button is ready for recording and will begin when pressed
        case .ready:
            sender.setTitle("Recording", for: .normal)
            do {
                try self.startRecording()
            } catch let error {
                print("There was a problem starting recording: \(error.localizedDescription)")
            }
            self.status = .recognizing
            
        // button will stop recording when pressed
        case .recognizing:
            stopRecording()
            self.status = .ready
            sender.setTitle("Record", for: .normal)
            
        // pressing button will dispaly message to user to enable speech in settings
        case .unavailable:
            let ac = UIAlertController(title: "Microphone usage not enabled.", message: "Please enable Microphone usage and Speech in settings.", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(ac, animated: true)
        }
        
    }
    
    // handles photos being uploaded
    @IBAction func uploadPhotoTapped(_ sender: UIButton) {
        
        // displays alert for user to pick camera or photo album
        let alert = UIAlertController(title: "Choose Image", message: nil, preferredStyle: .actionSheet)
        
        // opens camera if tapped
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { _ in
            self.openCamera()
        }))
        
        // opens gallery if tapped
        alert.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { _ in
            self.openGallery()
        }))
        
        // cancels action
        alert.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
        
    }
    
    // handles opening the camera
    func openCamera() {
        
        if AVCaptureDevice.authorizationStatus(for: .video) == .authorized {
            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera) {
                let imagePicker = UIImagePickerController()
                imagePicker.delegate = self
                imagePicker.sourceType = UIImagePickerController.SourceType.camera
                imagePicker.allowsEditing = false
                self.present(imagePicker, animated: true, completion: nil)
                uploadImageButton.isUserInteractionEnabled = true
                
            }
        }
            
        else
        {
            let alert  = UIAlertController(title: "Camera Disabled in Settings", message: "Enable camera in privacy settings.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            
            // lets user go to settings to switch on permission directly from app
            let settingsAction = UIAlertAction(title: "Go to Settings...", style: .default) { (_) -> Void in
                let settingsUrl = NSURL(string: UIApplication.openSettingsURLString)
                UIApplication.shared.open(settingsUrl! as URL, options: [:], completionHandler: nil)
            }
            alert.addAction(settingsAction)
            
            self.present(alert, animated: true, completion: nil)
            uploadImageButton.backgroundColor = UIColor.lightGray
            uploadImageButton.isUserInteractionEnabled = false
        }
    }
    
    // handles opening camera gallery if selected
    func openGallery() {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.photoLibrary) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.allowsEditing = false
            imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
            self.present(imagePicker, animated: true, completion: nil)
        }
            
            
        else
        {
            let alert  = UIAlertController(title: "Warning", message: "You don't have perission to access gallery.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    // assigns image to UIImageview
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            selectedImage.contentMode = .scaleToFill
            selectedImage.image = pickedImage
        }
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    
    
    
    // handles speech recognition
    func startRecording() throws {
        
        let node = audioEngine.inputNode
        let recordingFormat = node.outputFormat(forBus: 0)
        
        
        node.installTap(onBus: 0, bufferSize: 1024,
                        format: recordingFormat) { [unowned self]
                            (buffer, _) in
                            self.request.append(buffer)
        }
        
        
        audioEngine.prepare()
        try audioEngine.start()
        
        recognitionTask = speechRecognizer?.recognitionTask(with: request) {
            [unowned self]
            (result, _) in
            if let transcription = result?.bestTranscription {
                self.textView.text = transcription.formattedString
            }
        }
        
    }
    
    // stops recording when record button is tapped
    func stopRecording() {
        audioEngine.stop()
        request.endAudio()
        audioEngine.inputNode.removeTap(onBus: 0)
        recognitionTask?.cancel()
    }
    
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
    
    // **TABLE VIEW SETUP BEGINS**
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        var countRows = Int()
        if tableView == objectRemovalTableView {
            countRows = objectRemovalList.count
        }
        else if tableView == impairmentsTableView {
            countRows = impairments.count
        }
        return countRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        
        if tableView == objectRemovalTableView {
            cell?.textLabel?.text = objectRemovalList[indexPath.row]
        }
        else if tableView == impairmentsTableView {
            cell?.textLabel?.text = impairments[indexPath.row]
        }
        
        cell?.tintColor = UIColor(red: 253/255, green: 186/255, blue: 19/255, alpha: 1)
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // object removal one selection
        if tableView == objectRemovalTableView {
            if let cell = objectRemovalTableView.cellForRow(at: indexPath) {
                cell.accessoryType = .checkmark
                cell.selectionStyle = .none
                submitButton.isEnabled = true
                submitButton.layer.backgroundColor = UIColor.blue.cgColor
            }
        }
        
        // impairments table multiple selection
        if tableView == impairmentsTableView {
            if impairmentsTableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
                impairmentsTableView.cellForRow(at: indexPath)?.accessoryType = .none
            }
            else {
                impairmentsTableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
                submitButton.isEnabled = true
                submitButton.layer.backgroundColor = UIColor.blue.cgColor
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        
        if tableView == objectRemovalTableView {
            if let cell = objectRemovalTableView.cellForRow(at: indexPath as IndexPath) {
                cell.accessoryType = .none
                cell.selectionStyle = .none
            }
        }
        
        if tableView == impairmentsTableView {
            impairmentsTableView.deselectRow(at: indexPath, animated: true)
            impairmentsTableView.cellForRow(at: indexPath)?.selectionStyle = .none
        }
    }
    // **END OF TABLEVIEW SETUP**
    
    
    // **PICKERVIEW SETUP BEGINS**
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        var countRows = Int()
        if pickerView == locationPickerView {
            countRows = locations.count
        }
        else if pickerView == symptomsPickerView {
            countRows = symptoms.count
        }
        
        return countRows
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        var titleRow = String()
        if pickerView == locationPickerView {
            titleRow = locations[row]
        }
        else if pickerView == symptomsPickerView {
            titleRow = symptoms[row]
        }
        
        return titleRow
    }
    // **END OF PICKERVIEW SETUP**
    
    
    
    
    
}

