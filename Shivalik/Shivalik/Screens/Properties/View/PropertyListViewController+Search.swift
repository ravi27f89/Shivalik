import UIKit

extension PropertyListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty{
            searchBar.endEditing(true)
        }
        viewModel.search(at: searchText)
        tblProperties.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar){
       searchBar.endEditing(true)
    }
}
