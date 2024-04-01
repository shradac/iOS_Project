//
//  ChatsTableViewCell.swift
//  iOS_Team7
//
//  Created by Nitin Bhat on 3/26/24.
//

import UIKit


class ChatsTableViewCell: UITableViewCell {
    static let identifier = "ChatsTableViewCell"
    var wrapperCellView: UIView!
    var labelName: UILabel!
    var labelLastMessage: UILabel!
    var labelTimestamp: UILabel!
    var imageProfile: UIImageView!

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupWrapperCellView()
        setupLabels()
        setupImageProfile()
        initConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupWrapperCellView() {
        wrapperCellView = UIView() // Use UIView instead of UITableViewCell
        wrapperCellView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(wrapperCellView)
    }

    func setupLabels() {
        labelName = UILabel()
        labelName.font = UIFont.boldSystemFont(ofSize: 16)
        labelName.translatesAutoresizingMaskIntoConstraints = false
        wrapperCellView.addSubview(labelName)

        labelLastMessage = UILabel()
        labelLastMessage.font = UIFont.systemFont(ofSize: 14)
        labelLastMessage.textColor = .gray
        labelLastMessage.numberOfLines = 2 // Adjust as needed
        labelLastMessage.translatesAutoresizingMaskIntoConstraints = false
        wrapperCellView.addSubview(labelLastMessage)

        labelTimestamp = UILabel()
        labelTimestamp.font = UIFont.systemFont(ofSize: 12)
        labelTimestamp.textColor = .gray
        labelTimestamp.translatesAutoresizingMaskIntoConstraints = false
        wrapperCellView.addSubview(labelTimestamp)
    }

    func setupImageProfile() {
        imageProfile = UIImageView()
        imageProfile.image = UIImage(systemName: "person.fill")
        imageProfile.contentMode = .scaleAspectFill
        imageProfile.clipsToBounds = true
        imageProfile.layer.cornerRadius = 25 // Adjust as needed
        imageProfile.translatesAutoresizingMaskIntoConstraints = false
        wrapperCellView.addSubview(imageProfile)
    }



    func initConstraints() {
        NSLayoutConstraint.activate([
            wrapperCellView.topAnchor.constraint(equalTo: contentView.topAnchor),
            wrapperCellView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            wrapperCellView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            wrapperCellView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),

            imageProfile.leadingAnchor.constraint(equalTo: wrapperCellView.leadingAnchor, constant: 16),
            imageProfile.topAnchor.constraint(equalTo: wrapperCellView.topAnchor, constant: 16),
            imageProfile.widthAnchor.constraint(equalToConstant: 50),
            imageProfile.heightAnchor.constraint(equalToConstant: 50),

            labelName.leadingAnchor.constraint(equalTo: imageProfile.trailingAnchor, constant: 16),
            labelName.topAnchor.constraint(equalTo: imageProfile.topAnchor),
            labelName.trailingAnchor.constraint(equalTo: wrapperCellView.trailingAnchor, constant: -16),

            labelLastMessage.leadingAnchor.constraint(equalTo: labelName.leadingAnchor),
            labelLastMessage.topAnchor.constraint(equalTo: labelName.bottomAnchor, constant: 8),
            labelLastMessage.trailingAnchor.constraint(equalTo: wrapperCellView.trailingAnchor, constant: -16),

            labelTimestamp.trailingAnchor.constraint(equalTo: wrapperCellView.trailingAnchor, constant: -16),
            labelTimestamp.topAnchor.constraint(equalTo: labelLastMessage.bottomAnchor, constant: 8),
            labelTimestamp.bottomAnchor.constraint(equalTo: wrapperCellView.bottomAnchor, constant: -16)
        ])
    }

    func configure(with chat: ChatPanel, at indexPath: IndexPath) {
        labelName.text = chat.senderEmail
        labelLastMessage.text = chat.lastMessage
        labelTimestamp.text = formatDate(chat.timestampLastMsg)
    }

    private func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d, HH:mm"
        return formatter.string(from: date)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}



//class ChatsTableViewCell: UITableViewCell {
//    static let identifier = "ChatsTableViewCell"
//    
//    private let avatarImageView: UIImageView = {
//        let imageView = UIImageView()
//        imageView.contentMode = .scaleAspectFit
//        imageView.clipsToBounds = true
//        imageView.translatesAutoresizingMaskIntoConstraints = false
//        return imageView
//    }()
//    
//    private let nameLabel: UILabel = {
//        let label = UILabel()
//        label.font = UIFont.boldSystemFont(ofSize: 16)
//        label.translatesAutoresizingMaskIntoConstraints = false
//        return label
//    }()
//    
//    private let lastMessageLabel: UILabel = {
//        let label = UILabel()
//        label.font = UIFont.systemFont(ofSize: 14)
//        label.textColor = .gray
//        label.translatesAutoresizingMaskIntoConstraints = false
//        return label
//    }()
//    
//    private let timestampLabel: UILabel = {
//        let label = UILabel()
//        label.font = UIFont.systemFont(ofSize: 12)
//        label.textColor = .gray
//        label.translatesAutoresizingMaskIntoConstraints = false
//        return label
//    }()
//    
//    private var indexPath: IndexPath?
//    
//    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
//        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        setupViews()
//        setupConstraints()
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    private func setupViews() {
//        addSubview(avatarImageView)
//        addSubview(nameLabel)
//        addSubview(lastMessageLabel)
//        addSubview(timestampLabel)
//    }
//    
//    private func setupConstraints() {
//        NSLayoutConstraint.activate([
//            avatarImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
//            avatarImageView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
//            avatarImageView.widthAnchor.constraint(equalToConstant: 50),
//            avatarImageView.heightAnchor.constraint(equalToConstant: 50),
//            
//            nameLabel.topAnchor.constraint(equalTo: avatarImageView.topAnchor),
//            nameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 16),
//            
//            lastMessageLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 4),
//            lastMessageLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
//            lastMessageLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
//            
//            timestampLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8),
//            timestampLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
//        ])
//    }
//    
//    func configure(with chat: ChatPanel, at indexPath: IndexPath) {
//        // Configure the cell with chat data
//        nameLabel.text = chat.senderEmail
//        lastMessageLabel.text = chat.lastMessage
//        timestampLabel.text = formatDate(chat.timestampLastMsg)
//        self.indexPath = indexPath
//    }
//    
//    private func formatDate(_ date: Date) -> String {
//        let formatter = DateFormatter()
//        formatter.dateFormat = "MMM d, HH:mm"
//        return formatter.string(from: date)
//    }
//}
