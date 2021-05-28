//
//  ProfileViewModel.swift
//  BeautyBell
//
//  Created by Randy Efan Jayaputra on 28/05/21.
//

import Foundation
import FBSDKLoginKit
import RxSwift
import RxCocoa

struct ProfileViewModel {
    var photo = BehaviorRelay<URL?>(value: nil)
    var email = BehaviorRelay<String?>(value: nil)
    var name = BehaviorRelay<String?>(value: nil)
    
    init() {
        if AccessToken.current != nil {
            guard let photoUrl = Profile.current?.imageURL, let emailString = Profile.current?.email, let nameString = Profile.current?.name else { return }
            photo.accept(photoUrl)
            email.accept(emailString)
            name.accept(nameString)
        }
    }
}
