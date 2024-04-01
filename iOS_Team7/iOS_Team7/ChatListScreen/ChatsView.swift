//
//  ChatsView.swift
//  iOS_Team7
//
//  Created by Nitin Bhat on 3/26/24.
//

import UIKit

class ChatsView: UIView {
    var tableViewChat : UITableView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupTableView()
        initConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupTableView() {
        tableViewChat = UITableView()
        tableViewChat.register(ChatsTableViewCell.self, forCellReuseIdentifier: ChatsTableViewCell.identifier)
        tableViewChat.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(tableViewChat)
    }
    
    private func initConstraints() {
        NSLayoutConstraint.activate([
            tableViewChat.topAnchor.constraint(equalTo: topAnchor),
            tableViewChat.bottomAnchor.constraint(equalTo: bottomAnchor),
            tableViewChat.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableViewChat.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
}
