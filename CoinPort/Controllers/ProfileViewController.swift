//
//  ProfileViewController.swift
//  CoinPort
//
//  Created by Kamal Maged on 2019-12-29.
//  Copyright © 2019 Kamal Maged. All rights reserved.
//

import UIKit
import Firebase

class ProfileViewController: UIViewController, UINavigationBarDelegate {

    @IBOutlet weak var profilePicture: UIImageView!
    
    @IBOutlet weak var userName: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        configureImageView()
        configureNavigationBar()
        userName.text = Auth.auth().currentUser?.displayName
        profilePicture.image = SignInViewController.image
    }
    
    func configureImageView() {
        
        profilePicture.layer.borderWidth = 1.0
        profilePicture.layer.cornerRadius = profilePicture.frame.size.width / 2.3
        profilePicture.layer.borderColor = UIColor.lightGray.cgColor
        profilePicture.layer.masksToBounds = true
        profilePicture.clipsToBounds = true
    }
    
    func configureNavigationBar() {
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barTintColor = UIColor(red: 71/255, green: 91/255, blue: 195/255, alpha: 1)
        navigationController?.navigationBar.barStyle = .black
 
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationItem.title = "Profile"
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "backButton"), style: .plain, target: self, action: #selector(dismissProfileController))
    }
        
    @objc func dismissProfileController() {
        self.dismiss(animated: true, completion: nil)
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
