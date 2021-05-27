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
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
