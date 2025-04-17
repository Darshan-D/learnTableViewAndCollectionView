import UIKit

class MainViewController: UIViewController {

    // --- UI Elements ---
    private lazy var tableView: UITableView = {
        let tv = UITableView(frame: .zero, style: .plain)
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.dataSource = self
        tv.delegate = self
        tv.separatorStyle = .none // Hide default separators
        tv.backgroundColor = .white // Background for the table view area
        tv.showsVerticalScrollIndicator = false

        // Register custom cells
        tv.register(BrandsTableViewCell.self, forCellReuseIdentifier: BrandsTableViewCell.reuseIdentifier)
        tv.register(MunchiesTableViewCell.self, forCellReuseIdentifier: MunchiesTableViewCell.reuseIdentifier)

        return tv
    }()

    // Store calculated heights to avoid recalculating in heightForRowAt
    private lazy var brandsCellHeight: CGFloat = BrandsTableViewCell().calculatedHeight
    private lazy var munchiesCellHeight: CGFloat = MunchiesTableViewCell().calculatedHeight


    // --- Lifecycle ---
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white // Background for the whole view controller
        navigationController?.title = "Zomato Clone"
        setupUI()
    }

    // --- Setup ---
    private func setupUI() {
        view.addSubview(tableView)

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

// MARK: - UITableViewDataSource
extension MainViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1 // Only one section containing our different row types
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2 // One row for brands, one for munchies
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if indexPath.row == 0 { // First row: Brands
            guard let cell = tableView.dequeueReusableCell(withIdentifier: BrandsTableViewCell.reuseIdentifier, for: indexPath) as? BrandsTableViewCell else {
                fatalError("Could not dequeue BrandsTableViewCell")
            }
            // Configuration logic could go here if data was passed from VC
            return cell

        } else if indexPath.row == 1 { // Second row: Munchies
            guard let cell = tableView.dequeueReusableCell(withIdentifier: MunchiesTableViewCell.reuseIdentifier, for: indexPath) as? MunchiesTableViewCell else {
                fatalError("Could not dequeue MunchiesTableViewCell")
            }
            // Configuration logic could go here
            return cell

        } else {
            // Should not happen with numberOfRowsInSection = 2
            return UITableViewCell()
        }
    }
}

// MARK: - UITableViewDelegate
extension MainViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // Return the pre-calculated height for each cell type
        if indexPath.row == 0 {
            return brandsCellHeight
        } else if indexPath.row == 1 {
            return munchiesCellHeight
        } else {
            return UITableView.automaticDimension // Fallback, though shouldn't be needed
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Tapped row: \(indexPath.row)") // For debugging
        
        // Deselect the row visually
        tableView.deselectRow(at: indexPath, animated: true)
        
        // Create the simple view controller instance
        let detailVC = SimpleDetailViewController() // Or: UIViewController()
        
        // Set background color based on which row was tapped (optional)
        if indexPath.row == 0 { // Tapped on Brands section
            detailVC.view.backgroundColor = .systemRed
            detailVC.title = "Brands Section Detail" // More specific title
        } else { // Tapped on Munchies section
            detailVC.view.backgroundColor = .systemYellow
            detailVC.title = "Munchies Section Detail" // More specific title
        }
        
        // --- Navigation ---
        // Option 1: Push if embedded in a UINavigationController
        if let navController = self.navigationController {
            navController.pushViewController(detailVC, animated: true)
        }
        // Option 2: Present modally if not using a Navigation Controller
        else {
            print("Presenting modally as no Navigation Controller found.")
            detailVC.modalPresentationStyle = .fullScreen // Or .automatic, etc.
            self.present(detailVC, animated: true, completion: nil)
        }
    }
}
