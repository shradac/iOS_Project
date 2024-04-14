//
//  TableViewCell.swift
//  iOS_Team7
//
//  Created by Nitin Bhat on 4/4/24.
//

import UIKit

//class TableViewCell: UITableViewCell {
//    var wrapperCellView: UIView!
//    var labelTitle: UILabel!
//    var labelContent: UILabel!
//    var labelTimestamp: UILabel!
//    var imageProfile: UIImageView!
//
//    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
//        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        setupWrapperCellView()
//        setupLabels()
//        setupImageProfile()
//        initConstraints()
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    func setupWrapperCellView() {
//        wrapperCellView = UIView() // Use UIView instead of UITableViewCell
//        wrapperCellView.translatesAutoresizingMaskIntoConstraints = false
//        contentView.addSubview(wrapperCellView)
//    }
//
//    func setupLabels() {
//        labelTitle = UILabel()
//        labelTitle.font = UIFont.boldSystemFont(ofSize: 16)
//        labelTitle.translatesAutoresizingMaskIntoConstraints = false
//        wrapperCellView.addSubview(labelTitle)
//
//        labelContent = UILabel()
//        labelContent.font = UIFont.systemFont(ofSize: 14)
//        labelContent.textColor = .gray
//        labelContent.numberOfLines = 2 // Adjust as needed
//        labelContent.translatesAutoresizingMaskIntoConstraints = false
//        wrapperCellView.addSubview(labelContent)
//
//        labelTimestamp = UILabel()
//        labelTimestamp.font = UIFont.systemFont(ofSize: 12)
//        labelTimestamp.textColor = .gray
//        labelTimestamp.translatesAutoresizingMaskIntoConstraints = false
//        wrapperCellView.addSubview(labelTimestamp)
//    }
//
//    func setupImageProfile() {
//        imageProfile = UIImageView()
//        imageProfile.image = UIImage(named: "logo")
//        imageProfile.contentMode = .scaleAspectFill
//        imageProfile.clipsToBounds = true
//        imageProfile.layer.cornerRadius = 25 // Adjust as needed
//        imageProfile.translatesAutoresizingMaskIntoConstraints = false
//        wrapperCellView.addSubview(imageProfile)
//    }
//
//
//
//    func initConstraints() {
//        NSLayoutConstraint.activate([
//            wrapperCellView.topAnchor.constraint(equalTo: contentView.topAnchor),
//            wrapperCellView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
//            wrapperCellView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
//            wrapperCellView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
//
//            imageProfile.leadingAnchor.constraint(equalTo: wrapperCellView.leadingAnchor, constant: 16),
//            imageProfile.topAnchor.constraint(equalTo: wrapperCellView.topAnchor, constant: 16),
//            imageProfile.widthAnchor.constraint(equalToConstant: 50),
//            imageProfile.heightAnchor.constraint(equalToConstant: 50),
//
//            labelTitle.leadingAnchor.constraint(equalTo: imageProfile.trailingAnchor, constant: 16),
//            labelTitle.topAnchor.constraint(equalTo: imageProfile.topAnchor),
//            labelTitle.trailingAnchor.constraint(equalTo: wrapperCellView.trailingAnchor, constant: -16),
//
//            labelContent.leadingAnchor.constraint(equalTo: labelTitle.leadingAnchor),
//            labelContent.topAnchor.constraint(equalTo: labelTitle.bottomAnchor, constant: 8),
//            labelContent.trailingAnchor.constraint(equalTo: wrapperCellView.trailingAnchor, constant: -16),
//
//            labelTimestamp.trailingAnchor.constraint(equalTo: wrapperCellView.trailingAnchor, constant: -16),
//            labelTimestamp.topAnchor.constraint(equalTo: labelContent.bottomAnchor, constant: 8),
//            labelTimestamp.bottomAnchor.constraint(equalTo: wrapperCellView.bottomAnchor, constant: -16)
//        ])
//    }
//
//    func configure(with post: Unauthpost, at indexPath: IndexPath) {
//        labelTitle.text = post.title
//        labelContent.text = post.content
//        labelTimestamp.text = formatDate(post.timestamp)
//    }
//
//    private func formatDate(_ date: Date) -> String {
//        let formatter = DateFormatter()
//        formatter.dateFormat = "MMM d, HH:mm"
//        return formatter.string(from: date)
//    }
//    
//    override func awakeFromNib() {
//        super.awakeFromNib()
//    }
//
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//    }
//}




class TableViewCell: UITableViewCell {
    var wrapperCellView: UIView!
    var labelTitle: UILabel!
    var followButton: UIButton!
    var labelContent: UILabel!
    var labelTimestamp: UILabel!
    var createdByLabel: UILabel!
    var imageProfile: UIImageView!

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupWrapperCellView()
        setupLabels()
        setupFollowButton()
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
        labelTitle = UILabel()
        labelTitle.font = UIFont.boldSystemFont(ofSize: 16)
        labelTitle.translatesAutoresizingMaskIntoConstraints = false
        wrapperCellView.addSubview(labelTitle)

        followButton = UIButton(type: .system)
        followButton.setTitle("Follow", for: .normal)
        followButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        followButton.translatesAutoresizingMaskIntoConstraints = false
        wrapperCellView.addSubview(followButton)

        labelContent = UILabel()
        labelContent.font = UIFont.systemFont(ofSize: 14)
        labelContent.textColor = .gray
        labelContent.numberOfLines = 0 // Allow multiple lines for content
        labelContent.translatesAutoresizingMaskIntoConstraints = false
        wrapperCellView.addSubview(labelContent)

        labelTimestamp = UILabel()
        labelTimestamp.font = UIFont.systemFont(ofSize: 12)
        labelTimestamp.textColor = .gray
        labelTimestamp.translatesAutoresizingMaskIntoConstraints = false
        wrapperCellView.addSubview(labelTimestamp)

        createdByLabel = UILabel()
        createdByLabel.font = UIFont.systemFont(ofSize: 12)
        createdByLabel.textColor = .gray
        createdByLabel.translatesAutoresizingMaskIntoConstraints = false
        wrapperCellView.addSubview(createdByLabel)
    }

    func setupFollowButton() {
        followButton.layer.cornerRadius = 5
        followButton.layer.borderWidth = 1
        followButton.layer.borderColor = UIColor.blue.cgColor
    }

    func setupImageProfile() {
        imageProfile = UIImageView()
        imageProfile.contentMode = .scaleAspectFill
        imageProfile.clipsToBounds = true
        imageProfile.layer.cornerRadius = 8
        imageProfile.translatesAutoresizingMaskIntoConstraints = false
        wrapperCellView.addSubview(imageProfile)
    }

    func initConstraints() {
//        NSLayoutConstraint.activate([
//                wrapperCellView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
//                wrapperCellView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
//                wrapperCellView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
//                wrapperCellView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
//
//                labelTitle.topAnchor.constraint(equalTo: wrapperCellView.topAnchor, constant: 12),
//                labelTitle.leadingAnchor.constraint(equalTo: wrapperCellView.leadingAnchor, constant: 16),
//                labelTitle.trailingAnchor.constraint(equalTo: wrapperCellView.trailingAnchor, constant: -16),
//                
//                followButton.topAnchor.constraint(equalTo: labelTitle.topAnchor, constant: 8),
//                followButton.leadingAnchor.constraint(equalTo: wrapperCellView.leadingAnchor, constant: 16),
//                followButton.trailingAnchor.constraint(equalTo: wrapperCellView.trailingAnchor, constant: -16),
//
//                imageProfile.topAnchor.constraint(equalTo: followButton.bottomAnchor, constant: 8),
//                imageProfile.leadingAnchor.constraint(equalTo: wrapperCellView.leadingAnchor, constant: 16),
//                imageProfile.trailingAnchor.constraint(equalTo: wrapperCellView.trailingAnchor, constant: 16),
//                imageProfile.widthAnchor.constraint(equalToConstant: 300),
//                imageProfile.heightAnchor.constraint(equalToConstant: 200),
//                
//
//                labelContent.topAnchor.constraint(equalTo: imageProfile.bottomAnchor, constant: 8),
//                labelContent.leadingAnchor.constraint(equalTo: wrapperCellView.leadingAnchor, constant: 16),
//                labelContent.trailingAnchor.constraint(equalTo: wrapperCellView.trailingAnchor, constant: -16),
//
//                labelTimestamp.topAnchor.constraint(equalTo: labelContent.bottomAnchor, constant: 8),
//                labelTimestamp.leadingAnchor.constraint(equalTo: wrapperCellView.leadingAnchor, constant: 16),
//                labelTimestamp.trailingAnchor.constraint(equalTo: wrapperCellView.trailingAnchor, constant: -16),
//
//                createdByLabel.topAnchor.constraint(equalTo: labelTimestamp.bottomAnchor, constant: 8),
//                createdByLabel.trailingAnchor.constraint(equalTo: wrapperCellView.trailingAnchor, constant: -16),
//                createdByLabel.bottomAnchor.constraint(equalTo: wrapperCellView.bottomAnchor, constant: -16)
//            ])
        
        NSLayoutConstraint.activate([
                wrapperCellView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
                wrapperCellView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
                wrapperCellView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
                wrapperCellView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),

                labelTitle.topAnchor.constraint(equalTo: wrapperCellView.topAnchor, constant: 12),
                labelTitle.leadingAnchor.constraint(equalTo: wrapperCellView.leadingAnchor, constant: 16),
                labelTitle.trailingAnchor.constraint(equalTo: wrapperCellView.trailingAnchor, constant: -16),

                followButton.topAnchor.constraint(equalTo: labelTitle.bottomAnchor, constant: 8),
                followButton.leadingAnchor.constraint(equalTo: wrapperCellView.leadingAnchor, constant: 16),
                followButton.trailingAnchor.constraint(equalTo: wrapperCellView.trailingAnchor, constant: -16),

                imageProfile.topAnchor.constraint(equalTo: followButton.bottomAnchor, constant: 8),
                imageProfile.leadingAnchor.constraint(equalTo: wrapperCellView.leadingAnchor, constant: 16),
                imageProfile.trailingAnchor.constraint(equalTo: wrapperCellView.trailingAnchor, constant: -16),
                imageProfile.heightAnchor.constraint(equalToConstant: 200),

                labelContent.topAnchor.constraint(equalTo: imageProfile.bottomAnchor, constant: 8),
                labelContent.leadingAnchor.constraint(equalTo: wrapperCellView.leadingAnchor, constant: 16),
                labelContent.trailingAnchor.constraint(equalTo: wrapperCellView.trailingAnchor, constant: -16),

                labelTimestamp.topAnchor.constraint(equalTo: labelContent.bottomAnchor, constant: 8),
                labelTimestamp.leadingAnchor.constraint(equalTo: wrapperCellView.leadingAnchor, constant: 16),
                labelTimestamp.trailingAnchor.constraint(equalTo: wrapperCellView.trailingAnchor, constant: -16),

                createdByLabel.topAnchor.constraint(equalTo: labelTimestamp.bottomAnchor, constant: 8),
                createdByLabel.trailingAnchor.constraint(equalTo: wrapperCellView.trailingAnchor, constant: -16),
                createdByLabel.bottomAnchor.constraint(equalTo: wrapperCellView.bottomAnchor, constant: -16)
            ])
    }

    func configure(with post: Unauthpost, at indexPath: IndexPath) {
        labelTitle.text = post.title
        labelContent.text = post.content
        labelTimestamp.text = formatDate(post.timestamp)
        createdByLabel.text = "Created By Nitin" // Update with actual creator
        if let imageUrl = URL(string: post.image ?? "") {
            loadImage(from: imageUrl)
        } else {
            imageProfile.image = UIImage(named: "defaultImage")
        }
    }

    private func loadImage(from url: URL) {
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let data = data, error == nil else {
                // Set default image if loading fails
                DispatchQueue.main.async {
                    self?.imageProfile.image = UIImage(named: "defaultImage")
                }
                return
            }
            DispatchQueue.main.async {
                // Set image from data
                self?.imageProfile.image = UIImage(data: data)
            }
        }
        task.resume()
    }

    private func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d, HH:mm"
        return formatter.string(from: date)
    }
}
