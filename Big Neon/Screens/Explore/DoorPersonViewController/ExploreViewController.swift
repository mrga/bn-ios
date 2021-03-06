
import UIKit
import Big_Neon_UI
import Big_Neon_Core

final class DoorPersonViewController: BaseViewController, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UISearchResultsUpdating, UISearchBarDelegate {
    
    internal lazy var refresher: UIRefreshControl = {
        let refresher = UIRefreshControl()
        refresher.tintColor = UIColor.brandGrey
        refresher.addTarget(self, action: #selector(reloadEvents), for: .valueChanged)
        return refresher
    }()

    internal lazy var exploreCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = 20.0
        flowLayout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.backgroundColor = UIColor.brandBackground
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.alwaysBounceVertical = true
        collectionView.allowsSelection = true
        collectionView.showsVerticalScrollIndicator = true
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    internal lazy var searchController: UISearchController = {
        let search = UISearchController(searchResultsController: nil)
        search.obscuresBackgroundDuringPresentation = false
        search.searchBar.placeholder = "Search artists, shows, venues…"
        search.searchBar.scopeButtonTitles = nil
        search.searchBar.scopeBarBackgroundImage = nil
        search.searchBar.backgroundImage = nil
        search.searchBar.backgroundImage(for: UIBarPosition.bottom, barMetrics: UIBarMetrics.default)
        search.searchBar.barStyle = .default
        definesPresentationContext = true
        search.searchBar.delegate = self
        search.searchResultsUpdater = self
        return search
    }()
    
    internal lazy var userProfileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleShowProfile)))
        imageView.image = UIImage(named: "ic_profilePicture")
        imageView.isUserInteractionEnabled = true
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureNavBar()
        self.view.backgroundColor = UIColor.white
        self.configureSearch()
        self.fetchCheckins()
    }

    private func fetchCheckins() {
        self.loadingView.startAnimating()
        //  Check if there is internet connectivity
        if Reachability.isConnectedToNetwork() {
            self.doorPersonViemodel.configureAccessToken { [weak self] (completed) in
                DispatchQueue.main.async {
                    self?.loadingView.stopAnimating()
                    if completed == false {
                        print(completed)
                        return
                    }
                    self?.configureCollectionView()
                }
            }
        } else {
            print("Internet Connection is UnAvaiable")
            //  Fetch Events Locally
        }
        
    }

    @objc private func reloadEvents() {
        self.doorPersonViemodel.configureAccessToken { [weak self] (completed) in
            DispatchQueue.main.async {
                self?.loadingView.stopAnimating()
                self?.refresher.endRefreshing()
                
                if completed == false {
                    self?.exploreCollectionView.reloadData()
                    print("Failed to Reload View")
                    return
                }
                self?.exploreCollectionView.reloadData()
                return
            }
        }
    }
    
    private func configureSearch() {
//        self.navigationItem.searchController = searchController   //  TO BE ADDED LATER
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationNoLineBar()
    }

    private func configureNavBar() {
        self.navigationNoLineBar()
        self.navigationItem.title = "My Events"
        userProfileImageView.widthAnchor.constraint(equalToConstant: 30.0).isActive = true
        userProfileImageView.heightAnchor.constraint(equalToConstant: 30.0).isActive = true
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: userProfileImageView)
    }

    private func configureCollectionView() {
        view.addSubview(exploreCollectionView)
        exploreCollectionView.refreshControl = self.refresher
        exploreCollectionView.register(SectionHeaderCell.self, forCellWithReuseIdentifier: SectionHeaderCell.cellID)
        exploreCollectionView.register(HotThisWeekCell.self, forCellWithReuseIdentifier: HotThisWeekCell.cellID)
        exploreCollectionView.register(DoorPersonCell.self, forCellWithReuseIdentifier: DoorPersonCell.cellID)
        
        exploreCollectionView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        exploreCollectionView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        exploreCollectionView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        exploreCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }

    internal func showEvent(event: Event) {
        let eventDetailVC = EventDetailViewController()
        eventDetailVC.eventDetailViewModel.event = event
        eventDetailVC.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(eventDetailVC, animated: true)
    }
    
    @objc private func handleLogout() {
        self.doorPersonViemodel.handleLogout { (_) in
            let welcomeVC = UINavigationController(rootViewController: WelcomeViewController())
            welcomeVC.modalTransitionStyle = .flipHorizontal
            self.present(welcomeVC, animated: true, completion: nil)
            return
        }
    }
    
    @objc private func handleShowProfile() {
        self.navigationController?.push(ProfileViewController())
    }
    
    internal func showScanner(forTicketIndex ticketIndex: Int) {
        guard let events = self.doorPersonViemodel.events?.data else {
            return
        }
        let scannerVC = ScannerViewController()
        scannerVC.event = events[ticketIndex]
        let scannerNavVC = UINavigationController(rootViewController: scannerVC)
        self.present(scannerNavVC, animated: true, completion: nil)
    }

}

