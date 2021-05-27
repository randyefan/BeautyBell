//
//  DetailArtisanViewController.swift
//  BeautyBell
//
//  Created by Randy Efan Jayaputra on 27/05/21.
//

import UIKit

class DetailArtisanViewController: UIViewController {
    
    @IBOutlet weak var artisanImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var starStackView: UIStackView!
    @IBOutlet weak var serviceCollectionView: UICollectionView!
    
    let totalStar = 5
    
    var viewModel: ArtisanViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupView() {
        guard let viewModel = viewModel, let imageUrl = URL(string: viewModel.image) else { return }
        artisanImageView.load(url: imageUrl)
        setupStar(rating: viewModel.rating)
        nameLabel.text = viewModel.name
        
        title = "Detail"
        
        serviceCollectionView.delegate = self
        serviceCollectionView.dataSource = self
        serviceCollectionView.register(UINib(nibName: "ServiceCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ServiceCell")
        serviceCollectionView.reloadData()
    }
    
    func setupStar(rating: Int) {
        for i in 0..<totalStar {
            if i < rating {
                let imageView = UIImageView()
                let image = UIImage(systemName: "star.fill")
                imageView.image = image
                imageView.tintColor = .black
                starStackView.addArrangedSubview(imageView)
            } else {
                let imageView = UIImageView()
                let image = UIImage(systemName: "star")
                imageView.image = image
                imageView.tintColor = .black
                starStackView.addArrangedSubview(imageView)
            }
        }
    }
}

extension DetailArtisanViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel?.services.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ServiceCell", for: indexPath) as? ServiceCollectionViewCell {
            guard let viewModel = viewModel else { return UICollectionViewCell() }
            cell.viewModel = ServiceViewModel(service: viewModel.services[indexPath.row])
            return cell
        }
        fatalError()
    }
}
