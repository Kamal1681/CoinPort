//
//  SignInViewController.swift
//  CoinPort
//
//  Created by Kamal Maged on 2019-12-11.
//  Copyright © 2019 Kamal Maged. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn
import FBSDKLoginKit


class SignInViewController: UIViewController, GIDSignInDelegate, LoginButtonDelegate {


    @IBOutlet weak var signInButton: GIDSignInButton!

    @IBOutlet weak var fbSignInButton: FBLoginButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        GIDSignIn.sharedInstance()?.presentingViewController = self
        
        fbSignInButton.delegate = self
        
        signInButton.accessibilityLabel?.append(" with Google")
        
        fbSignInButton.frame.size.height = 100
        fbSignInButton.titleLabel?.text = "Sign In with Facebook"
    }
    
    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
        
    }
    
    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
        
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
