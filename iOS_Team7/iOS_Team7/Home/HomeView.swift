//
//  HomeView.swift
//  iOS_Team7
//
//  Created by Nitin Bhat on 4/4/24.
//

import UIKit

class HomeView: UIView {

    var loginBtn: UIButton!
    var registerBtn: UIButton!
    var imageView: UIImageView!
    var tableView: UITableView!
    
    override init(frame: CGRect) {
            super.init(frame: frame)
            
            //MARK: set the background color...
            self.backgroundColor = .white
            
            setupImageView()
            setupLoginButton()
            setupRegisterButton()
            setupTableView()
            
            
            initConstraints()
    }
    
    required init?(coder: NSCoder) {
                fatalError("init(coder:) has not been implemented")
    }
    
    func setupImageView() {
            imageView = UIImageView()
            imageView.contentMode = .scaleAspectFit
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.image = UIImage(named: "logo") // Set your image here
            self.addSubview(imageView)
    }
    
    func setupTableView() {
            tableView = UITableView()
            tableView.translatesAutoresizingMaskIntoConstraints = false
            addSubview(tableView)
            
            tableView.register(TableViewCellUnAuthPost.self, forCellReuseIdentifier: "Unauthpost")
    }
    
    
    func setupLoginButton(){
            loginBtn = UIButton(type: .roundedRect)
            loginBtn.setTitle("Login", for: .normal)
            loginBtn.backgroundColor = .blue
            loginBtn.translatesAutoresizingMaskIntoConstraints = false
            loginBtn.setTitleColor(.white, for: .normal) // Set text color to white
            loginBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
            self.addSubview(loginBtn)
    }
        
    func setupRegisterButton(){
            registerBtn = UIButton(type: .roundedRect)
            registerBtn.setTitle("Register", for: .normal)
            registerBtn.backgroundColor = .black
            registerBtn.translatesAutoresizingMaskIntoConstraints = false
            registerBtn.setTitleColor(.white, for: .normal) // Set text color to white
            registerBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
            self.addSubview(registerBtn)
    }

    
    func initConstraints() {
           NSLayoutConstraint.activate([
               // Set image view constraints
               imageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
               imageView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 1),
               imageView.widthAnchor.constraint(equalToConstant: 100), // Adjust width as needed
               imageView.heightAnchor.constraint(equalToConstant: 100), // Adjust height as needed
               
               // Place login button on the left end with a spacing of 20
               loginBtn.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 20),
               // Place register button on the right end with a spacing of -20 (negative constant moves it left)
               registerBtn.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -20),
               
               // Align buttons vertically below the image view with a spacing of 10
               loginBtn.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 5),
               registerBtn.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 5),
               
               // Set constraints for login button
               loginBtn.widthAnchor.constraint(equalToConstant: 100), // Optional: You can set a fixed width for the button
               loginBtn.heightAnchor.constraint(equalToConstant: 30), // Optional: You can set a fixed height for the button
               
               // Set constraints for register button
               registerBtn.widthAnchor.constraint(equalToConstant: 100), // Optional: You can set a fixed width for the button
               registerBtn.heightAnchor.constraint(equalToConstant: 30), // Optional: You can set a fixed height for the button
               
               // Set table view constraints
               tableView.topAnchor.constraint(equalTo: loginBtn.bottomAnchor, constant: 20), // Place below the buttons with a spacing of 20
               tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
               tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
               tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
           ])
    }

}
