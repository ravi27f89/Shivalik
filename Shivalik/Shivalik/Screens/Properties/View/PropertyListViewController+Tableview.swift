import UIKit

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
