//
//  NewPostView.swift
//  iOS_Team7
//
//  Created by Vasu Agarwal on 4/18/24.
//

import UIKit

import UIKit

import UIKit

class NewPostView: UIView {
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Post Title:"
        return label
    }()
    
    let titleTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Enter title"
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    let contentLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Post Content:"
        return label
    }()
    
    let contentTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.layer.borderWidth = 1
        textView.layer.borderColor = UIColor.lightGray.cgColor
        textView.layer.cornerRadius = 5
        textView.font = UIFont.systemFont(ofSize: 15)
        return textView
    }()
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .lightGray
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let buttonTakePhoto: UIButton = {
        let button: UIButton!
        button = UIButton(type: .system)
        button.setTitle("", for: .normal)
        button.setImage(UIImage(systemName: "camera.fill"), for: .normal)
        button.contentHorizontalAlignment = .fill
        button.contentVerticalAlignment = .fill
        button.imageView?.contentMode = .scaleAspectFit
        button.showsMenuAsPrimaryAction = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let saveButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Save", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        addSubview(titleLabel)
        addSubview(titleTextField)
        addSubview(contentTextView)
        addSubview(contentLabel)
//        addSubview(imageView)
        addSubview(saveButton)
        addSubview(buttonTakePhoto)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 80),
            titleLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            
            titleTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            titleTextField.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            titleTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            titleTextField.heightAnchor.constraint(equalToConstant: 40),
            
            contentLabel.topAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: 20),
            contentLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            
            contentTextView.topAnchor.constraint(equalTo: contentLabel.bottomAnchor, constant: 20),
            contentTextView.leadingAnchor.constraint(equalTo: titleTextField.leadingAnchor),
            contentTextView.trailingAnchor.constraint(equalTo: titleTextField.trailingAnchor),
            contentTextView.heightAnchor.constraint(equalToConstant: 150),
            
            buttonTakePhoto.topAnchor.constraint(equalTo: contentTextView.bottomAnchor, constant: 20),
            buttonTakePhoto.leadingAnchor.constraint(equalTo: contentTextView.leadingAnchor),
            buttonTakePhoto.trailingAnchor.constraint(equalTo: contentTextView.trailingAnchor),
            buttonTakePhoto.widthAnchor.constraint(equalToConstant: 150),
            buttonTakePhoto.heightAnchor.constraint(equalToConstant: 150),
            
//            imageView.topAnchor.constraint(equalTo: buttonTakePhoto.bottomAnchor, constant: 20),
//            imageView.leadingAnchor.constraint(equalTo: buttonTakePhoto.leadingAnchor),
//            imageView.trailingAnchor.constraint(equalTo: buttonTakePhoto.trailingAnchor),
//            imageView.widthAnchor.constraint(equalToConstant: 100), // Adjust width as needed
//            imageView.heightAnchor.constraint(equalToConstant: 100), // Adjust height as needed
            
            saveButton.topAnchor.constraint(equalTo: buttonTakePhoto.bottomAnchor, constant: 20),
            saveButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            saveButton.widthAnchor.constraint(equalToConstant: 100),
            saveButton.heightAnchor.constraint(equalToConstant: 40),
        ])
    }
}
