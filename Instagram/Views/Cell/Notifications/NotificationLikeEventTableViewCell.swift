//
//  NotificationLikeEventTableViewCell.swift
//  Instagram
//
//  Created by elite on 2021/05/24.
//

import UIKit

protocol NotificationLikeEventTableViewCellDelegate : AnyObject{
    func didTapRelatedPostButton(model: UserNotification)
}

class NotificationLikeEventTableViewCell: UITableViewCell {

    static let identifier = "NotificationLikeEventTableViewCell"
    
    weak var delegate: NotificationLikeEventTableViewCellDelegate?
    
    private var model: UserNotification?
    
    private let profileImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.backgroundColor = .tertiarySystemBackground
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "test")
        return imageView
    }()
    
    private let label: UILabel = {
       let label = UILabel()
        label.textColor = .label
        label.text = "@punreach liked your photo"
        label.numberOfLines = 0
        return label
    }()
    
    private let postButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(named: "test"), for: .normal)
        return button
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.clipsToBounds = true
        contentView.addSubview(profileImageView)
        contentView.addSubview(label)
        contentView.addSubview(postButton)
        postButton.addTarget(self, action:
                                #selector(didTapPostButton),
                             for: .touchUpInside)
        selectionStyle = .none
    }
    
    @objc private func didTapPostButton() {
        guard let model = model else {
            return
        }
        
        delegate?.didTapRelatedPostButton(model: model)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // photo, text, post button
        profileImageView.frame = CGRect(x: 3, y: 3, width: contentView.height-6, height: contentView.height-6)
        profileImageView.layer.cornerRadius = profileImageView.height/2
        
        let size = contentView.height - 4
        postButton.frame = CGRect(x: contentView.width - 5 - size, y: 0, width: size, height: size)
        
        label.frame = CGRect(x: profileImageView.right,
                             y: 0,
                             width: contentView.width-size-profileImageView.width,
                             height: contentView.height)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()

        postButton.setBackgroundImage(nil, for: .normal)

        profileImageView.image = nil
    }
    
    public func configure(with model: UserNotification){
        self.model = model
        
        
        switch model.type {
        case .like(let post):
            var thumbnail : UIImage?
            FutureCall().getImageData(from: post.thumbnailImage) { data, response, error in
                guard let data = data, error == nil else {
                    return
                }
                DispatchQueue.main.async() { [weak self] in
                    thumbnail = UIImage(data: data)
                    
                }
            }
//            postButton.setBackgroundImage(thumbnail, for: .normal)
            
        case .follow:
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
    
//    public func getImageData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
//        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
//    }

}
