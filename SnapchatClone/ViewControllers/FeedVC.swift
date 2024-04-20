//
//  FeedVC.swift
//  SnapchatClone
//
//  Created by Omer Keskin on 18.04.2024.
//

import UIKit
import Firebase
import SDWebImage

class FeedVC: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    
    @IBOutlet weak var feedTableview: UITableView!
    let firestoreDB = Firestore.firestore()
    var snapArray = [Snap]()
    var chosenSnap : Snap?
  //  var timeLeft: Int?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        feedTableview.delegate = self
        feedTableview.dataSource = self

        getSnapsFromFirebase()
        getUserInfo()
        
    }
    
    
    func getSnapsFromFirebase(){
        
    
        
        firestoreDB.collection("Snaps").order(by: "date", descending: true).addSnapshotListener { (snapshot, error) in
            if error != nil{
                self.alertFunc(alertTitle: "Error", alertMessage: error?.localizedDescription ?? "Error")
            }
            else{
                if snapshot?.isEmpty == false && snapshot != nil{
                    self.snapArray.removeAll(keepingCapacity: false)
                    for document in snapshot!.documents{
                        
                        let documentId = document.documentID
                        
                        if let username = document.get("postedBy") as? String{
                            if let imageUrlArray = document.get("imageUrlArray") as? [String]{
                                if let date = document.get("date") as? Timestamp{
                                    
                                    if let timeDifference = Calendar.current.dateComponents([.hour], from: date.dateValue(), to: Date()).hour{
                                        if timeDifference >= 24{
                                            self.firestoreDB.collection("Snaps").document(documentId).delete { (error) in
                                                //
                                            }
                                        }
                                        else {
                                            let snap = Snap(username: username, imageUrlArray: imageUrlArray, date: date.dateValue(), difference: 24 - timeDifference)
                                            self.snapArray.append(snap)
                                        }
                                        
                                 //       self.timeLeft = 24 - timeDifference
                                        

                                    }
                                    
                                    

                                }
                            }
                        }
                        
                    }
                    self.feedTableview.reloadData()
                }
            }
        }
        
    }
    
    
    func getUserInfo(){
        
        firestoreDB.collection("UserInfo").whereField("email", isEqualTo: Auth.auth().currentUser!.email!).getDocuments { (snapshot, error) in
            if error != nil{
                self.alertFunc(alertTitle: "Error", alertMessage: error?.localizedDescription ?? "Error")
            }
            else{
                if snapshot?.isEmpty == false && snapshot != nil{
                    for document in snapshot!.documents{
                        if let userName = document.get("username") as? String{
                            UserSingleton.shareUserInfo.email = Auth.auth().currentUser!.email!
                            UserSingleton.shareUserInfo.username = userName
                        }
                        
                    }
                    
                }
                
            }
        }
        
    }
    
    
    @objc func alertFunc(alertTitle: String, alertMessage: String){
        let warning = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        warning.addAction(okButton)
        self.present(warning, animated: true, completion: nil)
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return snapArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! FeedCell
        cell.feedUsernameLabel.text = snapArray[indexPath.row].username
        cell.feedImageView.sd_setImage(with: URL(string: snapArray[indexPath.row].imageUrlArray[0]))
        return cell
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toSnapVC"{
            let destinationVC = segue.destination as! SnapVC
            destinationVC.selectedSnap = chosenSnap
      //      destinationVC.selectedTime = self.timeLeft
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        chosenSnap = self.snapArray[indexPath.row]
        performSegue(withIdentifier: "toSnapVC", sender: nil)
    }

}
