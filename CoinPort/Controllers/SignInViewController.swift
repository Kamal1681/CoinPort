//
//  SignInViewController.swift
//  CoinPort
//
//  Created by Kamal Maged on 2019-12-21.
//  Copyright © 2019 Kamal Maged. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn
import FBSDKLoginKit

class SignInViewController: UIViewController, GIDSignInDelegate {
    
    @IBOutlet weak var signInButton: GIDSignInButton!
    @IBOutlet weak var fbSignInButton: FBLoginButton!
    static var image: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        GIDSignIn.sharedInstance()?.presentingViewController = self
        GIDSignIn.sharedInstance().delegate = self
        signInButton.accessibilityLabel?.append(" with Google")
        
        configureFBSignInButton()
    }

    private func configureFBSignInButton() {
        
        fbSignInButton.backgroundColor = UIColor(red: 0.2314, green: 0.349, blue: 0.5961, alpha: 1)
        fbSignInButton.setTitle("Sign In with Facebook", for: .normal)
        fbSignInButton.setTitleColor(.white, for: .normal)
        fbSignInButton.layer.cornerRadius = 2
        fbSignInButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 13.5)
        fbSignInButton.addTarget(self, action: #selector(fbLoginHandle), for: .touchUpInside)

    }
    
    @objc func fbLoginHandle() {
        
        LoginManager().logIn(permissions: ["email", "public_profile"], from: self) { (result, error) in
            if let error = error {
                print(error)
                return
            }
            guard let result = result else { return }
            if result.isCancelled { return }
            
            let accessToken = AccessToken.current
            guard let accessTokenString = accessToken?.tokenString else {
                return
            }
            let credentials = FacebookAuthProvider.credential(withAccessToken: accessTokenString)
            
           
            Auth.auth().signIn(with: credentials) { (authResult, error) in
                if let error = error {
                    print(error)
                    return
                }
                guard let profilePicture = authResult?.user.photoURL
                    else { return }
                
                SignInViewController.getUser(profilePicture: profilePicture)
                self.openHomeScreen()
            }
        }
    }
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        
        if let error = error {
            print(error)
            return
        }
        guard let authentication = user.authentication else { return }
        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken, accessToken: authentication.accessToken)
        
        Auth.auth().signIn(with: credential) { (authResult, error) in
            if let error = error {
                print(error)
                return
            }

            guard let profilePicture = authResult?.user.photoURL
                else { return }
            
            SignInViewController.getUser(profilePicture: profilePicture)
            self.openHomeScreen()
        }
    }
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        //
    }
    static func getUser(profilePicture: URL) {
        
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
                SignInViewController.image = photo
            }
        }.resume()
        
    }
    func openHomeScreen() {
        
        let container = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ContainerController") as! ContainerController
        UIView.animate(withDuration: 0.1, delay: 0, options: .curveEaseInOut, animations: {
                self.view.addSubview(container.view)
                self.addChild(container)
                container.didMove(toParent: self)
        }, completion: nil)
    }

}
