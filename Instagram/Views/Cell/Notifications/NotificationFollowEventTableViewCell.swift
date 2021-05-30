//
//  NotificationFollowEventTableViewCell.swift
//  Instagram
//
//  Created by elite on 2021/05/24.
//

import UIKit

protocol NotificationFollowEventTableViewCellDelegate : AnyObject{
    func didTapFollowUnFollowButton(model: UserNotification)
}

class NotificationFollowEventTableViewCell: UITableViewCell {
    
    static let identifier = "NotificationFollowEventTableViewCell"
    
    weak var delegate: NotificationFollowEventTableViewCellDelegate?
    
    private var model: UserNotification?
    
    private let profileImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .tertiarySystemBackground
    
        return imageView
    }()
    
    private let label: UILabel = {
       let label = UILabel()
        label.textColor = .label
        label.numberOfLines = 0
        label.text = "@Lucifer started following you"
        return label
    }()
    
    private let followButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 5
        button.layer.masksToBounds = true
        return button
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.clipsToBounds = true
        contentView.addSubview(profileImageView)
        contentView.addSubview(label)
        contentView.addSubview(followButton)
        followButton.addTarget(self, action: #selector(didTapFollowButton), for: .touchUpInside)
        configureForFollow()
        configureForUnfollow()
        selectionStyle = .none
    }
    
    @objc private func didTapFollowButton() {
        guard let model = model else {
            return
        }
        
        delegate?.didTapFollowUnFollowButton(model: model)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // photo, text, post button
        profileImageView.frame = CGRect(x: 3, y: 3, width: contentView.height-6, height: contentView.height-6)
        profileImageView.layer .cornerRadius = profileImageView.height/2
        
        let size : CGFloat = 100
        let buttonHeight : CGFloat = 30
        followButton.frame = CGRect(x: contentView.width - 5 - size,
                                    y: (contentView.height - buttonHeight)/2,
                                    width: size,
                                    height: buttonHeight)
        
        label.frame = CGRect(x: profileImageView.right,
                             y: 0,
                             width: contentView.width-size-profileImageView.width,
                             height: contentView.height)
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        followButton.setTitle(nil, for: .normal)
        followButton.backgroundColor = nil
        followButton.layer.borderWidth = 0
        label.text = nil
        profileImageView.image = nil
    }
    
    public func configure(with model: UserNotification){
        self.model = model
        
        
        switch model.type {
        case .like(_):
//            var thumbnail : UIImage?
//            getImageData(from: post.thumbnailImage) { data, response, error in
//                guard let data = data, error == nil else {
//                    return
//                }
//                DispatchQueue.main.async() { [weak self] in
//                    thumbnail = UIImage(data: data)
//
//                }
//            }
//            postButton.setBackgroundImage(thumbnail, for: .normal)
        break
            
        case .follow(let state):
            // configure button
            switch state {
            case .following:
                // show unfollow button
                configureForFollow()
                
            case .not_following:
                // show follow button
                configureForUnfollow()
                
                
            }
            break
        }
        
//        label.text = model.text
        FutureCall().getImageData(from: model.user.profilePhoto) { data, response, error in
            guard let data = data, error == nil else {
                return
            }
            DispatchQueue.main.async() { [weak self] in
                self?.profileImageView.image = UIImage(data: data)
                
            }
        }
    }
    
    private func configureForFollow(){
        followButton.setTitle("Unfollow", for: .normal)
        followButton.setTitleColor(.label, for: .normal)
        followButton.layer.borderWidth = 1
        followButton.layer.borderColor = UIColor.secondaryLabel.cgColor
    }
    
    private func configureForUnfollow(){
        followButton.setTitle("Follow", for: .normal)
        followButton.setTitleColor(.white, for: .normal)
        followButton.layer.borderWidth = 0
        followButton.backgroundColor = .link
    }
    
//    public func getImageData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
//        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
//    }
    
}
