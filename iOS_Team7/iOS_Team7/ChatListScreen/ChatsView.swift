//
//  ChatsView.swift
//  iOS_Team7
//
//  Created by Nitin Bhat on 3/26/24.
//

import UIKit

class ChatsView: UIView {
    let tableViewNote = UITableView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupTableView()
        initConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupTableView() {
        addSubview(tableViewNote)
        tableViewNote.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func initConstraints() {
        NSLayoutConstraint.activate([
            tableViewNote.topAnchor.constraint(equalTo: topAnchor),
            tableViewNote.bottomAnchor.constraint(equalTo: bottomAnchor),
            tableViewNote.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableViewNote.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
}
