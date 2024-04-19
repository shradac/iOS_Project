//
//  ShowProfileView.swift
//  iOS_Team7
//
//  Created by Vasu Agarwal on 4/5/24.
//

import UIKit

class ShowProfileView: UIView {

    var imageProfile: UIImageView!
    var labelName: UILabel!
    var labelEmail: UILabel!
    var labelPhoneNum: UILabel!
    var labelAddressHeading: UILabel!
    var labelAddress1: UILabel!
    var labelAddress2: UILabel!
    var labelZip: UILabel!
    var buttonLogout: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        //setting the background color...
        self.backgroundColor = .white
            
        setupImageProfile()
        setupLabelName()
        setupLabelEmail()
        setupLabelPhoneNum()
        setupLabelAddressHeading()
        setupLabelAddress1()
        setupLabelAddress2()
        setupLabelZip()
        setupbuttonLogout()
        initConstraints()
    }
    
    func setupbuttonLogout(){
        buttonLogout = UIButton(type: .system)
        buttonLogout.setTitle("Logout", for: .normal)
        buttonLogout.setTitleColor(.systemRed, for: .normal)
        buttonLogout.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(buttonLogout)
    }
    
    func setupImageProfile(){
        imageProfile = UIImageView()
        imageProfile.image = UIImage(systemName: "person.fill")
        imageProfile.tintColor = .black
        imageProfile.contentMode = .scaleToFill
        imageProfile.clipsToBounds = true
        imageProfile.layer.cornerRadius = 10
        imageProfile.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(imageProfile)
    }
    
    func setupLabelName(){
        labelName = UILabel()
        labelName.textColor = .black
        labelName.font = UIFont.boldSystemFont(ofSize: 26)
        labelName.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(labelName)
    }
    
    func setupLabelEmail(){
        labelEmail = UILabel()
        labelEmail.textColor = .black
        labelEmail.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(labelEmail)
    }
    
    func setupLabelPhoneNum(){
        labelPhoneNum = UILabel()
        labelPhoneNum.textColor = .black
        labelPhoneNum.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(labelPhoneNum)
    }
    
    func setupLabelAddressHeading(){
        labelAddressHeading = UILabel()
        labelAddressHeading.textColor = .black
        labelAddressHeading.font = UIFont.boldSystemFont(ofSize: 18)
        labelAddressHeading.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(labelAddressHeading)
    }
    
    func setupLabelAddress1(){
        labelAddress1 = UILabel()
        labelAddress1.textColor = .black
        labelAddress1.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(labelAddress1)
    }
    
    func setupLabelAddress2(){
        labelAddress2 = UILabel()
        labelAddress2.textColor = .black
        labelAddress2.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(labelAddress2)
    }
    
    func setupLabelZip(){
        labelZip = UILabel()
        labelZip.textColor = .black
        labelZip.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(labelZip)
    }
        
    func initConstraints(){
        NSLayoutConstraint.activate([
//            imageContact.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
//            imageContact.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 16),
//            imageContact.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 64),
//            imageContact.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -64),
//            imageContact.heightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.heightAnchor, constant: -100),
//            imageContact.widthAnchor.constraint(equalTo: self.safeAreaLayoutGuide.widthAnchor, constant: -20),
            imageProfile.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            imageProfile.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 48),
            imageProfile.widthAnchor.constraint(equalToConstant: 100),
            imageProfile.heightAnchor.constraint(equalToConstant: 100),
            
            labelName.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            labelName.topAnchor.constraint(equalTo: imageProfile.safeAreaLayoutGuide.bottomAnchor, constant: 8),
//            labelName.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            
            labelEmail.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            labelEmail.topAnchor.constraint(equalTo: labelName.bottomAnchor, constant: 28),
//            labelEmail.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            
            labelPhoneNum.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            labelPhoneNum.topAnchor.constraint(equalTo: labelEmail.bottomAnchor, constant: 16),
//            labelPhoneNum.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            
            labelAddressHeading.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            labelAddressHeading.topAnchor.constraint(equalTo: labelPhoneNum.bottomAnchor, constant: 16),
            
            labelAddress1.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            labelAddress1.topAnchor.constraint(equalTo: labelAddressHeading.bottomAnchor, constant: 4),
//            labelAddress1.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            
            labelAddress2.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            labelAddress2.topAnchor.constraint(equalTo: labelAddress1.bottomAnchor, constant: 0),
//            labelAddress2.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            
            labelZip.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            labelZip.topAnchor.constraint(equalTo: labelAddress2.bottomAnchor, constant: 0),
//            labelZip.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20)
            
            buttonLogout.topAnchor.constraint(equalTo: labelZip.bottomAnchor, constant: 72),
            buttonLogout.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

