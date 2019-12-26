//
//  HomeViewController.swift
//  CoinPort
//
//  Created by Kamal Maged on 2019-12-25.
//  Copyright © 2019 Kamal Maged. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    var delegate: HomeViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureNavigationBar()
        
    }
    
    func configureNavigationBar() {
        navigationController?.navigationBar.barTintColor = UIColor(red: 71/255, green: 91/255, blue: 195/255, alpha: 1)
        navigationController?.navigationBar.barStyle = .black
        
        navigationItem.title = "Global Offers"
        navigationItem.titleView?.tintColor = .white
    
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "ic_menu_white_3x").withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleMenuToggle))
        
    }
    
    @objc func handleMenuToggle() {
        delegate?.handleMenuToggle()
    }
}
