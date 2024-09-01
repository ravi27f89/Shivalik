import UIKit

class BannerViewCell: UICollectionViewCell {

    @IBOutlet weak var img: UIImageView!

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
