//
//  ViewController.swift
//  Image Pick
//
//  Created by Michal Hus on 1/31/20.
//  Copyright © 2020 Michal Hus. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    
    @IBOutlet weak var toolbar: UIToolbar!
    @IBOutlet weak var navigationBar: UIToolbar!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var shareButton: UIBarButtonItem!
    
    let memeTextAttributes: [NSAttributedString.Key: Any] = [
        NSAttributedString.Key.strokeColor: UIColor.black,
        NSAttributedString.Key.foregroundColor: UIColor.white,
        NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        NSAttributedString.Key.strokeWidth: 2.0,
    ]
    
    struct Meme {
        var topText: String?
        var bottomText: String?
        var originalImage: UIImage?
        var memedImage: UIImage
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        enableShareToggle()

        topTextField.sizeToFit()
        topTextField.placeholder = "TOP"
        topTextField.textAlignment = .center
        topTextField.defaultTextAttributes = memeTextAttributes
        topTextField.delegate = self

        bottomTextField.sizeToFit()
        bottomTextField.placeholder = "BOTTOM"
        bottomTextField.textAlignment = .center
        bottomTextField.defaultTextAttributes = memeTextAttributes
        bottomTextField.delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        subscribeToKeyboardNotifications()
        enableShareToggle()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        unsubscribeFromKeyboardNotifications()
        super.viewWillDisappear(animated)
    }

    @IBAction func resetMeMe(_ sender: Any) {
        imageView.image = nil
        topTextField.text = ""
        bottomTextField.text = ""
    }
    
    @IBAction func pickAnImageFromAlbum(_ sender: Any) {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = .photoLibrary
        present(pickerController, animated: true, completion: nil)
    }
    
    @IBAction func pickAnImageFromCamera(_ sender: Any) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .camera

        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            imageView.image = pickedImage
        }
        dismiss(animated: true, completion: nil)
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return true
    }

    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func subscribeToKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    func unsubscribeFromKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
         NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    @objc func keyboardWillShow(_ notification:Notification) {
        if bottomTextField.isEditing{
            view.frame.origin.y = -getKeyboardHeight(notification)
        }
    }

    @objc func keyboardWillHide(_ notification:Notification) {
        view.frame.origin.y = 0.0
    }
    
    func getKeyboardHeight(_ notification:Notification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue
        return keyboardSize.cgRectValue.height
    }
    
    func generateMemedImage() -> UIImage {
        
        // Hide toolbar and navbar
        self.toolbar.isHidden = true
        self.navigationBar.isHidden = true
        
        // Render view to an image
    UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        // Hide toolbar and navbar
        self.toolbar.isHidden = false
        self.navigationBar.isHidden = false
        
        return memedImage
    }
    
    func save() {
        // Create the meme
        _ = Meme(topText: topTextField.text!, bottomText: bottomTextField.text!, originalImage: imageView.image!, memedImage: generateMemedImage())
        UIImageWriteToSavedPhotosAlbum(generateMemedImage(),nil,nil,nil)
    }
    
    func enableShareToggle(){
        if (imageView.image != nil) {
            shareButton.isEnabled = true
        } else{
            shareButton.isEnabled = false
        }
    }
    
    @IBAction func memeShare(_ sender: Any) {
        //generate a memed image
        let memeToShare = [ generateMemedImage() ]

        //define an instance of the ActivityViewController
        //pass the ActivityViewController a memedImage as an activity item
        let activityViewController = UIActivityViewController(activityItems: memeToShare, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view

        //present the ActivityViewController
        self.present(activityViewController, animated: true, completion: nil)

        activityViewController.completionWithItemsHandler = { (activityType: UIActivity.ActivityType?, completed: Bool, returnedItems: [Any]?, error: Error?) -> Void in
            if completed == true {
                self.save()
            }else {
               return
            }
        }
    }
}

