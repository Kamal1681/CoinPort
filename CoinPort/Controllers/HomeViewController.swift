//
//  HomeViewController.swift
//  CoinPort
//
//  Created by Kamal Maged on 2019-12-25.
//  Copyright © 2019 Kamal Maged. All rights reserved.
//

import UIKit
import Firebase

class HomeViewController: UIViewController, UINavigationBarDelegate {
    
    
    @IBOutlet weak var offersTableView: UITableView!
    @IBOutlet weak var viewTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var nameLabel: UILabel!
    
    var delegate: HomeViewControllerDelegate?
    var offersArray = [Offer]()
    let reuseIdentifier = "Offer Table Cell"
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureNavigationBar()
        viewTopConstraint.constant = (navigationController?.navigationBar.frame.size.height)!
        guard let userName = Auth.auth().currentUser?.displayName else { return }
        nameLabel.text = "Hello, \(userName)"
    }
    
    func configureNavigationBar() {
        navigationController?.setNavigationBarHidden(true, animated: false)
        let item = UINavigationItem()
        item.title = "Global Offers"
        item.titleView?.tintColor = .white
        item.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "ic_menu_white_3x").withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleMenuToggle))
        
        let filterButton = UIBarButtonItem(image: UIImage(systemName: "line.horizontal.3.decrease"), style: .plain, target: self, action: #selector(openFilterViewController))
        filterButton.tintColor = .white
        let mapButton = UIBarButtonItem(image: UIImage(systemName: "map"), style: .plain, target: self, action: #selector(openMapViewController))
        mapButton.tintColor = .white
        item.rightBarButtonItems = [mapButton, filterButton]
        
        
        let navigationBar = UINavigationBar()
        navigationBar.delegate = self
        navigationBar.isTranslucent = false
        navigationBar.barTintColor = UIColor(red: 71/255, green: 91/255, blue: 195/255, alpha: 1)
        navigationBar.barStyle = .black
        
        view.addSubview(navigationBar)
        navigationBar.translatesAutoresizingMaskIntoConstraints = false
        navigationBar.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        navigationBar.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        navigationBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        
        navigationBar.items = [item]
        
    }
    
    //MARK:- Button Actions
    
    @objc func handleMenuToggle() {
        delegate?.handleMenuToggle(forMenuOption: nil)
    }
    
    @objc func openFilterViewController() {
        print("openfilterviewController")
    }
    
    @objc func openMapViewController() {
        print("openmapviewcontroller")
    }
    
    @IBAction func publishButtonPressed(_ sender: Any) {
        print("publish")
    }
    
    @IBAction func chooseCurrencyPressed(_ sender: Any) {
        print("choose")
    }
    

}
    //MARK:- TableView Delegate and DataSource
extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = offersTableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return offersArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}
