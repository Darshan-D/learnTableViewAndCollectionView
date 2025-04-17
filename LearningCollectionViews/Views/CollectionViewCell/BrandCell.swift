import UIKit

class BrandCell: UICollectionViewCell {
    static let reuseIdentifier = "BrandCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .lightGray // Default
        contentView.layer.cornerRadius = frame.width / 2 // Make it circular
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with color: UIColor) {
        contentView.backgroundColor = color
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        contentView.backgroundColor = .lightGray
    }
}
