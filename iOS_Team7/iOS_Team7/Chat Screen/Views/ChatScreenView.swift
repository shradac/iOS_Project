//
//  ChatScreenView.swift
//  iOS_Team7
//
//  Created by Vasu Agarwal on 3/31/24.
//

import UIKit

class ChatScreenView: UIView {
    // Declare UI elements
    var tableView: UITableView!
    var messageTextField: UITextField!
    var sendButton: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupTableView()
        setupTextField()
        setupSendButton()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupTableView()
    }
    
    private func setupTableView() {
        tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        tableView.register(ChatTableViewCell.self, forCellReuseIdentifier: "ChatCell")
    }
    
    private func setupTextField() {
            messageTextField = UITextField()
            messageTextField.translatesAutoresizingMaskIntoConstraints = false
            addSubview(messageTextField)
            
            NSLayoutConstraint.activate([
                messageTextField.leadingAnchor.constraint(equalTo: leadingAnchor),
                messageTextField.bottomAnchor.constraint(equalTo: bottomAnchor),
                messageTextField.heightAnchor.constraint(equalToConstant: 50), // Adjust height as needed
                messageTextField.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.7) // Adjust width as needed
            ])
            
            messageTextField.backgroundColor = .lightGray // Example background color
            messageTextField.placeholder = "Type your message here"
        }
        
    private func setupSendButton() {
            sendButton = UIButton(type: .system)
            sendButton.translatesAutoresizingMaskIntoConstraints = false
            sendButton.setTitle("Send", for: .normal)
            addSubview(sendButton)
            
            NSLayoutConstraint.activate([
                sendButton.leadingAnchor.constraint(equalTo: messageTextField.trailingAnchor),
                sendButton.trailingAnchor.constraint(equalTo: trailingAnchor),
                sendButton.bottomAnchor.constraint(equalTo: bottomAnchor),
                sendButton.heightAnchor.constraint(equalToConstant: 50) // Adjust height as needed
            ])
            
            sendButton.backgroundColor = .blue // Example background color
    }
}
