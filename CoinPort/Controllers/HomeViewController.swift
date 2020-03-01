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
    
    @IBOutlet weak var profilePicture: UIImageView!
    
    @IBOutlet weak var offersTableView: UITableView!
    @IBOutlet weak var viewTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var makeNewOffer: UIButton!
    
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
        configureButton()
        configureImageView()
        
        Firestore.firestore().settings = settings
        
        viewTopConstraint.constant = (navigationController?.navigationBar.frame.size.height)!

        if let userName = Auth.auth().currentUser?.displayName {
            nameLabel.text = "Hello, \(userName)"
        }
        
        offersTableView.delegate = self
        offersTableView.dataSource = self
        offersTableView.separatorStyle = .singleLine
        offersTableView.register(UINib(nibName: "OfferTableCell", bundle: nil), forCellReuseIdentifier: "Offer Table Cell")
        
        getCountryCodes()
        getUserLocation()
        getOffers()
       
    }
    
    //MARK:- Getter functions
    
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
                    let offerRequestRawvalue = document.get("offerRequest") as? String,
                    let realcurrency = document.get("realCurrency") as? String,
                    let user = document.get("user") as? String,
                    let userCountry = document.get("userCountry") as? String,
                    let profilePictureURL = document.get("profilePictureURL") as? String
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
                    offer.offerRequest = OfferRequest(rawValue: offerRequestRawvalue)
                    offer.realCurrency = realcurrency
                    offer.user = user
                    offer.userCountry = userCountry
                    offer.profilePictureURL = URL(string: profilePictureURL)
                    self.offersArray.append(offer)
                }
                self.offersTableView.reloadData()
            }
        }
        
    }
    
    func getCountryCodes() {
        let countryCodes: [String] = NSLocale.isoCountryCodes
        
        for countryCode in countryCodes {

            let identifier = NSLocale(localeIdentifier: countryCode)

            if let country = identifier.displayName(forKey: NSLocale.Key.countryCode, value: countryCode) {
                if !country.isContiguousUTF8 { continue }
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
    
    //MARK:- Configuration Functions
    
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
    
    func configureButton() {
        
        makeNewOffer.backgroundColor = UIColor(red: 71/255, green: 91/255, blue: 195/255, alpha: 1)
        makeNewOffer.tintColor = UIColor.white
        makeNewOffer.layer.cornerRadius = 7
        makeNewOffer.layer.shadowColor = UIColor.black.cgColor
        makeNewOffer.layer.shadowOffset = CGSize(width: 3, height: 3)
        makeNewOffer.layer.shadowOpacity = 0.5
    }
    
    func configureImageView() {
        guard let profilePictureURL = Auth.auth().currentUser?.photoURL else { return }
    
        SignInViewController.getUser(profilePicture: profilePictureURL, completion: {
            
            self.profilePicture.image = SignInViewController.image
            self.profilePicture.layer.borderWidth = 1.0
            self.profilePicture.layer.cornerRadius = self.profilePicture.frame.size.width / 2
            self.profilePicture.layer.borderColor = UIColor.lightGray.cgColor
            self.profilePicture.layer.masksToBounds = true
            self.profilePicture.clipsToBounds = true
        })

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
        return 200
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
            if let error = error {
                print(error)
                return
            }
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
    
    func getUser(profilePicture: URL, completion: @escaping (UIImage) -> Void) {
        URLSession.shared.dataTask(with: profilePicture) { (data, response, error) in
            if let error = error {
                DispatchQueue.main.async {
                    print(error)
                }
                return
            }
            guard let data = data else {
                DispatchQueue.main.async {
                    print("No Data")
                }
                return
            }
            DispatchQueue.main.async {
                guard let photo = UIImage(data: data)  else { return }
                completion(photo)
            }
        }.resume()
    }
    
    func getCountryCode(userCountry: String) -> String {
        guard let countryCode = countryCodesDictionary[userCountry] else
        { return "" }
        return countryCode
    }

}
