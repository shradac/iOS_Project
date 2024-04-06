//
//  TableViewCell.swift
//  iOS_Team7
//
//  Created by Nitin Bhat on 4/4/24.
//

import UIKit

class TableViewCell: UITableViewCell {
    var wrapperCellView: UIView!
    var labelTitle: UILabel!
    var labelContent: UILabel!
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
        labelTitle = UILabel()
        labelTitle.font = UIFont.boldSystemFont(ofSize: 16)
        labelTitle.translatesAutoresizingMaskIntoConstraints = false
        wrapperCellView.addSubview(labelTitle)

        labelContent = UILabel()
        labelContent.font = UIFont.systemFont(ofSize: 14)
        labelContent.textColor = .gray
        labelContent.numberOfLines = 2 // Adjust as needed
        labelContent.translatesAutoresizingMaskIntoConstraints = false
        wrapperCellView.addSubview(labelContent)

        labelTimestamp = UILabel()
        labelTimestamp.font = UIFont.systemFont(ofSize: 12)
        labelTimestamp.textColor = .gray
        labelTimestamp.translatesAutoresizingMaskIntoConstraints = false
        wrapperCellView.addSubview(labelTimestamp)
    }

    func setupImageProfile() {
        imageProfile = UIImageView()
        imageProfile.image = UIImage(named: "logo")
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

            labelTitle.leadingAnchor.constraint(equalTo: imageProfile.trailingAnchor, constant: 16),
            labelTitle.topAnchor.constraint(equalTo: imageProfile.topAnchor),
            labelTitle.trailingAnchor.constraint(equalTo: wrapperCellView.trailingAnchor, constant: -16),

            labelContent.leadingAnchor.constraint(equalTo: labelTitle.leadingAnchor),
            labelContent.topAnchor.constraint(equalTo: labelTitle.bottomAnchor, constant: 8),
            labelContent.trailingAnchor.constraint(equalTo: wrapperCellView.trailingAnchor, constant: -16),

            labelTimestamp.trailingAnchor.constraint(equalTo: wrapperCellView.trailingAnchor, constant: -16),
            labelTimestamp.topAnchor.constraint(equalTo: labelContent.bottomAnchor, constant: 8),
            labelTimestamp.bottomAnchor.constraint(equalTo: wrapperCellView.bottomAnchor, constant: -16)
        ])
    }

    func configure(with post: Unauthpost, at indexPath: IndexPath) {
        labelTitle.text = post.title
        labelContent.text = post.content
        labelTimestamp.text = formatDate(post.timestamp)
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
