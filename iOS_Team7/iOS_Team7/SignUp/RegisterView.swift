//
//  RegisterView.swift
//  ContactAppA4
//
//  Created by Nitin Bhat on 3/17/24.
//

import UIKit

class RegisterView: UIView {
    var nameField: UITextField!
    var emailField: UITextField!
    var passwordField: UITextField!
    var confirmPasswordField: UITextField!
    var registerBtn: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        //MARK: set the background color...
        self.backgroundColor = .white
        
        setupNameField()
        setupEmailField()
        setupPasswordField()
        setupConfirmPasswordField()
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
    
    func setupConfirmPasswordField(){
        confirmPasswordField=UITextField()
        confirmPasswordField.placeholder = "Confirm Password"
        confirmPasswordField.isSecureTextEntry = true
        confirmPasswordField.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(confirmPasswordField)
        
    }
    
    func setupNameField(){
        nameField = UITextField()
        nameField.placeholder = "Name"
        nameField.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(nameField)
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
            nameField.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 100),
            nameField.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            nameField.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            emailField.topAnchor.constraint(equalTo: nameField.bottomAnchor, constant: 20),
            emailField.leadingAnchor.constraint(equalTo: nameField.leadingAnchor),
            emailField.trailingAnchor.constraint(equalTo: nameField.trailingAnchor),
            
            passwordField.topAnchor.constraint(equalTo: emailField.bottomAnchor, constant: 20),
            passwordField.leadingAnchor.constraint(equalTo: nameField.leadingAnchor),
            passwordField.trailingAnchor.constraint(equalTo: nameField.trailingAnchor),
            
            confirmPasswordField.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: 20),
            confirmPasswordField.leadingAnchor.constraint(equalTo: nameField.leadingAnchor),
            confirmPasswordField.trailingAnchor.constraint(equalTo: nameField.trailingAnchor),
            
            registerBtn.topAnchor.constraint(equalTo: confirmPasswordField.bottomAnchor, constant: 20),
            registerBtn.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            registerBtn.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            registerBtn.heightAnchor.constraint(equalToConstant: 50) // Optional: You can set a fixed height for the button
        ])
    }


}
