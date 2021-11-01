//
//  FavouriteUsersViewController.swift
//  Randomco
//
//  Created by Víctor Jimenez on 1/11/21.
//

import UIKit

protocol FavouriteUsersViewController: AnyObject {
    var presenter: FavouriteUsersPresenter { get set }
    
    func reloadTable()
    func showErrorAlert()
}

class FavouriteUsersViewControllerDefault: UIViewController, StoryboardViewController {
    static var storyboardName: String = "FavouriteUsersView"
    
    @IBOutlet weak var tableView: UITableView!
    
    var presenter: FavouriteUsersPresenter = FavouriteUsersPresenterDefault()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.setView(view: self)
        
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        presenter.loadData()
    }
}

extension FavouriteUsersViewControllerDefault: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "UserListCell", for: indexPath) as? UserListCell else {
            return UITableViewCell()
        }
        
        cell.configCell(user: presenter.userForRow(row: indexPath.row))
        
        return cell
    }
}

extension FavouriteUsersViewControllerDefault: FavouriteUsersViewController {
    func reloadTable() {
        tableView.reloadData()
    }
    
    func showErrorAlert() {
        let okAction = UIAlertAction(title: "Ok", style: .default) { (action) in
            self.dismiss(animated: true, completion: nil)
        }
        
        let alerViewController = UIAlertController(title: "Error", message: "You haven't selected favourites", preferredStyle: .alert)
        alerViewController.addAction(okAction)
        present(alerViewController, animated: true, completion: nil)
    }
}
