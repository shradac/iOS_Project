//
//  ExploreViewController.swift
//  iOS_Team7
//
//  Created by Nitin Bhat on 4/14/24.
//

import UIKit
import FirebaseFirestore



class ExploreViewController: UIViewController, UITextFieldDelegate {
    
    let exploreViewScreen = ExploreView()
    
    let post1 = Unauthpost(title: "First Post", content: "This is the content of the first post.", timestamp: Date(), image: img)
    let post2 = Unauthpost(title: "Second Post", content: "This is the content of the second post.", timestamp: Date().addingTimeInterval(3600), image: img)
    let post3 = Unauthpost(title: "Third Post", content: "This is the content of the third post.", timestamp: Date().addingTimeInterval(7200), image: img)
    let post4 = Unauthpost(title: "Fourth Post", content: "This is the content of the first post.", timestamp: Date(), image: img)
    let post5 = Unauthpost(title: "Fifth Post", content: "This is the content of the second post.", timestamp: Date().addingTimeInterval(3600), image: img)
    let post6 = Unauthpost(title: "Sixth Post", content: "This is the content of the third post.", timestamp: Date().addingTimeInterval(7200), image: img)
    private var posts: [Unauthpost] = []
    private var filteredPosts: [Unauthpost] = []
    
    override func loadView() {
        view = exploreViewScreen
//        posts = [post1, post2, post3, post4 , post5 , post6]
        
        
        fetchPosts { [weak self] fetchedPosts in
                self?.posts = fetchedPosts
                self?.exploreViewScreen.tableView.reloadData() // Reload table view after fetching posts
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Explore"
        navigationItem.hidesBackButton = true
        
        exploreViewScreen.tableView.delegate = self
        exploreViewScreen.tableView.dataSource = self
        exploreViewScreen.searchBar.delegate = self
//        hidePosts()
//        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Profile", style: .plain, target: self, action: #selector(profileTapped))
//        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add Note", style: .plain, target: self, action: #selector(AddTapped))
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // Ensure we're dealing with the expertiseField
        
        guard textField == exploreViewScreen.searchBar else {
            return true
        }

        // Calculate the new text after the replacement
        let currentText = textField.text ?? ""
        guard let newTextRange = Range(range, in: currentText) else {
            return true
        }
        let newText = currentText.replacingCharacters(in: newTextRange, with: string)
        
        // Show or hide suggestions based on the new text
        if !newText.isEmpty {
            showPosts(for: newText)
        } else {
            hidePosts()
        }

        return true
    }
    
    func showPosts(for text: String) {
        print("while typing", text)
        filteredPosts = posts.filter { $0.title.lowercased().starts(with: text.lowercased())}
        
        // Reload the data of the picker view
        exploreViewScreen.tableView.reloadData()
        
        // Show the picker view
        exploreViewScreen.tableView.isHidden = false
    }

    func hidePosts() {
        // Hide the picker view
//        exploreViewScreen.tableView.isHidden = true
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
    
    func fetchPosts(completion: @escaping ([Unauthpost]) -> Void) {
        let db = Firestore.firestore()
        var posts = [Unauthpost]()

        db.collection("posts").getDocuments { (querySnapshot, error) in
            if let error = error {
                print("Error fetching posts: \(error.localizedDescription)")
                completion([])
                return
            }
            print("querySnapshot", querySnapshot!.documents )
            for document in querySnapshot!.documents {
                let data = document.data()
                let title = data["title"] as? String ?? ""
                let content = data["content"] as? String ?? ""
                let timestamp = (data["timestamp"] as? Timestamp)?.dateValue() ?? Date()
                let imageUrl = data["image"] as? String ?? ""

                let post = Unauthpost(title: title, content: content, timestamp: timestamp, image: imageUrl)
                posts.append(post)
                print("each", post)
            }

            completion(posts)
            print("posts",posts)
        }
    }
}

//
//extension ExploreViewController: UITableViewDataSource,UITableViewDelegate {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return posts.count // Return the number of chat groups
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "Unauthpost", for: indexPath) as! TableViewCell
//        let post = posts[indexPath.row] // Get the chat group for the current row
//        cell.configure(with: post, at: indexPath) // Configure the cell with the chat group
//        print("Chat :: ")/Users/shradachellasami/Documents/MAD/iOS_Project/iOS_Team7/iOS_Team7/Feed/FeedViewController.swift
//        print(post)
//        return cell
//    }
//    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print("REACHED select")
//        print(self.posts[indexPath.row]);
//        //let chatScreenViewController = ChatScreenViewController(chatID: self.chats[indexPath.row].chatID);
//             //pushing showProfilController to navigation controller...
//            // navigationController?.pushViewController(chatScreenViewController, animated: true)
//    }
//}

extension ExploreViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Check if search text is empty
        if exploreViewScreen.searchBar.text?.isEmpty ?? true {
            // If search text is empty, display all posts
            return posts.count
        } else {
            // If search text is not empty, display filtered posts
            return filteredPosts.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Unauthpost", for: indexPath) as! TableViewCell
        // Check if search text is empty
        if exploreViewScreen.searchBar.text?.isEmpty ?? true {
            // If search text is empty, use posts array
            let post = posts[indexPath.row]
            cell.configure(with: post, at: indexPath)
        } else {
            // If search text is not empty, use filteredPosts array
            let post = filteredPosts[indexPath.row]
            cell.configure(with: post, at: indexPath)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("REACHED select")
        // Check if search text is empty
        if exploreViewScreen.searchBar.text?.isEmpty ?? true {
            // If search text is empty, use posts array
            print(self.posts[indexPath.row])
        } else {
            // If search text is not empty, use filteredPosts array
            print(self.filteredPosts[indexPath.row])
        }
        // Perform any actions you need when a row is selected
    }
}
