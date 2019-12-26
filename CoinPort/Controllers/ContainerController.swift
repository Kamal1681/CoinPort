//
//  ContainerController.swift
//  CoinPort
//
//  Created by Kamal Maged on 2019-12-11.
//  Copyright © 2019 Kamal Maged. All rights reserved.
//

import UIKit

class ContainerController: UIViewController {

    var menuViewController: UIViewController!
    var centerController: UIViewController!
    var isExpanded = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureHomeViewController()
    }
    
    func configureHomeViewController() {
        
        let homeViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        centerController = UINavigationController(rootViewController: homeViewController)
        
        view.addSubview(centerController.view)
        addChild(centerController)
        centerController.didMove(toParent: self)
        homeViewController.delegate = self
    }
    
    func configureMenuViewController() {
        if menuViewController == nil {
            menuViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MenuViewController") as! MenuViewController
            view.insertSubview(menuViewController.view, at: 0)
            addChild(menuViewController)
            menuViewController.didMove(toParent: self)
        }
    }
    
    func showMenuController (shouldAppear: Bool) {
        if shouldAppear {
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
                let width = self.centerController.view.frame.size.width
                self.centerController.view.frame.origin.x = width - width/2
            }, completion: nil)
        } else {
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
                self.centerController.view.frame.origin.x = 0
            }, completion: nil)
            
        }
    }

}

extension ContainerController: HomeViewControllerDelegate {
    func handleMenuToggle() {
        if !isExpanded {
            configureMenuViewController()
        }
        isExpanded = !isExpanded
        showMenuController(shouldAppear: isExpanded)
    }
    
    
}
