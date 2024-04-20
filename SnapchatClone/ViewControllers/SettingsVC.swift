//
//  SettingsVC.swift
//  SnapchatClone
//
//  Created by Omer Keskin on 18.04.2024.
//

import UIKit
import Firebase

class SettingsVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func logoutClicked(_ sender: Any) {
        
        do{
            try Auth.auth().signOut()
            performSegue(withIdentifier: "toSignInVC", sender: nil)
        }catch{
            print("Signout error")
        }
    }
    

}
