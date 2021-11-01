//
//  UserListViewController.swift
//  Randomco
//
//  Created by Víctor Jimenez on 30/10/21.
//

import UIKit

protocol UserListViewController: AnyObject {
    var presenter: UserListPresenter { get set }
    
    func reloadTable()
    func showErrorAlert()
    func navigateToDetail(user: User)
    func navigateToFavourites(users: [User])
}

class UserListViewControllerDefault: UIViewController, StoryboardViewController {
    static var storyboardName: String = "UserListView"
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var moreUsersButton: UIButton!
    @IBOutlet weak var showFavouritesButton: UIButton!
    
    var presenter: UserListPresenter = UserListPresenterDefault()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.setView(view: self)
        
        searchBar.delegate = self
        
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    @IBAction func didTapMoreUsers(_ sender: Any) {
        presenter.getUsers()
    }
    
    @IBAction func didTapShowFavouritesButton(_ sender: Any) {
        presenter.navigateToFavourites()
    }
}

extension UserListViewControllerDefault: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "UserListCell", for: indexPath) as? UserListCell else {
            return UITableViewCell()
        }
        
        cell.configCell(user: presenter.userForRow(row: indexPath.row))
        cell.tag = indexPath.row
        cell.delegate = self
        
        return cell
    }
}

extension UserListViewControllerDefault: UserListCellDelegate {
    func didDeleteUser(tag: Int) {
        presenter.deleteUser(row: tag)
    }
    
    func didAddFavorite(tag: Int) {
        presenter.addFavouriteUser(row: tag)
    }
    
    func didTapCellImage(tag: Int) {
        presenter.navigateToDetail(row: tag)
    }
}

extension UserListViewControllerDefault: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        presenter.filterUsersByText(filter: searchBar.text ?? "")
        self.searchBar.endEditing(true)
    }
}

extension UserListViewControllerDefault: UserListViewController {
    func reloadTable() {
        tableView.reloadData()
    }
    
    func showErrorAlert() {
        let okAction = UIAlertAction(title: "Ok", style: .default)
        let alerViewController = UIAlertController(title: "Error", message: "There was a problem while retrieving the users list", preferredStyle: .alert)
        alerViewController.addAction(okAction)
        present(alerViewController, animated: true, completion: nil)
    }
    
    func navigateToDetail(user: User) {
        DispatchQueue.main.async(execute: {
            let userDetailVC  = UserDetailViewControllerDefault.initFromStoryboard()
            userDetailVC.presenter.user = user
            self.present(userDetailVC, animated: true, completion: nil)
        })
    }
    
    func navigateToFavourites(users: [User]) {
        DispatchQueue.main.async(execute: {
            let favouritesVC  = FavouriteUsersViewControllerDefault.initFromStoryboard()
            favouritesVC.presenter.favouriteUsers = users
            self.present(favouritesVC, animated: true, completion: nil)
        })
    }
}
