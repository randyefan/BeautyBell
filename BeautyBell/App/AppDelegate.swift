//
//  AppDelegate.swift
//  BeautyBell
//
//  Created by Fardan on 27/05/21.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit
import GoogleSignIn

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        // Facebook
        ApplicationDelegate.shared.application(
            application,
            didFinishLaunchingWithOptions:
            launchOptions
        )
        
        // Google
        GIDSignIn.sharedInstance()?.clientID = "218517533524-pqtj19h1h5gkevlrop8i7ltl76fg6oja.apps.googleusercontent.com"
        GIDSignIn.sharedInstance()?.restorePreviousSignIn()
        
        return true
        
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        if AccessToken.current != nil {
            let loginManager = LoginManager()
            loginManager.logOut()
        }
        
        if let _ = GIDSignIn.sharedInstance()?.currentUser {
            GIDSignIn.sharedInstance()?.signOut()
        }
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        ApplicationDelegate.shared.application(
            app,
            open: url,
            options: options
        )
        
        GIDSignIn.sharedInstance().handle(url)
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

