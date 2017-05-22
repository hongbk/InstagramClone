//
//  UploadPhotoViewController.swift
//  InstagramClone
//
//  Created by Nguyễn Hồng on 5/21/17.
//  Copyright © 2017 iossimple. All rights reserved.
//

import UIKit
import Alamofire

class UploadPhotoViewController: UIViewController  {

    @IBOutlet weak var imageUpload: UIImageView!
    
    @IBOutlet weak var tiltleTF: UITextField!
    
    @IBOutlet weak var descriptionTF: UITextField!
    
    @IBOutlet weak var chooseImageFromLibraryButton: UIButton!
    
    var imageUrl: URL?
    
    @IBOutlet weak var uploadButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func chooseImageFromLibraryButtonWasTapped(_ sender: UIButton) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.photoLibrary) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    
    @IBAction func uploadButtonWasTapped(_ sender: UIButton) {
        
        guard imageUrl != nil else{
            Utitlities.showAlert(alert: "Alert", message: "Bạn chưa chọn ảnh", vc: self)
            return
        }
        guard tiltleTF.text != nil else {
            Utitlities.showAlert(alert: "Alert", message: "Bạn hãy nhập chủ đề", vc: self)
            return
        }
        
        APIManagers.shareManager.uploadPhoto(endPoint: APIManagers.APIEndPoint.kPhotos, imageData: self.imageUrl!,
            title: tiltleTF.text!, description: descriptionTF.text, tagList: nil,
            completeHandler: {[unowned self](result, resultCode, json) in
            
            if (result) {
                print(json)
            }
        })
    }
}

extension UploadPhotoViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        guard let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage else {
            return
        }
        
        imageUpload.contentMode = .scaleAspectFit
        imageUpload.image = pickedImage
        
        if let data = UIImageJPEGRepresentation(pickedImage, 1) {
            let fileUrl = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent("image.jpg")
            do {
                try data.write(to: fileUrl, options: .atomic)
            } catch{
                print(error)
            }
            imageUrl = fileUrl
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}
