//
//  LoggedInHomeView.swift
//  iOS_Team7
//
//  Created by Shrada Chellasami on 4/5/24.
//

import UIKit

class LoggedInHomeView: UIView {
    

        var imageView: UIImageView!
        var tableView: UITableView!
    var profileBtn: UIButton!
        
        override init(frame: CGRect) {
                super.init(frame: frame)
                
                //MARK: set the background color...
                self.backgroundColor = .white
                
//                setupImageView()
                setupTableView()
           

                
                
                initConstraints()
        }
        
        required init?(coder: NSCoder) {
                    fatalError("init(coder:) has not been implemented")
        }
        
//        func setupImageView() {
//                imageView = UIImageView()
//                imageView.contentMode = .scaleAspectFit
//                imageView.translatesAutoresizingMaskIntoConstraints = false
//                imageView.image = UIImage(named: "logo") // Set your image here
//                self.addSubview(imageView)
//        }
        
        func setupTableView() {
                tableView = UITableView()
                tableView.translatesAutoresizingMaskIntoConstraints = false
                addSubview(tableView)
                
                tableView.register(TableViewCell.self, forCellReuseIdentifier: "Unauthpost")
        }
    
  
        
        
       
        
        func initConstraints() {
               NSLayoutConstraint.activate([
                   // Set image view constraints
//                   imageView.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 32),
//                   imageView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 1),
//                   imageView.widthAnchor.constraint(equalToConstant: 100), // Adjust width as needed
//                   imageView.heightAnchor.constraint(equalToConstant: 100), // Adjust height as needed
//                   
                   
      
                
                
                   // Set table view constraints
                   tableView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 32 ), // Place below the buttons with a spacing of 20
                   tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
                   tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
                   tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
                   
                   
                  
               ])
        }






    }



