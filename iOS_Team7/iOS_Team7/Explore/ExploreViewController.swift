//
//  ExploreViewController.swift
//  iOS_Team7
//
//  Created by Nitin Bhat on 4/14/24.
//

import UIKit


class ExploreViewController: UIViewController {
    
    let exploreViewScreen = ExploreView()
    
    let post1 = Unauthpost(title: "First Post", content: "This is the content of the first post.", timestamp: Date(), image: img)
    let post2 = Unauthpost(title: "Second Post", content: "This is the content of the second post.", timestamp: Date().addingTimeInterval(3600), image: img)
    let post3 = Unauthpost(title: "Third Post", content: "This is the content of the third post.", timestamp: Date().addingTimeInterval(7200), image: img)
    let post4 = Unauthpost(title: "Fourth Post", content: "This is the content of the first post.", timestamp: Date(), image: img)
    let post5 = Unauthpost(title: "Fifth Post", content: "This is the content of the second post.", timestamp: Date().addingTimeInterval(3600), image: img)
    let post6 = Unauthpost(title: "Sixth Post", content: "This is the content of the third post.", timestamp: Date().addingTimeInterval(7200), image: img)
    private var posts: [Unauthpost] = []
    
    override func loadView() {
        view = exploreViewScreen
        posts = [post1, post2, post3, post4 , post5 , post6]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Explore"
        navigationItem.hidesBackButton = true
        
        exploreViewScreen.tableView.delegate = self
        exploreViewScreen.tableView.dataSource = self
//        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Profile", style: .plain, target: self, action: #selector(profileTapped))
//        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add Note", style: .plain, target: self, action: #selector(AddTapped))
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
        exploreViewScreen.tableView.register(TableViewCell.self, forCellReuseIdentifier: "Unauthpost")
    }
}


extension ExploreViewController: UITableViewDataSource,UITableViewDelegate {
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
