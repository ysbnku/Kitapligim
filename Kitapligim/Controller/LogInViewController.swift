//
//  LogInViewControllerrViewController.swift
//  Kitapligim
//
//  Created by Yavuz BİTMEZ on 7.02.2021.
//  Copyright © 2021 Yavuz BİTMEZ. All rights reserved.
//

import UIKit
import GoogleSignIn
import Firebase


class LogInViewController: UIViewController,GIDSignInDelegate {

    private var btnGoogle: UIButton!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        GIDSignIn.sharedInstance()?.clientID = FirebaseApp.app()?.options.clientID
        GIDSignIn.sharedInstance()?.delegate = self


        
        self.view.backgroundColor = Helper.backgroundColor
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.barTintColor = .red
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for:.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
        
        self.btnGoogle = UIButton()
        self.btnGoogle.frame = CGRect(x: 20, y: self.view.frame.size.height/4 , width: self.view.frame.size.width - 40, height: 50)
        self.btnGoogle.backgroundColor = .white
        self.btnGoogle.setTitleColor(.black, for: .normal)
        self.btnGoogle.setTitle(" Google ile bağlan", for: .normal)
        self.btnGoogle.setImage(UIImage(named: "icon_google"), for: .normal)
        self.btnGoogle.layer.cornerRadius = 6
        self.btnGoogle.addTarget(self, action: #selector(actionGoogle), for: .touchUpInside)
        self.view.addSubview(self.btnGoogle!)
    
    }

    @objc func actionGoogle(_ sender: Any) {
        GIDSignIn.sharedInstance()?.presentingViewController = self
        GIDSignIn.sharedInstance().signIn()
    }
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        let social_id = signIn.currentUser.userID ?? ""
        let name = signIn.currentUser.profile.name ?? ""
        let email = signIn.currentUser.profile.email ?? ""
        var image = ""
        print(name + email + social_id)
        if(signIn.currentUser.profile.hasImage) {
            image = signIn.currentUser.profile.imageURL(withDimension: 300)?.absoluteString ?? ""
        }
        
    }
    

}
