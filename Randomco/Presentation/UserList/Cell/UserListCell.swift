//
//  UserListCell.swift
//  Randomco
//
//  Created by Víctor Jimenez on 31/10/21.
//

import UIKit

protocol UserListCellDelegate: AnyObject {
    func didDeleteUser(tag: Int)
    func didAddFavorite(tag: Int)
    func didTapCellImage(tag: Int)
}

class UserListCell: UITableViewCell {
    
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var favouriteButton: UIButton!
    
    weak var delegate: UserListCellDelegate?
    
    var isFavourite: Bool = false {
        didSet {
            favouriteIcon(isFavourite: isFavourite)
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        userImageView.image = nil
        nameLabel.text = ""
        emailLabel.text = ""
        phoneLabel.text = ""
        favouriteButton.setImage(nil, for: .normal)
    }
    
    func configCell(user: User) {
        nameLabel.text = user.fullName
        emailLabel.text = user.email
        phoneLabel.text = user.phone
        favouriteIcon(isFavourite: user.favourite)
        
        guard let url = URL(string: user.smallPicture) else {
            return
        }
        
        userImageView.load(url: url)
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
        userImageView.isUserInteractionEnabled = true
        userImageView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc func imageTapped() {
        delegate?.didTapCellImage(tag: tag)
    }
    
    @IBAction func didTapDeleteUser(_ sender: Any) {
        delegate?.didDeleteUser(tag: tag)
    }
    
    @IBAction func didTapAddFavourite(_ sender: Any) {
        isFavourite = !isFavourite
        delegate?.didAddFavorite(tag: tag)
    }
    
    private func favouriteIcon(isFavourite: Bool) {
        favouriteButton.setImage(UIImage(systemName: isFavourite ? "suit.heart.fill" : "suit.heart"), for: .normal)
    }
}
