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

class LoginViewModel {
    var isFacebookLogin = BehaviorRelay<Bool>(value: false)
    
    func performFacebookLogin(rootVC: UIViewController) {
        let fbLoginManager = LoginManager()
        fbLoginManager.logIn(permissions: ["email", "user_birthday"], from: rootVC) { [weak self] (result, err) in
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
}
