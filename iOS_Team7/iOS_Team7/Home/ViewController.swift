//
//  ViewController.swift
//  iOS_Team7
//
//  Created by Shrada Chellasami on 3/22/24.
//

import UIKit

class ViewController: UIViewController {
    
    let homeScreen = HomeView()
    
    let post1 = Unauthpost(title: "First Post", content: "This is the content of the first post.", timestamp: Date(), image: img)
    let post2 = Unauthpost(title: "Second Post", content: "This is the content of the second post.", timestamp: Date().addingTimeInterval(3600), image: img)
    let post3 = Unauthpost(title: "Third Post", content: "This is the content of the third post.", timestamp: Date().addingTimeInterval(7200), image: img)
    let post4 = Unauthpost(title: "Fourth Post", content: "This is the content of the first post.", timestamp: Date(), image: img)
    let post5 = Unauthpost(title: "Fifth Post", content: "This is the content of the second post.", timestamp: Date().addingTimeInterval(3600), image: img)
    let post6 = Unauthpost(title: "Sixth Post", content: "This is the content of the third post.", timestamp: Date().addingTimeInterval(7200), image: img)
    
    private var posts: [Unauthpost] = []


    
    override func loadView() {
           view = homeScreen
           posts = [post1, post2, post3, post4 , post5 , post6]
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Home"
        
        homeScreen.tableView.delegate = self
        homeScreen.tableView.dataSource = self
        
        homeScreen.registerBtn.addTarget(self, action: #selector(registerBtnTapped), for: .touchUpInside)
        homeScreen.loginBtn.addTarget(self, action: #selector(loginBtnTapped), for: .touchUpInside)
        
    }
    
    @objc func registerBtnTapped(){
            let registerController = RegisterViewController()
            navigationController?.pushViewController(registerController, animated: true)
    }
    
    @objc func loginBtnTapped(){
            let loginController = LoginViewController()
            navigationController?.pushViewController(loginController, animated: true)
    }
    
    private func setupTableView() {
            homeScreen.tableView.register(TableViewCellUnAuthPost.self, forCellReuseIdentifier: "Unauthpost")
    }
}


extension ViewController: UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count // Return the number of chat groups
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Unauthpost", for: indexPath) as! TableViewCellUnAuthPost
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

