//
//  LoginViewModel.swift
//  BeautyBell
//
//  Created by Randy Efan Jayaputra on 28/05/21.
//

import Foundation
import RxSwift
import RxCocoa
import FBSDKLoginKit
import GoogleSignIn

class LoginViewModel: NSObject {
    var isFacebookLogin = BehaviorRelay<Bool>(value: false)
    var isGoogleLogin = BehaviorRelay<Bool>(value: false)
    
    func performFacebookLogin(rootVC: UIViewController) {
        let fbLoginManager = LoginManager()
        fbLoginManager.logIn(permissions: ["email"], from: rootVC) { [weak self] (result, err) in
            if let err = err {
                print(err.localizedDescription)
                return
            }
            
            guard let result = result else { return }
            
            if result.isCancelled {
                return
            }
            
            if (result.grantedPermissions.contains("email")) {
                if AccessToken.current != nil {
                    self?.isFacebookLogin.accept(true)
                }
            }
            
        }
    }
    
    func performGoogleLogin(rootVC: UIViewController) {
        GIDSignIn.sharedInstance()?.presentingViewController = rootVC
        GIDSignIn.sharedInstance()?.signIn()
        GIDSignIn.sharedInstance()?.delegate = self
    }
}

extension LoginViewModel: GIDSignInDelegate {
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        // Check for sign in error
        if let error = error {
            if (error as NSError).code == GIDSignInErrorCode.hasNoAuthInKeychain.rawValue {
                print("The user has not signed in before or they have since signed out.")
            } else {
                print("\(error.localizedDescription)")
            }
            return
        }
        
        // Post notification after user successfully sign in
        NotificationCenter.default.post(name: .signInGoogleCompleted, object: nil)
        self.isGoogleLogin.accept(true)
    }
}

extension Notification.Name {
    static var signInGoogleCompleted: Notification.Name {
        return .init(rawValue: #function)
    }
}
