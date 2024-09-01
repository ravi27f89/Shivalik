import UIKit

class PropertyInfoCell: UITableViewCell {
    
    @IBOutlet weak var propertyImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
   
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func configure(withImage image: UIImage?, title: String, subtitle: String) {
        propertyImageView.image = image
        titleLabel.text = title
        subtitleLabel.text = subtitle
    }
}
