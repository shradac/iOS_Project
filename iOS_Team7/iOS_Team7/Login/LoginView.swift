//
//  LoginView.swift
//  iOS_Team7
//
//  Created by Nitin Bhat on 4/4/24.
//

import UIKit

class LoginView: UIView {

    var emailField: UITextField!
    var passwordField: UITextField!
    var loginBtn: UIButton!
    var imageView: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        //MARK: set the background color...
        self.backgroundColor = .white
        
        setupImageView()
        setupEmailField()
        setupPasswordField()
        setupLoginButton()

        
        
        initConstraints()
    }
    
    func setupImageView() {
            imageView = UIImageView()
            imageView.contentMode = .scaleAspectFit
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.image = UIImage(named: "logo") // Set your image here
            self.addSubview(imageView)
    }
    
    func setupPasswordField(){
        passwordField = UITextField()
        passwordField.placeholder = "Password"
        passwordField.isSecureTextEntry = true
        passwordField.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(passwordField)
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
    
   
    
    func setupEmailField(){
        emailField = UITextField()
        emailField.placeholder = "Email"
        emailField.keyboardType = UIKeyboardType.emailAddress
        emailField.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(emailField)
    }
    
    required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
    }
    
    
    
    func initConstraints(){
        NSLayoutConstraint.activate([
            
            imageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            imageView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 1),
            imageView.widthAnchor.constraint(equalToConstant: 200), // Adjust width as needed
            imageView.heightAnchor.constraint(equalToConstant: 200), // Adjust height as needed
            
            emailField.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 200),
            emailField.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            emailField.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            passwordField.topAnchor.constraint(equalTo: emailField.bottomAnchor, constant: 20),
            passwordField.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            passwordField.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            loginBtn.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: 30),
            loginBtn.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            loginBtn.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            loginBtn.heightAnchor.constraint(equalToConstant: 50), // Optional: You can set a fixed height for the button
        
        ])
    }


}
