//
//  HomeViewController.swift
//  CoinPort
//
//  Created by Kamal Maged on 2019-12-25.
//  Copyright © 2019 Kamal Maged. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UINavigationBarDelegate {
    
    var delegate: HomeViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureNavigationBar()
        navigationController?.setNavigationBarHidden(true, animated: false)

    }
    
    func configureNavigationBar() {
        let item = UINavigationItem()
        item.title = "Global Offers"
        item.titleView?.tintColor = .white
        item.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "ic_menu_white_3x").withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleMenuToggle))
        
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
    
    
    
    @objc func handleMenuToggle() {
        delegate?.handleMenuToggle()
    }
}
