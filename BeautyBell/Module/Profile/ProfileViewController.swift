//
//  ProfileViewController.swift
//  BeautyBell
//
//  Created by Fardan on 27/05/21.
//

import UIKit
import RxSwift
import RxCocoa

class ProfileViewController: UIViewController {

    @IBOutlet weak var imageProfile: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    let disposeBag = DisposeBag()
    let viewModel = ProfileViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        registerObserver()
    }

    func setupView() {
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.title = "Profile"
    }
    
    func registerObserver() {
        viewModel.photo.subscribe(onNext: { [weak self] photoUrl in
            guard let photoUrl = photoUrl else { return }
            self?.imageProfile.load(url: photoUrl)
        }).disposed(by: disposeBag)
        
        viewModel.email.subscribe(onNext: { [weak self] emailString in
            guard let email = emailString else { return }
            self?.emailLabel.text = email
        }).disposed(by: disposeBag)
        
        viewModel.name.subscribe(onNext: { [weak self] nameString in
            guard let name = nameString else { return }
            self?.nameLabel.text = name
        }).disposed(by: disposeBag)
    }
}
