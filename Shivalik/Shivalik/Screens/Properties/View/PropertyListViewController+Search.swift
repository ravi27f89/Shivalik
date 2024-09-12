import UIKit

extension PropertyListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty{
            searchBar.endEditing(true)
            isSearching = false
        }
        isSearching = true
        viewModel.search(at: searchText, index: pageControl.currentPage)
        viewModel.searchText = searchText
        tblProperties.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar){
        isSearching = false
        viewModel.searchText = ""
        searchBar.searchTextField.text = ""
       searchBar.endEditing(true)
    }
}
