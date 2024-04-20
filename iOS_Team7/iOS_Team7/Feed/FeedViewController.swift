//
//  FeedViewController.swift
//  iOS_Team7
//
//  Created by Nitin Bhat on 4/14/24.
//

import UIKit
import FirebaseFirestore

let img = "https://firebasestorage.googleapis.com:443/v0/b/ioschatapp-db85d.appspot.com/o/userImages%2F0544EA62-604F-46E7-8A00-61949D2385AD.jpg?alt=media&token=213edf7c-4fab-4c83-8c3f-42e85898754d"

class FeedViewController: UIViewController, UITextFieldDelegate {
    
    let feedViewScreen = FeedView()
    
    private var posts: [Authpost] = []
    private var filteredPosts: [Authpost] = []
    
    override func loadView() {
        view = feedViewScreen
//        fetchPosts { [weak self] fetchedPosts in
        fetchPosts { [weak self] fetchedPosts in
                self?.posts = fetchedPosts
                self?.feedViewScreen.tableView.reloadData() // Reload table view after fetching posts
        }

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Feed"
        navigationItem.hidesBackButton = true
        
        feedViewScreen.tableView.delegate = self
        feedViewScreen.tableView.dataSource = self
        feedViewScreen.searchBar.delegate=self
        //self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Profile", style: .plain, target: self, action: #selector(profileTapped))
        //self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add Note", style: .plain, target: self, action: #selector(AddTapped))
    }
    
    func reloadTableData() {
            fetchPosts { [weak self] fetchedPosts in
                self?.posts = fetchedPosts
                self?.feedViewScreen.tableView.reloadData()
            }
        }
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // Ensure we're dealing with the expertiseField
        
        guard textField == feedViewScreen.searchBar else {
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
        filteredPosts = posts.filter { post in
                return post.tags.contains(where: { $0.lowercased().starts(with:(text.lowercased())) })
        }
        
        // Reload the data of the picker view
        feedViewScreen.tableView.reloadData()
        
        // Show the picker view
        feedViewScreen.tableView.isHidden = false
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
        feedViewScreen.tableView.register(FeedTableViewCell.self, forCellReuseIdentifier: "Authpost")
    }
    
    
    func fetchPosts(completion: @escaping ([Authpost]) -> Void) {
        AuthModel().getCurrentUserDetails { userDetails, error in
            guard error == nil else {
                print("Error fetching current user details: \(error?.localizedDescription ?? "Unknown error")")
                completion([])
                return
            }
            
            let follows = userDetails["follows"] as? [String] ?? []
            
            let db = Firestore.firestore()
            var posts = [Authpost]()
            
            // Fetch posts where the title is in the follows list
            db.collection("posts").whereField("title", in: follows).getDocuments { (querySnapshot, error) in
                if let error = error {
                    print("Error fetching posts: \(error.localizedDescription)")
                    completion([])
                    return
                }
                
                for document in querySnapshot!.documents {
                    let data = document.data()
                    let title = data["title"] as? String ?? ""
                    let content = data["content"] as? String ?? ""
                    let timestamp = (data["timestamp"] as? Timestamp)?.dateValue() ?? Date()
                    let imageUrl = data["image"] as? String ?? ""
                    let tags = data["tags"] as? [String] ?? []
                    let author = data["author"] as? String ?? ""
                    
                    let post = Authpost(title: title, content: content, timestamp: timestamp, image: imageUrl, tags:tags, author:author)
                    posts.append(post)
                }
                
                completion(posts)
            }
        }
    }
//    func fetchPosts(completion: @escaping ([Authpost]) -> Void) {
//        let db = Firestore.firestore()
//        var posts = [Authpost]()
//
//        db.collection("posts").getDocuments { (querySnapshot, error) in
//            if let error = error {
//                print("Error fetching posts: \(error.localizedDescription)")
//                completion([])
//                return
//            }
//            print("querySnapshot", querySnapshot!.documents )
//            for document in querySnapshot!.documents {
//                let data = document.data()
//                let title = data["title"] as? String ?? ""
//                let content = data["content"] as? String ?? ""
//                let timestamp = (data["timestamp"] as? Timestamp)?.dateValue() ?? Date()
//                let imageUrl = data["image"] as? String ?? ""
//                let tags = data["tags"] as? [String] ?? []
//                let author = data["author"] as? String ?? ""
//
//                let post = Authpost(title: title, content: content, timestamp: timestamp, image: imageUrl, tags:tags, author:author)
//                posts.append(post)
//                print("each", post)
//            }
//
//            completion(posts)
//            print("posts",posts)
//        }
//    }
}


extension FeedViewController: UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if feedViewScreen.searchBar.text?.isEmpty ?? true{
            return posts.count
        }
        else{
            return filteredPosts.count // Return the number of chat groups
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Authpost", for: indexPath) as! FeedTableViewCell
        
        if feedViewScreen.searchBar.text?.isEmpty ?? true{
            let post = posts[indexPath.row] // Get the chat group for the current row
            cell.configure(with: post, at: indexPath)
        } // Configure the cell with the chat group
//        print("Chat :: ")
//        print(post)
        else{
            let post = filteredPosts[indexPath.row]
            cell.configure(with: post, at: indexPath)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print("REACHED select")
        print(self.posts[indexPath.row]);
        
        if feedViewScreen.searchBar.text?.isEmpty ?? true {
            // If search text is empty, use posts array
            print(self.posts[indexPath.row])
        } else {
            // If search text is not empty, use filteredPosts array
            print(self.filteredPosts[indexPath.row])
        }
        //let chatScreenViewController = ChatScreenViewController(chatID: self.chats[indexPath.row].chatID);
             //pushing showProfilController to navigation controller...
            // navigationController?.pushViewController(chatScreenViewController, animated: true)
    }
}
