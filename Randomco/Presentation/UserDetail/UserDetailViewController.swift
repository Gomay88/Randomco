//
//  UserDetailViewController.swift
//  Randomco
//
//  Created by Víctor Jimenez on 31/10/21.
//

import UIKit

protocol UserDetailViewController: AnyObject {
    var presenter: UserDetailPresenter { get set }
    
    func configureView(user: User)
}

class UserDetailViewControllerDefault: UIViewController, StoryboardViewController {
    static var storyboardName: String = "UserDetailView"
    
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var registeredLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    var presenter: UserDetailPresenter = UserDetailPresenterDefault()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.setView(view: self)
    }
}

extension UserDetailViewControllerDefault: UserDetailViewController {
    func configureView(user: User) {
        genderLabel.text = user.gender.rawValue
        nameLabel.text = user.fullName
        locationLabel.text = user.fullStreet
        registeredLabel.text = user.registeredDate
        emailLabel.text = user.email
        
        guard let url = URL(string: user.largePicture) else {
            return
        }
        userImageView.load(url: url)
    }
}
