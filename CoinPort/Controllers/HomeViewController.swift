//
//  HomeViewController.swift
//  CoinPort
//
//  Created by Kamal Maged on 2019-12-25.
//  Copyright © 2019 Kamal Maged. All rights reserved.
//

import UIKit
import Firebase
import GoogleMaps

class HomeViewController: UIViewController, UINavigationBarDelegate {
    
    
    @IBOutlet weak var offersTableView: UITableView!
    @IBOutlet weak var viewTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var nameLabel: UILabel!
    
    var delegate: HomeViewControllerDelegate?
    var offersArray = [Offer]()
    let reuseIdentifier = "Offer Table Cell"
    
    let db = Firestore.firestore()
    let settings = FirestoreSettings()

    let locationManager = CLLocationManager()
    var countryCodesDictionary = [String: String]()
    var currentLocation: CLLocation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigationBar()
        Firestore.firestore().settings = settings
        
        viewTopConstraint.constant = (navigationController?.navigationBar.frame.size.height)!
        guard let userName = Auth.auth().currentUser?.displayName else { return }
        nameLabel.text = "Hello, \(userName)"
        
        offersTableView.delegate = self
        offersTableView.dataSource = self
        
        getCountryCodes()
        getUserLocation()
        getOffers()
       
    }
    
    //MARK:- Getters and Configuration functions
    
    func getOffers() {
         let FBQuery = db.collection("Offers")
        FBQuery.getDocuments { (snapshot, error) in
            if let error = error {
                print("Error getting documents: \(error)")
            } else {
                
                for document in snapshot!.documents {
                   guard
                    let digtalCurrency = document.get("digitalCurrency") as? String,
                    let exchangeAmount = document.get("exchangeAmount") as? Double,
                    let exchangeRate = document.get("exchangeRate") as? String,
                    let numberOfViews = document.get("numberOfViews") as? Int,
                    let offerLocation = document.get("offerLocation") as? GeoPoint,
                    //let offerRequest = document.get("offerRequest") as? OfferRequest,
                    //let offerStatus = document.get("offerStatus") as? OfferStatus,
                    let realcurrency = document.get("realCurrency") as? String,
                    let user = document.get("user") as? String,
                    let userCountry = document.get("userCountry") as? String
                    else {
                        print("Error geting data from Firebase")
                        return
                    }
                    let offer = Offer()
                    offer.digitalCurrency = digtalCurrency
                    offer.exchangeAmount = exchangeAmount
                    offer.exchangeRate = exchangeRate
                    offer.numberOfViews = numberOfViews
                    offer.offerLocation = offerLocation
                    //offer.offerRequest = offerRequest
                    //offer.offerStatus = offerStatus
                    offer.realCurrency = realcurrency
                    offer.user = user
                    offer.userCountry = userCountry

                    self.offersArray.append(offer)
                }
                self.offersTableView.reloadData()
            }
        }
        
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
    
    func getCountryCodes() {
        let countryCodes: [String] = NSLocale.isoCountryCodes
        
        for countryCode in countryCodes {

            let identifier = NSLocale(localeIdentifier: countryCode)
            if let country = identifier.displayName(forKey: NSLocale.Key.countryCode, value: countryCode) {
                countryCodesDictionary[country] = countryCode
            }
        }
    }
    
    func getUserLocation() {
        
        locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            currentLocation = locationManager.location
        }
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
        let cell = offersTableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! OfferTableCell
        cell.countryCode = countryCodesDictionary[offersArray[indexPath.row].userCountry]
        cell.delegate = self
        cell.configureCell(offer: offersArray[indexPath.row])
    
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return offersArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 230
    }
}

    //MARK:- Offer Table Cell Delegate

extension HomeViewController: OfferTableCellDelegate {
    
    func getDistance(offerLocation: GeoPoint, completion: @escaping (String) -> Void) {
        
        guard let currentLocation = currentLocation else { return }
        let startPoint = currentLocation.coordinate
        let endPoint = offerLocation
        var distance: String?

        let url = URL(string: "https://maps.googleapis.com/maps/api/directions/json?origin=\(startPoint.latitude),\(startPoint.longitude)&destination=\(endPoint.latitude),\(endPoint.longitude)&key=\(googleApiKey)")
       
        URLSession.shared.dataTask(with: url! as URL) { (data, response, error) in

            do {
                if data != nil {
                    let dict = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! [String : Any]
    
                    let routes = dict["routes"] as! [Dictionary<String, Any>]
                    let legsDict = routes[0]
                    let legs = legsDict["legs"] as! [Dictionary<String, Any>]
                    let distDict = legs[0]
                    let dist = distDict["distance"] as! [String : Any]
                    distance = dist["text"] as? String
                    
                    DispatchQueue.main.async {
                        completion(distance!)
                    }
                }
            }
            catch {
                print("Error")
            }
            
        }.resume()
    }
}
