//
//  DigitalCurrencyViewController.swift
//  CoinPort
//
//  Created by Kamal Maged on 2020-01-09.
//  Copyright © 2020 Kamal Maged. All rights reserved.
//

import UIKit

class DigitalCurrencyViewController: UIViewController, UINavigationBarDelegate {

    @IBOutlet weak var currencyTableView: UITableView!
    @IBOutlet weak var viewTopConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureNavigationBar()
        
    }
    
    func configureNavigationBar() {
        let navigationBar = UINavigationBar()
        navigationBar.isTranslucent = false
        navigationBar.barTintColor = UIColor(red: 71/255, green: 91/255, blue: 195/255, alpha: 1)
        navigationBar.barStyle = .black
        navigationBar.tintColor = .white
        navigationBar.delegate = self
        
        
        let item = UINavigationItem()
        item.title = "Choose one of the following currencies"
        item.titleView?.tintColor = .white
        item.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "arrow.left"), style: .plain, target: self, action: #selector(dismissProfileController))
        viewTopConstraint.constant = 60
        
        let attributes = [NSAttributedString.Key.font: UIFont(name: "Arial-BoldMT", size: 15)]
        UINavigationBar.appearance().titleTextAttributes = attributes
        
        view.addSubview(navigationBar)
        navigationBar.translatesAutoresizingMaskIntoConstraints = false
        navigationBar.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        navigationBar.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        navigationBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true

        navigationBar.items = [item]

        
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
