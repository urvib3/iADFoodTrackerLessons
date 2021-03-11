//
//  ViewController.swift
//  FoodTracker
//
//  Created by Urvi Bhuwania on 12/17/20.
//

import UIKit
import os.log

class MealViewController: UIViewController, UITextFieldDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    //MARK: Properties
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var ratingControl: RatingControl!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    var meal: Meal?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        nameTextField.delegate = self
     
     // Set up views if editing an existing Meal.
     if let meal = meal {
         navigationItem.title = meal.name
         nameTextField.text   = meal.name
         photoImageView.image = meal.photo
         ratingControl.rating = meal.rating
     }
     // Set up views if editing an existing Meal.
     if let meal = meal {
         navigationItem.title = meal.name
         nameTextField.text   = meal.name
         photoImageView.image = meal.photo
         ratingControl.rating = meal.rating
     }
     
        updateSaveButtonState()
    }

    //MARK: UITextFieldDelegate
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        // Disable the Save button while editing.
        saveButton.isEnabled = false
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        updateSaveButtonState()
        navigationItem.title = textField.text
    }

    // This method lets you configure a view controller before it's presented.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        // Configure the destination view controller only when the save button is pressed.
        guard let button = sender as? UIBarButtonItem, button === saveButton else {
            let name = nameTextField.text ?? ""
            let photo = photoImageView.image
            let rating = ratingControl.rating
            os_log("The save button was not pressed, cancelling", log: OSLog.default, type: .debug)
            return
            
                // Set the meal to be passed to MealTableViewController after the unwind segue.
                meal = Meal(name: name, photo: photo, rating: rating)
        }
    }
    //MARK: Navigation
     @IBAction func cancel(_ sender: UIBarButtonItem) {
         // Depending on style of presentation (modal or push presentation), this view controller needs to be dismissed in two different ways.
         let isPresentingInAddMealMode = presentingViewController is UINavigationController
         
         if isPresentingInAddMealMode {
             dismiss(animated: true, completion: nil)
         }
         else if let owningNavigationController = navigationController{
             owningNavigationController.popViewController(animated: true)
         }
         else {
             fatalError("The MealViewController is not inside a navigation controller.")
         }
     
     }
    
    //MARK: Actions
    
    @IBAction func selectImageFromPhotoLibrary(_ sender: UITapGestureRecognizer) {
        
        // Hide the keyboard
        nameTextField.resignFirstResponder()
        
        // initialize our imagePickerController
        let imagePickerController = UIImagePickerController()
        
        // make our image picker controller full screen
        imagePickerController.modalPresentationStyle = .fullScreen
        
        // photos can only be accessed from photo library
        imagePickerController.sourceType = .photoLibrary
        
        // make sure that view controller gets a notification whenever an image is selected
        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion: nil)
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        // dismiss the image picker controller when user cancels
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        // Xcode 11: UIImagePickerControllerOriginalImage
        guard let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        else {
            fatalError("Expected an image, got the following \(info)")
        }
        
        // set photo image view to selected image
        photoImageView.image = selectedImage
        
        // dismiss image picker controller after image is selected
        dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func setDefaultLabelText(_ sender: UIButton) {
    }
    
    //MARK: Private Methods
    private func updateSaveButtonState() {
        // Disable the Save button if the text field is empty.
        let text = nameTextField.text ?? ""
        saveButton.isEnabled = !text.isEmpty
    }
}

