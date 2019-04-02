//
//  ViewController.swift
//  AuthenticationApp
//
//  Created by SonVH on 4/2/19.
//  Copyright © 2019 SonVH. All rights reserved.
//

import UIKit
import FBSDKLoginKit

class ViewController: UIViewController, FBSDKLoginButtonDelegate {
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        if error != nil {
            print(error)
            return
        }
        
        FBSDKGraphRequest(graphPath: "/me", parameters: ["fields": "id, name, email"])?.start(completionHandler: { (connection, result, error) in
            if error != nil {
                print("Fail to graph request: \(error)")
                return
            }
            print(result)
        })
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        print("logout")
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let loginButton = FBSDKLoginButton()
        view.addSubview(loginButton)
        //frame's are obselete, please use constraints instead because its 2016 after all
        loginButton.frame = CGRect(x: 16, y: 50, width: view.frame.width - 32, height: 50)
        loginButton.delegate = self
        
        //add button
        let customBtn = UIButton(frame: CGRect(x: 16, y: 150, width: view.frame.width - 32, height: 50))
        customBtn.setTitle("Custom Login Facebook", for: .normal)
        customBtn.backgroundColor = UIColor.blue
        customBtn.addTarget(self, action: #selector(btnLoginTouched), for: UIControl.Event.touchUpInside)
        view.addSubview(customBtn)
    }

    @objc func btnLoginTouched() {
        print("1234")
        FBSDKLoginManager().logIn(withReadPermissions: ["email", "public_profile"], from: self) { (result, error) in
            if error != nil {
                print("error login wth permission: \(error)")
            }
            print(result?.token.tokenString)
        }
    }
}

