//
//  BannerViewCell.swift
//  Shivalik
//
//  Created by ravi maru on 01/09/24.
//

import UIKit

class BannerViewCell: UICollectionViewCell {
    // MARK: -  Outlets
    @IBOutlet weak var img: UIImageView!
    
    // MARK: - Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(withImage image: UIImage?) {
        img.image = image
    }

    func setDataForItem(){
        img.backgroundColor = .red
        img.image = UIImage(named: "Leased")
    }
}
