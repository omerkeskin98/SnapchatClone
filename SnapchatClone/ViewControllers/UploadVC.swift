//
//  UploadVC.swift
//  SnapchatClone
//
//  Created by Omer Keskin on 18.04.2024.
//

import UIKit
import Firebase
import FirebaseStorage
import FirebaseFirestore

class UploadVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    @IBOutlet weak var uploadImageView: UIImageView!
    @IBOutlet weak var uploadButton: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        
        uploadImageView.isUserInteractionEnabled = true
        let selectImageGesture = UITapGestureRecognizer(target: self, action: #selector(selectImageFromLibrary))
        uploadImageView.addGestureRecognizer(selectImageGesture)
        uploadButton.isEnabled = false
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(gestureRecognizer)
    }
    
    @objc func alertFunc(alertTitle: String, alertMessage: String){
        let warning = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        warning.addAction(okButton)
        self.present(warning, animated: true, completion: nil)
    }
    
    @objc func hideKeyboard(){
        view.endEditing(true)}
    
    @objc func selectImageFromLibrary(){
        
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        // Option to take a photo
        let takePhotoAction = UIAlertAction(title: "Take Photo", style: .default) { _ in
            imagePicker.sourceType = .camera
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
        }
        actionSheet.addAction(takePhotoAction)
        
        // Option to choose from library
        let chooseFromLibraryAction = UIAlertAction(title: "Choose from Library", style: .default) { _ in
            imagePicker.sourceType = .photoLibrary
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
        }
        actionSheet.addAction(chooseFromLibraryAction)
        
        // Cancel action
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        actionSheet.addAction(cancelAction)
        
        present(actionSheet, animated: true, completion: nil)

    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        uploadImageView.image = info[.originalImage] as? UIImage
        uploadButton.isEnabled = true
        self.dismiss(animated: true, completion: nil)

    }

    @IBAction func uploadClicked(_ sender: Any) {
        
        let storage = Storage.storage()
        let storageRef = storage.reference()
        let mediaFolder = storageRef.child("media")
        
        if let data = uploadImageView.image?.jpegData(compressionQuality: 0.1){
            
            let uuid = UUID().uuidString
            let imageRef = mediaFolder.child("\(uuid).jpg")
            imageRef.putData(data, metadata: nil) { (metadata, error) in
                if error != nil{
                    self.alertFunc(alertTitle: "Error", alertMessage: error?.localizedDescription ?? "Error")
                }
                else{
                    
                    imageRef.downloadURL { (url, error) in
                        if error == nil{
                            let imageUrl = url?.absoluteString
    
                            // DATABASE
                            
                            let firestoreDB = Firestore.firestore()
                            
                            firestoreDB.collection("Snaps").whereField("postedBy", isEqualTo: UserSingleton.shareUserInfo.username).getDocuments { (snapshot, error) in
                                if error != nil{
                                    self.alertFunc(alertTitle: "Error", alertMessage: error?.localizedDescription ?? "Error")
                                }
                                else{
                                    if snapshot?.isEmpty == false && snapshot != nil{
                                        for document in snapshot!.documents{
                                            let documentId = document.documentID
                                            
                                            if var imageUrlArray = document.get("imageUrlArray") as? [String]{
                                                imageUrlArray.append(imageUrl!)
                                                
                                                let additionalDict = ["imageUrlArray": imageUrlArray] as [String: Any]
                                                firestoreDB.collection("Snaps").document(documentId).setData(additionalDict, merge: true) { (error) in
                                                    if error == nil{
                                                        self.alertFunc(alertTitle: "Success", alertMessage: "Upload is successful!")
                                                        self.uploadImageView.image = UIImage(named: "upload icon")
                                                        self.tabBarController?.selectedIndex = 0
                                                        
                                                    }
                                                }                                           
                                            }
                                                
                                        }
                                    }
                                    else{
                                        let snapDictionary = ["imageUrlArray" : [imageUrl!], "postedBy" : UserSingleton.shareUserInfo.username, "date" : FieldValue.serverTimestamp()] as [String : Any]
                                        
                                        firestoreDB.collection("Snaps").addDocument(data: snapDictionary, completion: { (error) in
                                            if error != nil{
                                                self.alertFunc(alertTitle: "Error", alertMessage: error?.localizedDescription ?? "Error")
                                            }
                                            else{
                                                
                                                self.alertFunc(alertTitle: "Success", alertMessage: "Upload is successful!")
                                                self.uploadImageView.image = UIImage(named: "upload icon")
                                                self.tabBarController?.selectedIndex = 0
                                                
                                            }
                                        })
                                        
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
}
