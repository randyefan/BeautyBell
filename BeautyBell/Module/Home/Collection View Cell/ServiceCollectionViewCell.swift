//
//  ServiceCollectionViewCell.swift
//  BeautyBell
//
//  Created by Fardan on 27/05/21.
//

import UIKit

class ServiceCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var serviceName: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var captionLabel: UILabel!
    
    var viewModel: ServiceViewModel? {
        didSet {
            guard let viewModel = viewModel else { return }
            serviceName.text = viewModel.name
            price.text = "\(viewModel.price)".toCurrencyFormat()
            captionLabel.text = viewModel.caption
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

}
