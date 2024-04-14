//
//  ExploreView.swift
//  iOS_Team7
//
//  Created by Nitin Bhat on 4/14/24.
//

import UIKit

class ExploreView: UIView {

    var imageView: UIImageView!
    var tableView: UITableView!
    var profileBtn: UIButton!

    
    override init(frame: CGRect) {
            super.init(frame: frame)
            
            //MARK: set the background color...
            self.backgroundColor = .white
            setupTableView()
            initConstraints()
    }
    
    required init?(coder: NSCoder) {
                fatalError("init(coder:) has not been implemented")
    }

    
    func setupTableView() {
            tableView = UITableView()
            tableView.translatesAutoresizingMaskIntoConstraints = false
            addSubview(tableView)
            
            tableView.register(TableViewCell.self, forCellReuseIdentifier: "Unauthpost")
    }


    
    func initConstraints() {
           NSLayoutConstraint.activate([
               tableView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 32 ),
               tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
               tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
               tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
           ])
    }
}
