//
//  ArtisanTableViewCell.swift
//  BeautyBell
//
//  Created by Fardan on 27/05/21.
//

import UIKit

class ArtisanTableViewCell: UITableViewCell {
    
    @IBOutlet weak var artisanImageView: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var viewModel: ArtisanViewModel? {
        didSet {
            guard let viewModel = viewModel, let imageUrl = URL(string: viewModel.image) else { return }
            self.artisanImageView.load(url: imageUrl)
            self.name.text = viewModel.name
            self.descriptionLabel.text = viewModel.description
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
