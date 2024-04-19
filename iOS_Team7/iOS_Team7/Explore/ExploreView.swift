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
    var searchBar: UITextField!

    
    override init(frame: CGRect) {
            super.init(frame: frame)
            
            //MARK: set the background color...
            self.backgroundColor = .white
            setUpSearchBar()
            setupTableView()
            initConstraints()
    }
    
    required init?(coder: NSCoder) {
                fatalError("init(coder:) has not been implemented")
    }
    
    func setUpSearchBar(){
        searchBar = UITextField()
        searchBar.placeholder = "Search Post"
        searchBar.borderStyle = .roundedRect
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(searchBar)
    }

    
    func setupTableView() {
            tableView = UITableView()
            tableView.translatesAutoresizingMaskIntoConstraints = false
            addSubview(tableView)
            
            tableView.register(TableViewCell.self, forCellReuseIdentifier: "Authpost")
    }


    
    func initConstraints() {
           NSLayoutConstraint.activate([
            
            searchBar.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 30),
            searchBar.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            searchBar.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            
            tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 32 ),
               tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
               tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
               tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
           ])
    }
}
