//
//  CellTableView.swift
//  Expand-CollapseHeaderWithTabs
//
//  Created by yusef naser on 4/28/20.
//  Copyright © 2020 solutionplus. All rights reserved.
//

import UIKit

class CellTableView : UICollectionViewCell {
    
    let tableView : CustomTableView = {
       let t = CustomTableView()
        t.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        t.tableFooterView = UIView()
        return t
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addViews()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
   
    private func addViews () {
        self.contentView.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: contentView.topAnchor , constant: 8).isActive = true
        tableView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor , constant: 8).isActive = true
        tableView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor , constant: -8).isActive = true
        tableView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor , constant: -8 ).isActive = true
    }
    
}

