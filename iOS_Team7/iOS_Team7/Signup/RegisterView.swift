//
//  RegisterView.swift
//  iOS_Team7
//
//  Created by Nitin Bhat on 4/4/24.
//

import UIKit

class RegisterView: UIView {
    var nameField: UITextField!
    var emailField: UITextField!
    var passwordField: UITextField!
    var confirmPasswordField: UITextField!
    var registerBtn: UIButton!
    var imageView: UIImageView!
    var buttonSelectRoleType: UIButton!
    var buttonTakePhoto: UIButton!
    
    var roleLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        //MARK: set the background color...
        self.backgroundColor = .white
        
        setupImageView()
        setupNameField()
        setupEmailField()
        setupPasswordField()
        setupConfirmPasswordField()
        setupRegisterButton()
        setupbuttonTakePhoto()
        setupbuttonSelectRoleType()
        setupRoleLabel()
        
        
        initConstraints()
    }
    
    func setupRoleLabel(){
        roleLabel = UILabel()
        roleLabel.text = "Select Role : "
        roleLabel.font = UIFont.boldSystemFont(ofSize: 17)
        roleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(roleLabel)
    }
    
    func setupbuttonSelectRoleType(){
        buttonSelectRoleType = UIButton(type: .system)
        buttonSelectRoleType.setTitle("Expert", for: .normal)
        buttonSelectRoleType.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(buttonSelectRoleType)
    }
    
    func setupbuttonTakePhoto(){
            buttonTakePhoto = UIButton(type: .system)
            buttonTakePhoto.setTitle("", for: .normal)
            buttonTakePhoto.setImage(UIImage(systemName: "camera.fill"), for: .normal)
            buttonTakePhoto.contentHorizontalAlignment = .fill
            buttonTakePhoto.contentVerticalAlignment = .fill
            buttonTakePhoto.imageView?.contentMode = .scaleAspectFit
            buttonTakePhoto.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview(buttonTakePhoto)
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
            
            imageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            imageView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 1),
            imageView.widthAnchor.constraint(equalToConstant: 200), // Adjust width as needed
            imageView.heightAnchor.constraint(equalToConstant: 200), // Adjust height as needed
            
            
            nameField.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
            nameField.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            nameField.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            buttonTakePhoto.topAnchor.constraint(equalTo: nameField.bottomAnchor, constant: 20),
            buttonTakePhoto.leadingAnchor.constraint(equalTo: nameField.leadingAnchor),
            buttonTakePhoto.trailingAnchor.constraint(equalTo: nameField.trailingAnchor),
              
            roleLabel.topAnchor.constraint(equalTo: buttonTakePhoto.bottomAnchor, constant: 20),
            roleLabel.leadingAnchor.constraint(equalTo: nameField.leadingAnchor),
            roleLabel.trailingAnchor.constraint(equalTo: nameField.trailingAnchor),
            
            buttonSelectRoleType.topAnchor.constraint(equalTo: roleLabel.bottomAnchor, constant: 20),
            buttonSelectRoleType.leadingAnchor.constraint(equalTo: nameField.leadingAnchor),
            buttonSelectRoleType.trailingAnchor.constraint(equalTo: nameField.trailingAnchor),
            
            emailField.topAnchor.constraint(equalTo: buttonSelectRoleType.bottomAnchor, constant: 20),
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
