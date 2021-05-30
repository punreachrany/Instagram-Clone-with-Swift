//
//  IGFeedPostHeaderTableViewCell.swift
//  Instagram
//
//  Created by Punreach Rany on 2021/05/22.
//

import UIKit

class IGFeedPostHeaderTableViewCell: UITableViewCell {
    static let identifier = "IGFeedPostHeaderTableViewCell"

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .systemBlue
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure() {
        // configure the cell
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }


}
