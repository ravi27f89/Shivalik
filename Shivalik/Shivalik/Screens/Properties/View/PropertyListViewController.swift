//
//  PropertyListViewController.swift
//  Shivalik
//
//  Created by krenil patel on 31/08/24.
//

import UIKit

class PropertyListViewController: UIViewController {

    // MARK: -  Outlets
    @IBOutlet weak var tblProperties: UITableView!
    @IBOutlet weak var collection: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var lblHeader: UILabel!
    @IBOutlet weak var viewBanner: UIView!
    @IBOutlet weak var lblNoDataFound: UILabel!
    
    private var viewModel: PropertyListViewModel!
    private let headerImageView = UIImageView()
    //private let searchBar = UISearchBar()
    let imageview = UIImageView()

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = PropertyListViewModel()
        viewModel.loadCategories()
        viewModel.loadProperties(at: pageControl.currentPage)
        
        setupCollView()
        setupTableView()
        setupHeaderView()
        
        pageControl.numberOfPages = viewModel.numberOfCategories
        pageControl.backgroundStyle = .prominent
    }
    

    // MARK: - Setup UI Operations
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
        
        // Adjust the tableHeaderView to match the new frame
         tblProperties.tableHeaderView = viewBanner
    }
}

// MARK: - Table View - Datasource - Delegate
extension PropertyListViewController: UITableViewDataSource , UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if viewModel.isEmptyArr{
            lblNoDataFound.isHidden = false
        } else {
            lblNoDataFound.isHidden = true
        }
        return viewModel.numberOfProperties
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PropertyInfoCell", for: indexPath) as? PropertyInfoCell else {
            return UITableViewCell()
        }

        let userViewModel = viewModel.properties(at: indexPath.row)
        let image = UIImage(named: userViewModel.image)
        cell.configure(withImage: image, title: userViewModel.title, subtitle: userViewModel.description)
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Search"
        searchBar.sizeToFit()
        searchBar.backgroundColor = .white
        searchBar.delegate = self
        let headerView = UIView()
        headerView.addSubview(searchBar)
        
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            searchBar.leadingAnchor.constraint(equalTo: headerView.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: headerView.trailingAnchor),
            searchBar.topAnchor.constraint(equalTo: headerView.topAnchor),
            searchBar.bottomAnchor.constraint(equalTo: headerView.bottomAnchor)
        ])
        return headerView
    }
}

// MARK: - Collectionview  - Datasource  - Delegate
extension PropertyListViewController: UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfCategories
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BannerViewCell", for: indexPath) as! BannerViewCell

        let userViewModel = viewModel.categories(at: indexPath.row)
        let image = UIImage(named: userViewModel.image)
        cell.configure(withImage: image)
        cell.backgroundColor = .brown
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //return CGSize(width: self.view.frame.width, height: 200)
        return collection.bounds.size
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    @IBAction func pageControlValueChanges(_ sender: UIPageControl) {
        collection.scrollToItem(at: IndexPath(row: sender.currentPage, section: 0), at: .centeredHorizontally, animated: true)
        viewModel.loadProperties(at: pageControl.currentPage)
        lblHeader.text = viewModel.categories(at: pageControl.currentPage).title
        
        tblProperties.reloadData()
        
    }
    
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
       let visibleRect = CGRect(origin: collection.contentOffset, size: collection.bounds.size)
       let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
       if let visibleIndexPath = collection.indexPathForItem(at: visiblePoint) {
           self.pageControl.currentPage = visibleIndexPath.row
           viewModel.loadProperties(at: pageControl.currentPage)
           lblHeader.text = viewModel.categories(at: pageControl.currentPage).title
//           if viewModel.isEmptyArr{
//               lblNoDataFound.isHidden = false
//           }

           tblProperties.reloadData()
       }
    }
}

// MARK: - Search method

extension PropertyListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty{
            searchBar.endEditing(true)
        }
        viewModel.search(at: searchText)
//        if viewModel.isEmptyArr{
//            lblNoDataFound.isHidden = false
//        }
        tblProperties.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar){
       searchBar.endEditing(true)
    }
}

// MARK: - Button Action

extension PropertyListViewController {
    @IBAction func btnMenuClicked(sender: UIButton){
        
        let alert = UIAlertController(title: lblHeader.text, message: viewModel.fetchOccurance(), preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler:{ (UIAlertAction)in
        }))
        self.present(alert, animated: true, completion: {
        })
    }
}

