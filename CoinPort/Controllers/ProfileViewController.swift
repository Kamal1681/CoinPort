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
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var offersTableView: UITableView!
    @IBOutlet weak var infoLabelView: UIView!
    @IBOutlet weak var segmentedControlView: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureImageView()
        configureNavigationBar()
        configureInfoLabel()
        userName.text = Auth.auth().currentUser?.displayName
        profilePicture.image = SignInViewController.image
        segmentControlSetup()
        
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

    // MARK:- Segmented Control Function

    func segmentControlSetup() {
        
        let selectedIndex = segmentedControlView.selectedSegmentIndex
        switch selectedIndex {
            
        case 0:
            infoLabelView.isHidden = false
            offersTableView.isHidden = true
        case 1:
            offersTableView.isHidden = false
            infoLabelView.isHidden = true
        default:
            break
        }
    }
    @IBAction func segmentedConrolTapped(_ sender: Any) {
        segmentControlSetup()
    }
    
}
