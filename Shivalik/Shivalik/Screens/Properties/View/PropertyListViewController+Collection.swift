import UIKit

extension PropertyListViewController: UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.response?.category.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BannerViewCell", for: indexPath) as! BannerViewCell
        let userViewModel = viewModel.response?.category[indexPath.row]
        let image = UIImage(named: userViewModel?.image ?? "")
        cell.configure(withImage: image)
        cell.backgroundColor = .brown
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collection.bounds.size
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    @IBAction func pageControlValueChanges(_ sender: UIPageControl) {
        collection.scrollToItem(at: IndexPath(row: sender.currentPage, section: 0), at: .centeredHorizontally, animated: true)
        viewModel.fetchProperty(at: pageControl.currentPage)
        lblHeader.text = viewModel.response?.category[pageControl.currentPage].title ?? ""
        isSearching = false
        self.view.endEditing(true)
        tblProperties.reloadData()
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
       let visibleRect = CGRect(origin: collection.contentOffset, size: collection.bounds.size)
       let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
       if let visibleIndexPath = collection.indexPathForItem(at: visiblePoint) {
           self.pageControl.currentPage = visibleIndexPath.row
           viewModel.fetchProperty(at: pageControl.currentPage)
           lblHeader.text = viewModel.response?.category[pageControl.currentPage].title ?? ""
           isSearching = false
           tblProperties.reloadData()
       }
    }
}
