//
//  ProfileViewController.swift
//  CoinPort
//
//  Created by Kamal Maged on 2019-12-29.
//  Copyright © 2019 Kamal Maged. All rights reserved.
//

import UIKit
import Firebase

class ProfileViewController: UIViewController, UINavigationBarDelegate, UITabBarDelegate {

    @IBOutlet weak var menuTabBar: UITabBar!
    @IBOutlet weak var profilePicture: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var offersTableView: UITableView!
    @IBOutlet weak var infoLabelView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureImageView()
        configureNavigationBar()
        configureInfoLabel()
        menuTabBar.delegate = self
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
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "arrow.left"), style: .plain, target: self, action: #selector(dismissProfileController))
    }
        
    @objc func dismissProfileController() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func configureInfoLabel() {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM dd, yyyy"
        guard let date = Auth.auth().currentUser?.metadata.creationDate else { return }
        infoLabel.text = "Member since: \(formatter.string(from: date))"
    }

    // MARK:- Tab Bar functions
    
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        
        if item.tag == 1 {
            infoLabelView.isHidden = false
            offersTableView.isHidden = true
        }
        if item.tag == 2 {
            offersTableView.isHidden = false
            infoLabelView.isHidden = true
        }
    }

    
}
