//
//  FeedViewController.swift
//  iOS_Team7
//
//  Created by Nitin Bhat on 4/14/24.
//

import UIKit

let img = "https://firebasestorage.googleapis.com:443/v0/b/ioschatapp-db85d.appspot.com/o/userImages%2F0544EA62-604F-46E7-8A00-61949D2385AD.jpg?alt=media&token=213edf7c-4fab-4c83-8c3f-42e85898754d"

class FeedViewController: UIViewController {
    
    let feedViewScreen = FeedView()
    
    let post1 = Unauthpost(title: "First Post", content: "This is the content of the first post.This is the content of the first post.This is the content of the first post.This is the content of the first post.This is the content of the first post.This is the content of the first post.This is the content of the first post.This is the content of the first post.This is the content of the first post.This is the content of the first post.This is the content of the first post.This is the content of the first post.This is the content of the first post.This is the content of the first post.This is the content of the first post.This is the content of the first post.This is the content of the first post.This is the content of the first post.This is the content of the first post.This is the content of the first post.This is the content of the first post.", timestamp: Date(), image: img)
    let post2 = Unauthpost(title: "Second Post", content: "This is the content of the second post.", timestamp: Date().addingTimeInterval(3600), image: img)
    let post3 = Unauthpost(title: "Third Post", content: "This is the content of the third post.", timestamp: Date().addingTimeInterval(7200), image: img)
    let post4 = Unauthpost(title: "Fourth Post", content: "This is the content of the first post.", timestamp: Date(), image: img)
    let post5 = Unauthpost(title: "Fifth Post", content: "This is the content of the second post.", timestamp: Date().addingTimeInterval(3600), image: img)
    let post6 = Unauthpost(title: "Sixth Post", content: "This is the content of the third post.", timestamp: Date().addingTimeInterval(7200), image: img)

    
    private var posts: [Unauthpost] = []
    
    override func loadView() {
        view = feedViewScreen
        posts = [post1, post2, post3, post4 , post5 , post6]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Feed"
        navigationItem.hidesBackButton = true
        
        feedViewScreen.tableView.delegate = self
        feedViewScreen.tableView.dataSource = self
        //self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Profile", style: .plain, target: self, action: #selector(profileTapped))
        //self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add Note", style: .plain, target: self, action: #selector(AddTapped))
        
                
    }
    
    @objc func feedButtonTapped() {
            print("Feed button tapped")
            // Implement action for feed button
    }
        
    @objc func exploreButtonTapped() {
            print("Explore button tapped")
            // Implement action for explore button
    }
    
    @objc func profileTapped(){
        print("navigate to profile")
    }
    
    @objc func AddTapped(){
        print("navigate to add note")
    }
    
    private func setupTableView() {
        feedViewScreen.tableView.register(TableViewCell.self, forCellReuseIdentifier: "Unauthpost")
    }
}


extension FeedViewController: UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count // Return the number of chat groups
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Unauthpost", for: indexPath) as! TableViewCell
        let post = posts[indexPath.row] // Get the chat group for the current row
        cell.configure(with: post, at: indexPath) // Configure the cell with the chat group
        print("Chat :: ")
        print(post)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("REACHED select")
        print(self.posts[indexPath.row]);
        //let chatScreenViewController = ChatScreenViewController(chatID: self.chats[indexPath.row].chatID);
             //pushing showProfilController to navigation controller...
            // navigationController?.pushViewController(chatScreenViewController, animated: true)
    }
}
