//
//  ViewController.swift
//  BeautyBell
//
//  Created by Fardan on 27/05/21.
//

import UIKit
import RxSwift
import FBSDKLoginKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    let viewModel = LoginViewModel()
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        registerObserver()
    }
    
    func setupView() {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    func registerObserver() {
        viewModel.isFacebookLogin.subscribe(onNext: { [weak self] isLogin in
            if isLogin {
                self?.completeLogin()
            }
        }).disposed(by: disposeBag)
        
        viewModel.isGoogleLogin.subscribe(onNext: { [weak self] isLogin in
            if isLogin {
                self?.completeLogin()
            }
        }).disposed(by: disposeBag)
    }
    
    func completeLogin() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let tabBar = storyboard.instantiateViewController(identifier: "MainTabBar")
        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(tabBar)
    }
    
    @IBAction func loginPressed(_ sender: Any) {
        completeLogin()
    }
    
    @IBAction func facebookLoginPressed(_ sender: Any) {
        viewModel.performFacebookLogin(rootVC: self)
    }
    
    @IBAction func googleLoginPressed(_ sender: Any) {
        viewModel.performGoogleLogin(rootVC: self)
    }
}

