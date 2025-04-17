import UIKit

class MunchiesTableViewCell: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    static let reuseIdentifier = "MunchiesTableViewCell"

    // --- Constants ---
    private let itemWidth: CGFloat = 150 // Wider items
    private let itemHeight: CGFloat = 100
    private let horizontalSpacing: CGFloat = 15
    private let sectionHorizontalInset: CGFloat = 15
    private let sectionVerticalInset: CGFloat = 5
    let titleHeight: CGFloat = 30
    let topPadding: CGFloat = 20 // More space before this section
    let bottomPadding: CGFloat = 10

    // --- Data ---
    private var munchieColors: [UIColor] = [
        .systemGray, .systemGray2, .systemGray3, .systemGray4, .systemGray5, .systemGray6
    ]

    // --- UI Elements ---
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Quick checkout munchies"
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: itemWidth, height: itemHeight) // Rectangular items
        layout.minimumLineSpacing = horizontalSpacing
        layout.minimumInteritemSpacing = 0 // Not relevant for single row
        layout.sectionInset = UIEdgeInsets(top: sectionVerticalInset, left: sectionHorizontalInset, bottom: sectionVerticalInset, right: sectionHorizontalInset)

        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.backgroundColor = .clear
        cv.showsHorizontalScrollIndicator = false
        cv.dataSource = self
        cv.delegate = self
        cv.register(MunchieCell.self, forCellWithReuseIdentifier: MunchieCell.reuseIdentifier)
        return cv
    }()

    // --- Calculated Height ---
     var calculatedHeight: CGFloat {
        let collectionViewHeight = itemHeight + (sectionVerticalInset * 2)
        return topPadding + titleHeight + collectionViewHeight + bottomPadding
    }

    // --- Initializers ---
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
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
        return munchieColors.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MunchieCell.reuseIdentifier, for: indexPath) as? MunchieCell else {
            fatalError("Unable to dequeue MunchieCell")
        }
        cell.configure(with: munchieColors[indexPath.item])
        return cell
    }
}
