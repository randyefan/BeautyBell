//
//  HomeViewController.swift
//  BeautyBell
//
//  Created by Fardan on 27/05/21.
//

import UIKit
import RxSwift
import RxCocoa

class HomeViewController: UIViewController {

    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var viewModel: ArtisansListViewModel = ArtisansListViewModel()
    var artisanList: Artisans = []
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        registerObserver()
    }
 
    func setupView() {
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.title = "Artisan"
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(UINib(nibName: "ArtisanTableViewCell", bundle: nil), forCellReuseIdentifier: "artisanCell")
        tableView.allowsSelection = false
    }
    
    func setupActivityIndicator(isLoading: Bool) {
        if isLoading {
            activityIndicator.alpha = 1.0
            tableView.alpha = 0.0
            activityIndicator.startAnimating()
        } else {
            tableView.alpha = 1.0
            activityIndicator.alpha = 0.0
            activityIndicator.stopAnimating()
        }
    }
    
    func registerObserver() {
        viewModel.artisanList.subscribe(onNext: { [weak self] artisan in
            self?.artisanList = artisan
            self?.tableView.reloadData()
        }).disposed(by: disposeBag)
        
        viewModel.isLoading.subscribe(onNext: { [weak self] isLoading in
            self?.setupActivityIndicator(isLoading: isLoading)
        }).disposed(by: disposeBag)
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        artisanList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "artisanCell", for: indexPath) as? ArtisanTableViewCell {
            cell.viewModel = ArtisanViewModel(artisan: artisanList[indexPath.row])
            return cell
        }
        
        fatalError()
    }
    
    
}
