import UIKit

class PropertyListViewController: UIViewController {

    @IBOutlet weak var tblProperties: UITableView!
    @IBOutlet weak var collection: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var lblHeader: UILabel!
    @IBOutlet weak var viewBanner: UIView!
    @IBOutlet weak var lblNoDataFound: UILabel!
    
    var viewModel: PropertyListViewModel!
    private let headerImageView = UIImageView()
    let imageview = UIImageView()

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = PropertyListViewModel()
        viewModel.loadCategories()
        viewModel.loadProperties(at: pageControl.currentPage)

        setupUI()

        pageControl.numberOfPages = viewModel.numberOfCategories
        pageControl.backgroundStyle = .prominent
    }
    
    private func setupUI(){
        setupCollView()
        setupTableView()
        setupHeaderView()
    }
    
    private func setupCollView() {
        collection?.register(UINib(nibName: "BannerViewCell", bundle: nil), forCellWithReuseIdentifier: "BannerViewCell")
        collection.reloadData()
    }

    private func setupTableView() {
        lblHeader.text = viewModel.categories(at: pageControl.currentPage).title
        tblProperties.tableHeaderView = viewBanner
        tblProperties.register(UINib(nibName: "PropertyInfoCell", bundle: nil), forCellReuseIdentifier: "PropertyInfoCell")
    }
    
    private func setupHeaderView() {
        tblProperties.tableHeaderView = viewBanner
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let minHeight: CGFloat = 100
        let maxHeight: CGFloat = 200
        let newHeight = max(maxHeight - offsetY, minHeight)
        
        var headerFrame = viewBanner.frame
        headerFrame.size.height = newHeight
        viewBanner.frame = headerFrame
        tblProperties.tableHeaderView = viewBanner
    }
}

extension PropertyListViewController {
    @IBAction func btnMenuClicked(sender: UIButton){
        
        let alert = UIAlertController(title: lblHeader.text, message: viewModel.fetchOccurance(), preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler:{ (UIAlertAction)in
        }))
        self.present(alert, animated: true, completion: {
        })
    }
}
