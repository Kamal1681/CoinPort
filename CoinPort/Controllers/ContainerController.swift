//
//  ContainerController.swift
//  CoinPort
//
//  Created by Kamal Maged on 2019-12-11.
//  Copyright © 2019 Kamal Maged. All rights reserved.
//

import UIKit
import Firebase

class ContainerController: UIViewController {

    var menuViewController: MenuViewController!
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
            menuViewController.delegate = self
            view.insertSubview(menuViewController.view, at: 0)
            addChild(menuViewController)
            menuViewController.didMove(toParent: self)
        }
    }
    
    func showMenuController (shouldAppear: Bool, menuOption: MenuOption?) {
        if shouldAppear {
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
                let width = self.centerController.view.frame.size.width
                self.centerController.view.frame.origin.x = width - width/4
            }, completion: nil)
        } else {
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
                self.centerController.view.frame.origin.x = 0
                if let menuOption = menuOption {
                   self.didSelectMenuOption(menuOption: menuOption)
                }
            }, completion: nil)
        }

    }
    
    func didSelectMenuOption(menuOption: MenuOption) {
        switch menuOption {
            
        case .myProfile:
            let profileViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
            present(UINavigationController(rootViewController: profileViewController), animated: true, completion: nil)
            
        case .addNewOffer:
            print("new offer")
        case .inbox:
            print("inbox")
        case .favorites:
            print("favorites")
        case .arabBitNews:
            print("arab news")
        case .logout:
            do {
                try Auth.auth().signOut()

            }
            catch {
                print("error")
            }
        case .repeatTutorial:
            print("tutorial")
        case .tellAboutUs:
            print("about us")
        case .rateApp:
            print("rate app")
        case .contactUs:
            print("contact us")
        }
    }

}

extension ContainerController: HomeViewControllerDelegate {
    
    func handleMenuToggle(forMenuOption menuOption: MenuOption?) {
        
        if !isExpanded {
            configureMenuViewController()
        }
        isExpanded = !isExpanded
        showMenuController(shouldAppear: isExpanded, menuOption: menuOption)
    }
    
    
}
