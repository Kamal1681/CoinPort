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
    @IBOutlet weak var nextButton: UIButton!
    
    let reuseIdentifier = "Digital Currency Table Cell"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureNavigationBar()
        currencyTableView.delegate = self
        currencyTableView.dataSource = self
        currencyTableView.separatorStyle = .none
        
        nextButton.backgroundColor = UIColor(red: 71/255, green: 91/255, blue: 195/255, alpha: 1)
        nextButton.tintColor = UIColor.white
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

        
        let attributes = [NSAttributedString.Key.font: UIFont(name: "Arial-BoldMT", size: 15)]
        UINavigationBar.appearance().titleTextAttributes = attributes
        
        view.addSubview(navigationBar)
        navigationBar.translatesAutoresizingMaskIntoConstraints = false
        navigationBar.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        navigationBar.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        navigationBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true

        navigationBar.items = [item]
        viewTopConstraint.constant = 60
        
    }
    
    @objc func dismissProfileController() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func nextButtonPressed(_ sender: Any) {
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

    // MARK:- Table view delegate and data source

extension DigitalCurrencyViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 8
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = currencyTableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! DigitalCurrencyTableCell
        let digitalCurrencyOptions = DigitalCurrencyOptions(rawValue: indexPath.row)
        
        cell.currencyLabel.text = digitalCurrencyOptions?.description
        cell.abbreviationLabel.text = digitalCurrencyOptions?.abbreviation
        cell.currencyImage.image = digitalCurrencyOptions?.image
        
        return cell
    }
    
    
    
}
