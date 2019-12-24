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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        GIDSignIn.sharedInstance()?.presentingViewController = self
        signInButton.accessibilityLabel?.append(" with Google")
        
        configureFBSignInButton()
    }

    func configureFBSignInButton() {
        
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
            
            let accessToken = AccessToken.current
            guard let accessTokenString = accessToken?.tokenString else {
                return
            }
            let credentials = FacebookAuthProvider.credential(withAccessToken: accessTokenString)
            
           
            Auth.auth().signIn(with: credentials) { (user, error) in
                if let error = error {
                    print(error)
                    return
                }
                print(user!)
            }
            
            GraphRequest(graphPath: "/me", parameters: ["fields": "id, name, email, picture"]).start { (connection, result, error) in
                if let error = error {
                    print(error)
                    return
                }
                let resultDictionary = result as! Dictionary<String, Any>
                let name = resultDictionary["name"]
                let picture = resultDictionary["picture"]
                let email = resultDictionary["email"]

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
           
           print(authResult)
        }
    }
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        //
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
