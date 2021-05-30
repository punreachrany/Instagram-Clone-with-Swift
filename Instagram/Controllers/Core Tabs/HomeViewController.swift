//
//  ViewController.swift
//  Instagram
//
//  Created by Punreach Rany on 2021/05/02.
//

import UIKit
import Firebase

class HomeViewController: UIViewController {
    
    private var feedRenderModels = [HomeFeedRenderViewModel]()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        
        // Register Cell
        tableView.register(
            IGFeedPostTableViewCell.self,
            forCellReuseIdentifier: IGFeedPostTableViewCell.identifier)
        tableView.register(
            IGFeedPostHeaderTableViewCell.self,
            forCellReuseIdentifier: IGFeedPostHeaderTableViewCell.identifier)
        tableView.register(
            IGFeedPostActionTableViewCell.self,
            forCellReuseIdentifier: IGFeedPostActionTableViewCell.identifier)
        tableView.register(
            IGFeedPostGeneralTableViewCell.self,
            forCellReuseIdentifier: IGFeedPostGeneralTableViewCell.identifier)
        
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        handleNotAuthenticated()
        
    }
    
    private func handleNotAuthenticated() {
        // Check auth Status
        
        
        if Auth.auth().currentUser == nil {
            // Show log in
            let loginVC = LoginViewController()
            loginVC.modalPresentationStyle = .fullScreen
            present(loginVC, animated: false)
        }
        //        print("=== \(Auth.auth().currentUser)===")
    }
    
    
}

extension HomeViewController: UITableViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 0
    }
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostTableViewCell.identifier, for: indexPath)
        
        return cell
    }
}

