//
//  ViewController.swift
//  iOS_Team7
//
//  Created by Shrada Chellasami on 3/22/24.
//

import UIKit

class ViewController: UIViewController {
    
    let homeScreen = HomeView()
    
//    let post1 = Unauthpost(title: "First Post", content: "This is the content of the first post.", timestamp: Date(), image: img)
    
    let post1 = Unauthpost(title: "Tips for Maintaining Good Skin Health", content: "To maintain good skin health, it's essential to follow a consistent skincare routine tailored to your skin type. Cleansing, moisturizing, and using sunscreen daily can help protect your skin from environmental damage and premature aging. Exfoliating regularly can also help remove dead skin cells and promote cell turnover, revealing a brighter, more radiant complexion.", timestamp: Date(), image: img
    )
    
    let post2 = Unauthpost(
       title: "Incorporating Exercise into Your Lifestyle",
       content: "Regular exercise is crucial for maintaining overall physical and mental well-being. Incorporating a combination of cardiovascular exercises, strength training, and flexibility exercises into your routine can help improve cardiovascular health, build muscle strength, increase endurance, and reduce the risk of chronic diseases. Aim for at least 150 minutes of moderate-intensity aerobic activity or 75 minutes of vigorous-intensity aerobic activity per week, along with two or more days of strength training exercises.",
       timestamp: Date(),
       image: img
       
    )
    
    
    let post3 = Unauthpost(
       title: "Understanding and Managing Mental Illnesses",
       content: "Mental health is an essential aspect of overall well-being. Mental illnesses like depression, anxiety, and bipolar disorder can have a significant impact on daily life and functioning. Seeking professional help from a mental health provider, such as a therapist or counselor, can provide valuable support and evidence-based treatments. In addition, practicing self-care strategies like mindfulness, exercise, and maintaining a healthy lifestyle can also contribute to better mental health management.",
       timestamp: Date(),
       image: img
    )

    
    
    
    private var posts: [Unauthpost] = []


    
    override func loadView() {
           view = homeScreen
           posts = [post1, post2, post3]
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

