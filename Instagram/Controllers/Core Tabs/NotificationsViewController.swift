//
//  NotificationsViewController.swift
//  Instagram
//
//  Created by Punreach Rany on 2021/05/02.
//

import UIKit

class NotificationsViewController: UIViewController {
    

    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.isHidden = false
        tableView.register(NotificationLikeEventTableViewCell.self, forCellReuseIdentifier: NotificationLikeEventTableViewCell.identifier)
        tableView.register(NotificationFollowEventTableViewCell.self, forCellReuseIdentifier: NotificationFollowEventTableViewCell.identifier)
        return tableView
    }()
    
    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.hidesWhenStopped = true
        spinner.tintColor = .label
        return spinner
    }()
    
    private lazy var noNotificationsView = NoNotificationsView()
    
    private var models = [UserNotification]()
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchNotifications()
        navigationItem.title = "Notifications"
        view.backgroundColor = .systemBackground
        
        view.addSubview(spinner) 
//        spinner.startAnimating()
        view.addSubview(tableView)
        
//        view.addSubview(noNotificationsView)
        
        tableView.delegate = self
        tableView.dataSource = self

        // Do any additional setup after loading the view.
    }
    
    private func fetchNotifications(){
        for x in 0...100 {
            let post = UserPost(identifier: "",
                                postType: .photo,
                                thumbnailImage: URL(string: "https://avatars.githubusercontent.com/u/54469196?s=60&v=4")!,
                                postURL: URL(string: "https://avatars.githubusercontent.com/u/54469196?s=60&v=4")!,
                                caption: nil,
                                likeCount: [],
                                comments: [],
                                createdDate: Date(),
                                taggedUsers: [])
            let model = UserNotification(
                type: x % 2 == 0 ? .like(post: post) : .follow(state: .not_following),
                text: "Hello World",
                user: User(username: "Joe",
                           name: (first: "", last: ""),
                           birthDate: Date(),
                           gender: .male,
                           counts: UserCount(followers: 1, following: 1, posts: 1),
                           joinedDate: Date(),
                           profilePhoto: URL(string: "https://avatars.githubusercontent.com/u/54469196?s=60&v=4")!
                ))
            
            models.append(model)
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
        spinner.frame = CGRect(x: 0,
                               y: 0,
                               width: 100,
                               height: 100)
        spinner.center = view.center
        
    }
    
    private func addNoNotificationsView(){
        tableView.isHidden = true
        noNotificationsView.frame = CGRect(x: 0,
                                           y: 0,
                                           width: view.width / 2,
                                           height: view.width / 4)
        noNotificationsView.center = view.center
    }

}

extension NotificationsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 52
    }
}

extension NotificationsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = models[indexPath.row]
        
        switch model.type {
        case .like(_):
            // like cell
            let cell = tableView.dequeueReusableCell(withIdentifier: NotificationLikeEventTableViewCell.identifier, for: indexPath) as! NotificationLikeEventTableViewCell
            cell.configure(with: model)
            cell.delegate = self
            return cell
        case .follow:
            // follow cell
            let cell = tableView.dequeueReusableCell(withIdentifier: NotificationFollowEventTableViewCell.identifier, for: indexPath) as! NotificationFollowEventTableViewCell
            cell.configure(with: model)
            cell.delegate = self
            return cell
        
        }
    }
    
    
}

//MARK: - NotificationLikeEventTableViewCellDelegate
extension NotificationsViewController: NotificationLikeEventTableViewCellDelegate {
    func didTapRelatedPostButton(model: UserNotification) {
        print("Tapped post [didTapRelatedPostButton]")
        // Open the post
    }
}

//MARK: - NotificationLikeEventTableViewCellDelegate
extension NotificationsViewController: NotificationFollowEventTableViewCellDelegate {
    func didTapFollowUnFollowButton(model: UserNotification) {
        print("Tapped post [didTapFollowUnFollowButton]")
        // Perform Database Update
    }
    
}
