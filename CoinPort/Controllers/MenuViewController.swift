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
    
    @IBOutlet weak var menuTableView: UITableView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var profilePicture: UIImageView!
    
    let reuseIdentifier = "Menu Table Cell"
    var delegate: HomeViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureImageView()
        email.text = Auth.auth().currentUser?.email
        userName.text = Auth.auth().currentUser?.displayName
        profilePicture.image = SignInViewController.image
        menuTableView.dataSource = self
        menuTableView.delegate = self
        menuTableView.separatorStyle = .none
        menuTableView.separatorInset = UIEdgeInsets.zero
    
    }
    
    func configureImageView() {
        
        profilePicture.layer.borderWidth = 1.0
        profilePicture.layer.cornerRadius = profilePicture.frame.size.width / 2
        profilePicture.layer.borderColor = UIColor.lightGray.cgColor
        profilePicture.layer.masksToBounds = true
        profilePicture.clipsToBounds = true
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

    // MARK: - Table view delegate and datasource

extension MenuViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = menuTableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! MenuTableCell
        
        let menuOption = MenuOptions(rawValue: indexPath.row)
        cell.itemLabel.text = menuOption?.description
        cell.itemImage.image = menuOption?.image
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let menuOption = MenuOptions(rawValue: indexPath.row)
        delegate?.handleMenuToggle(forMenuOption: menuOption)
    }
    
}
