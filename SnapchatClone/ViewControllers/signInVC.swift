//
//  ViewController.swift
//  SnapchatClone
//
//  Created by Omer Keskin on 17.04.2024.
//

import UIKit
import Firebase
import FirebaseAuth



class signInVC: UIViewController {

    
    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var usernameText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(gestureRecognizer)
    }
    
    @objc func hideKeyboard(){
        view.endEditing(true)}


    @IBAction func signinButtonClicked(_ sender: Any) {
        
        if emailTextfield.text != "" || passwordText.text != ""{
            Auth.auth().signIn(withEmail: emailTextfield.text!, password: passwordText.text!) { (authdata, error) in
                 if error != nil{
                     self.alertFunc(alertTitle: "Error", alertMessage: error?.localizedDescription ?? "Error")
                 }
                 else{
                     self.performSegue(withIdentifier: "toFeedVC", sender: nil)
                }
             }
        }
        else{
            alertFunc(alertTitle: "Sign In Error", alertMessage: "Please fill email and password")
        }
    }
    
    
    @IBAction func signupButtonClicked(_ sender: Any) {
        
        if emailTextfield.text != "" || passwordText.text != "" || usernameText.text != ""{
           Auth.auth().createUser(withEmail: emailTextfield.text!, password: passwordText.text!) { (authdata, error) in
                if error != nil{
                    self.alertFunc(alertTitle: "Error", alertMessage: error?.localizedDescription ?? "Please fill the related fields")
                }
                else{
                    
                    let fireStore = Firestore.firestore()
                    let userDictionary  = ["email": self.emailTextfield.text!, "username": self.usernameText.text!] as [String:Any]
                    fireStore.collection("UserInfo").addDocument(data: userDictionary) { (error) in
                        if error != nil{
                            self.alertFunc(alertTitle: "Error", alertMessage: error?.localizedDescription ?? "Error")
                        }
                    }
                    self.performSegue(withIdentifier: "toFeedVC", sender: nil)
               }
            }
        }
        else{
            alertFunc(alertTitle: "Sign Up Error", alertMessage: "Please fill the related fields")
        }
    }
    
    
    @objc func alertFunc(alertTitle: String, alertMessage: String){
        let warning = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        warning.addAction(okButton)
        self.present(warning, animated: true, completion: nil)
    }
    
    
}


