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
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
    
}

extension NotificationsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        return cell
    }
    
    
}
