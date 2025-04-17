import UIKit

class BrandsTableViewCell: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    static let reuseIdentifier = "BrandsTableViewCell"

    // --- Constants ---
    private let itemSize: CGFloat = 80 // Smaller items for 2 rows
    private let horizontalSpacing: CGFloat = 15
    private let verticalSpacing: CGFloat = 10
    private let sectionHorizontalInset: CGFloat = 15
    private let sectionVerticalInset: CGFloat = 5
    let titleHeight: CGFloat = 30
    let topPadding: CGFloat = 15
    let bottomPadding: CGFloat = 10

    // --- Data ---
    private var brandColors: [UIColor] = [
        .systemRed, .systemBlue, .systemGreen, .systemOrange,
        .systemPurple, .systemYellow, .systemTeal, .systemPink,
        .systemIndigo, .brown, .darkGray, .cyan
    ]

    // --- UI Elements ---
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Top Brands for you"
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold) // Slightly smaller title
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: itemSize, height: itemSize) // Use constant
        layout.minimumLineSpacing = horizontalSpacing
        layout.minimumInteritemSpacing = verticalSpacing
        layout.sectionInset = UIEdgeInsets(top: sectionVerticalInset, left: sectionHorizontalInset, bottom: sectionVerticalInset, right: sectionHorizontalInset)

        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.backgroundColor = .clear
        cv.showsHorizontalScrollIndicator = false
        cv.dataSource = self
        cv.delegate = self // Needed for layout delegate potentially
        cv.register(BrandCell.self, forCellWithReuseIdentifier: BrandCell.reuseIdentifier)
        return cv
    }()

    // --- Calculated Height ---
    var calculatedHeight: CGFloat {
        let totalItemHeight = itemSize * 2
        let totalVerticalSpacing = verticalSpacing
        let totalInsets = sectionVerticalInset * 2
        let collectionViewHeight = totalItemHeight + totalVerticalSpacing + totalInsets
        return topPadding + titleHeight + collectionViewHeight + bottomPadding
    }

    // --- Initializers ---
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none // Don't show selection highlight
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // --- Setup ---
    private func setupUI() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(collectionView)

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: topPadding),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: sectionHorizontalInset),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -sectionHorizontalInset),
            titleLabel.heightAnchor.constraint(equalToConstant: titleHeight),

            collectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -bottomPadding),
        ])
    }

    // --- UICollectionViewDataSource ---
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return brandColors.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BrandCell.reuseIdentifier, for: indexPath) as? BrandCell else {
            fatalError("Unable to dequeue BrandCell")
        }
        cell.configure(with: brandColors[indexPath.item])
         // Make sure corner radius is set correctly after layout
        cell.layer.cornerRadius = itemSize / 2
        return cell
    }

     // Optional: If you need delegate methods for the brand collection view
     // func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) { ... }
}
