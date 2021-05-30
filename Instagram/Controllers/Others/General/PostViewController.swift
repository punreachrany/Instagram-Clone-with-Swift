//
//  PostViewController.swift
//  Instagram
//
//  Created by Punreach Rany on 2021/05/02.
//

import UIKit

class PostViewController: UIViewController {
    
    private var model: UserPost?
    
    private var renderModels = [PostRenderViewModel]()
    
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
    
    //MARK: - init
    
    init(model: UserPost?){
        
        self.model = model
        super.init(nibName: nil, bundle: nil)
        configureModels()
    }
    
    private func configureModels(){
        
        guard let userPostModel = self.model else {
            return
        }
        // Header
        renderModels.append(PostRenderViewModel(renderType: .header(provider: userPostModel.owner)))
        
        // Post
        renderModels.append(PostRenderViewModel(renderType: .primaryContent(provider: userPostModel)))
        
        // Actions
        renderModels.append(PostRenderViewModel(renderType: .actions(provider: "")))
        
        // 4 Comments
        var comments = [PostComment]()
        for x in 0..<4 {
            comments.append(PostComment(identifier: "123_\(x)",
                                        username: "@Dave",
                                        text: "Great Post",
                                        createdDate: Date(),
                                        likes: []))
        }
        renderModels.append(PostRenderViewModel(renderType: .comments(comments: comments)))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /*
     Section
     - Header Model
     
     Section
     - Post Cell Model
     
     Section
     - Action Buttons Cell Model
     
     Section
     - n Number of General models for comments
     
     */
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        view.backgroundColor = .systemBackground
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
}

extension PostViewController: UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return renderModels.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension PostViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch renderModels[section].renderType {
        case .actions(_):
            return 1
        case .comments(let comments):
            return comments.count > 4 ? 4 : comments.count
        case .primaryContent(_):
            return 1
        case .header(_):
            return 1
        }
        //        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = renderModels[indexPath.section]
        
        switch model.renderType {
        case .actions(let action):
            let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostActionTableViewCell.identifier, for: indexPath) as! IGFeedPostActionTableViewCell
            return cell
            
        case .comments(let comments):
            let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostGeneralTableViewCell.identifier, for: indexPath) as! IGFeedPostGeneralTableViewCell
            return cell
            
        case .primaryContent(let post):
            let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostTableViewCell.identifier, for: indexPath) as! IGFeedPostTableViewCell
            return cell
            
        case .header(let user):
            let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostHeaderTableViewCell.identifier, for: indexPath) as! IGFeedPostHeaderTableViewCell
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let model = renderModels[indexPath.section]
        
        switch model.renderType {
        case .actions(_):
            return 60
            
        case .comments(_):
            return 50
            
        case .primaryContent(_):
            return view.width
            
        case .header(_):
            return 70
        }
    }
    
}
