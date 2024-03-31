//
//  LoginView.swift
//  ContactAppA4
//
//  Created by Nitin Bhat on 3/17/24.
//

import UIKit

class LoginView: UIView {

    var emailField: UITextField!
    var passwordField: UITextField!
    var loginBtn: UIButton!
    var registerBtn: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        //MARK: set the background color...
        self.backgroundColor = .white
        
        
        setupEmailField()
        setupPasswordField()
        setupLoginButton()
        setupRegisterButton()
        
        
        initConstraints()
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
    
    func setupRegisterButton(){
        registerBtn = UIButton(type: .roundedRect)
        registerBtn.setTitle("Register", for: .normal)
        registerBtn.backgroundColor = .black
        registerBtn.translatesAutoresizingMaskIntoConstraints = false
        registerBtn.setTitleColor(.white, for: .normal) // Set text color to white
        registerBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        self.addSubview(registerBtn)
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
            
            emailField.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 100),
            emailField.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            emailField.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            passwordField.topAnchor.constraint(equalTo: emailField.bottomAnchor, constant: 20),
            passwordField.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            passwordField.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            loginBtn.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: 30),
            loginBtn.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            loginBtn.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            loginBtn.heightAnchor.constraint(equalToConstant: 50), // Optional: You can set a fixed height for the button
            
            registerBtn.topAnchor.constraint(equalTo: loginBtn.bottomAnchor, constant: 20),
            registerBtn.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            registerBtn.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            registerBtn.heightAnchor.constraint(equalToConstant: 50) // Optional: You can set a fixed height for the button
        ])
    }


}
