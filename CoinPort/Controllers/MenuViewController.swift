//
//  MenuViewController.swift
//  CoinPort
//
//  Created by Kamal Maged on 2019-12-25.
//  Copyright © 2019 Kamal Maged. All rights reserved.
//

import UIKit
import Firebase

class MenuViewController: UIViewController {
    
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var profilePicture: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
        email.text = Auth.auth().currentUser?.email
        userName.text = Auth.auth().currentUser?.displayName
        profilePicture.image = SignInViewController.image
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
