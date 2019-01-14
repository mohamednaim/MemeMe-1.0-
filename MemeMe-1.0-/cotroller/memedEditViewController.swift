//
//  ViewController.swift
//  MemeMe-1.0-
//
//  Created by mohamed on 1/4/19.
//  Copyright © 2019 mohamed. All rights reserved.
//

import UIKit


class memedEditViewController: UIViewController ,UINavigationControllerDelegate,UIImagePickerControllerDelegate,UITextFieldDelegate{
    var memes:[Meme]{
     return(UIApplication.shared.delegate as! AppDelegate).memes
        
        
        
    }
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var toolBar: UIToolbar!
    @IBOutlet weak var bottomTextField: UITextField!
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var photoLibraryButton: UIBarButtonItem!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    //  let memeTextAttributes:[NSAttributedString.Key.Any]=[
    let memeTextAttributes: [NSAttributedString.Key: Any] = [
        NSAttributedString.Key.strokeColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1),
        NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1),
        
        NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        
        NSAttributedString.Key.strokeWidth: -4.0
        
    ]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        func stylizeTextField(textField:UITextField){
            textField.defaultTextAttributes=memeTextAttributes
            bottomTextField.text="BOttom"
            topTextField.text="TOP"
            textField.textAlignment = .center
            textField.delegate=self
            
        }
        
        stylizeTextField(textField: bottomTextField)
        stylizeTextField(textField: topTextField)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        cameraButton.isEnabled=UIImagePickerController.isSourceTypeAvailable(.camera)
        self.subscipToKeyboardNotication()
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscipToKeyboardNotication()
        
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if bottomTextField.text=="TOP"||topTextField.text=="BOttom"{
            textField.text=""
        }
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
    @ objc func keyboardWillShowNotification(_ notification:Notification){
        if topTextField.isFirstResponder{
            
            view.frame.origin.y = -getKeyboardHeight(notification)
        }
    }
    func getKeyboardHeight(_ notification:Notification) -> CGFloat {
        
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.cgRectValue.height
    }
    
    func subscipToKeyboardNotication(){
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShowNotification(_:)), name:UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHideNotification(_:)), name: UIResponder.keyboardDidHideNotification, object: nil)
        
        
    }
    @objc func keyboardWillHideNotification(_ notification:Notification){
        if bottomTextField.isFirstResponder{
            view.frame.origin.y=0
        }}
    func unsubscipToKeyboardNotication(){
    
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardDidHideNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: self)
    }
    func save(){
        let memedImage = generatmemmedImage()
        let meme = Meme(top: topTextField.text!, bottom: bottomTextField.text!, image: imageView.image, memedImage:memedImage)
        //addanite itemArray To application deleget every memes vcreat add to app delegat
        let appDelegat=UIApplication.shared.delegate as!AppDelegate
        appDelegat.memes.append(meme)
        
        
    }
    func generatmemmedImage()->UIImage{
        // TODO: Hide toolbar and navbar
        navigationBar.isHidden=true
        toolBar.isHidden=true
        // Render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memmedImage:UIImage=UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndPDFContext()
        navigationBar.isHidden = false
        toolBar.isHidden = false
        
        
        
        return memmedImage
    }
    
    @IBAction func imagePicker(_ sender: Any) {
        //this for preent photo from library
        //refrence from
        
        pickImage(sourceType:.photoLibrary)
        
    }
    @IBAction func cameraButtonAction(_ sender: Any)
    {
        pickImage(sourceType:.camera)
        
        
    }
    func pickImage(sourceType: UIImagePickerController.SourceType){
        let imagePiker=UIImagePickerController()
        imagePiker.delegate=self
        
        imagePiker.sourceType = sourceType
        
        
        self.present(imagePiker,animated: true,completion: nil)
        
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image=info[UIImagePickerController.InfoKey.originalImage]as?UIImage
        imageView.image=image
        
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func shareButtonAction(_ sender: Any) {
        let memedImage = generatmemmedImage()
        let activityController = UIActivityViewController(activityItems: [memedImage], applicationActivities: nil)
        activityController.completionWithItemsHandler = { activity, success, items, error in
            if success{
                self.save()
            }
            self.dismiss(animated: true, completion: nil)
        }
        
        present(activityController, animated: true, completion: nil)
        
    }
    @IBAction func cancelButtonAction(_ sender: Any) {
        
        topTextField.text = "TOP"
        bottomTextField.text = "BOTTOM"
        self.imageView.image = nil
        
    }
    
    
    
}
