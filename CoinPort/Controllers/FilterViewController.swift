//
//  FilterViewController.swift
//  CoinPort
//
//  Created by Kamal Maged on 2020-03-11.
//  Copyright © 2020 Kamal Maged. All rights reserved.
//

import UIKit

class FilterViewController: UIViewController, UINavigationBarDelegate {

    @IBOutlet weak var sortBySegmentedControl: UISegmentedControl!
    
    @IBOutlet weak var distanceSlider: UISlider!
    
    @IBOutlet weak var offerTypeSegmentedControl: UISegmentedControl!
    
    @IBOutlet weak var bTCButton: UIButton!
    @IBOutlet weak var xPRButton: UIButton!
    @IBOutlet weak var eTHButton: UIButton!
    @IBOutlet weak var bCHButton: UIButton!
    @IBOutlet weak var uSDTButton: UIButton!
    @IBOutlet weak var allButton: UIButton!
    
    @IBOutlet weak var countriesButton: UIButton!
    
    @IBOutlet weak var offerStatusSwitch: UISwitch!
    
    @IBOutlet weak var topConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        configureButtons()
        
        //topConstraint.constant = (navigationController?.navigationBar.frame.size.height)!
    }
    
    func configureNavigationBar() {
        navigationController?.setNavigationBarHidden(true, animated: false)
        let navigationBar = UINavigationBar()
        navigationBar.isTranslucent = false
        navigationBar.barTintColor = UIColor(red: 71/255, green: 91/255, blue: 195/255, alpha: 1)
        navigationBar.barStyle = .black
        navigationBar.tintColor = .white
        navigationBar.delegate = self
        
        
        let item = UINavigationItem()
        item.title = "Sort and Filter"
        item.titleView?.tintColor = .white
        item.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "arrow.left"), style: .plain, target: self, action: #selector(dismissProfileController))

        
        let attributes = [NSAttributedString.Key.font: UIFont(name: "Arial-BoldMT", size: 15)]
        UINavigationBar.appearance().titleTextAttributes = attributes as [NSAttributedString.Key : Any]
        
        view.addSubview(navigationBar)
        navigationBar.translatesAutoresizingMaskIntoConstraints = false
        navigationBar.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        navigationBar.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        navigationBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true

        navigationBar.items = [item]
        
    }
    
    func configureButtons() {
        bTCButton.layer.cornerRadius = bTCButton.frame.size.width/2.3
        xPRButton.layer.cornerRadius = bTCButton.frame.size.width/2.3
        eTHButton.layer.cornerRadius = eTHButton.frame.size.width/2.3
        bCHButton.layer.cornerRadius = bCHButton.frame.size.width/2.3
        uSDTButton.layer.cornerRadius = uSDTButton.frame.size.width/2.3
        allButton.layer.cornerRadius = allButton.frame.size.width/2.3
    }
    
    //MARK:- Actions
    
    @objc func dismissProfileController() {
        //self.dismiss(animated: true, completion: nil)
        let container = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ContainerController") as! ContainerController
        UIView.animate(withDuration: 0.1, delay: 0, options: .curveEaseInOut, animations: {
                self.view.addSubview(container.view)
                self.addChild(container)
                container.didMove(toParent: self)
        }, completion: nil)
    }
    
    @IBAction func sortBySegmentedControlTapped(_ sender: Any) {
        
    }
    
    @IBAction func distanceSlidderDragged(_ sender: Any) {
        
    }
    
    @IBAction func offerTypeSegmentedControlTapped(_ sender: Any) {
        
    }
    
    @IBAction func bTCButtonPressed(_ sender: Any) {
        
    }
    
    @IBAction func xPRButtonPressed(_ sender: Any) {
        
    }
    
    @IBAction func eTHButtonPressed(_ sender: Any) {
        
    }
    
    @IBAction func bCHButtonPressed(_ sender: Any) {
        
    }
    
    @IBAction func uSDTButtonPressed(_ sender: Any) {
        
    }
    
    @IBAction func allButtonPressed(_ sender: Any) {
        
    }
    
    @IBAction func countriesButtonPressed(_ sender: Any) {
        
    }
    
    @IBAction func offerStatusSwitchTapped(_ sender: Any) {
        
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
