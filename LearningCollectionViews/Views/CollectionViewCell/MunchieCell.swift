import UIKit

class MunchieCell: UICollectionViewCell {
    static let reuseIdentifier = "MunchieCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .darkGray // Default
        contentView.layer.cornerRadius = 10 // Rounded rectangle
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with color: UIColor) {
        contentView.backgroundColor = color
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        contentView.backgroundColor = .darkGray
    }
}
