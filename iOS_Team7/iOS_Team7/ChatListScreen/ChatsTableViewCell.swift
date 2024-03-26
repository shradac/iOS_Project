//
//  ChatsTableViewCell.swift
//  iOS_Team7
//
//  Created by Nitin Bhat on 3/26/24.
//

import UIKit

class ChatsTableViewCell: UITableViewCell {
    static let identifier = "ChatsTableViewCell"
    
    private let labelNote = UILabel()
    //private let deleteButton = UIButton()
    private var indexPath: IndexPath?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        // Add labelNote to the cell's content view
        contentView.addSubview(labelNote)
        
        // Configure labelNote
        labelNote.font = UIFont.systemFont(ofSize: 16)
        labelNote.numberOfLines = 0 // Allow multiple lines for text
        labelNote.translatesAutoresizingMaskIntoConstraints = false
        
        // Configure deleteButton
        // deleteButton.setTitle("Delete", for: .normal)
        // deleteButton.setTitleColor(.red, for: .normal)
        // deleteButton.translatesAutoresizingMaskIntoConstraints = false
        
        // Add deleteButton to the cell's content view
        // contentView.addSubview(deleteButton)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            labelNote.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            labelNote.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            //labelNote.trailingAnchor.constraint(equalTo: deleteButton.leadingAnchor, constant: -8), // Align labelNote's trailing to deleteButton's leading with 8 points spacing
            labelNote.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            
//            deleteButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
//            deleteButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
//            deleteButton.widthAnchor.constraint(equalToConstant: 80), // Set a fixed width for deleteButton
//            deleteButton.heightAnchor.constraint(equalToConstant: 40) // Set a fixed height for deleteButton
        ])
    }
    
    
    func configure(with chat: ChatPanel, at indexPath: IndexPath) {
        // Configure the cell with note data
        labelNote.text = chat.senderEmail
        self.indexPath = indexPath
    }
}

