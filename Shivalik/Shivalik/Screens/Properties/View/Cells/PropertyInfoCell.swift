//
//  PropertyInfoCell.swift
//  Shivalik
//
//  Created by krenil patel on 31/08/24.
//

import UIKit

class PropertyInfoCell: UITableViewCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBOutlet weak var propertyImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
   
    
    // Configure cell with data
    func configure(withImage image: UIImage?, title: String, subtitle: String) {
        propertyImageView.image = image
        titleLabel.text = title
        subtitleLabel.text = subtitle
    }
}
