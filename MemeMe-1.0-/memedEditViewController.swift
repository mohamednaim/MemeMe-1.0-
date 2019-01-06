//
//  ViewController.swift
//  MemeMe-1.0-
//
//  Created by mohamed on 1/4/19.
//  Copyright © 2019 mohamed. All rights reserved.



import UIKit

class memedEditViewController: UIViewController ,UINavigationControllerDelegate,UIImagePickerControllerDelegate,UITextFieldDelegate{
    
    override var prefersStatusBarHidden: Bool{
        return true
    }

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var toolBar: UIToolbar!
    @IBOutlet weak var bottonTextField: UITextField!
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var photoLibraryButton: UIBarButtonItem!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
  //  let memeTextAttributes:[NSAttributedString.Key.Any]=[
    let memeTextAttributes: [NSAttributedString.Key: Any] = [
        NSAttributedString.Key.strokeColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1),
        NSAttributedString.Key.foregroundColor:UIColor.white,
    
        NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        
        NSAttributedString.Key.strokeWidth: -4.0,
      
    ]
    
 
  
    override func viewDidLoad() {
        super.viewDidLoad()
        func stylizeTextField(textField:UITextField){
            textField.defaultTextAttributes=memeTextAttributes
            bottonTextField.text="botton"
        topTextField.text="TOP"
        textField.textAlignment = .center
        textField.delegate=self
            
        }
        
       stylizeTextField(textField: bottonTextField)
        stylizeTextField(textField: topTextField)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        cameraButton.isEnabled=UIImagePickerController.isSourceTypeAvailable(.camera)
        self.subscipToKeyboardNotication()
        self.unsubscipToKeyboardNotication()
    }
 
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if bottonTextField.text=="TOP"||topTextField.text=="BOttom"{
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
        
        
    }
    @objc func keyboardWillHideNotification(_ notification:Notification){
        if topTextField.isFirstResponder{
        view.frame.origin.y=0
        }
        
    }
     func unsubscipToKeyboardNotication(){
       
      NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHideNotification(_:)), name:UIResponder.keyboardWillHideNotification, object: nil)
    }
    func save(){
        let memedImage = generatmemmedImage()
        _ = Meme(top: topTextField.text!, bottom: bottonTextField.text!, image: imageView.image, memedImage:memedImage)
        
        
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
    @IBAction func cameraButtonAction(_ sender: Any) {
       pickImage(sourceType:.camera)
        
    }
    func pickImage(sourceType: UIImagePickerController.SourceType){
        let imagePiker=UIImagePickerController()
        imagePiker.delegate=self
        
        imagePiker.sourceType = sourceType
            
       
        imagePiker.sourceType = .camera
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
            } else {
                //Do nothing
            }
            self.dismiss(animated: true, completion: nil)
        }
        
        present(activityController, animated: true, completion: nil)
        
    }
    @IBAction func cancelButtonAction(_ sender: Any) {
        //self.dismissViewControllerAnimated(true, completion: nil)
        topTextField.text = "TOP"
        bottonTextField.text = "BOTTOM"
        self.imageView.image = nil
    }
    
    
   
}
