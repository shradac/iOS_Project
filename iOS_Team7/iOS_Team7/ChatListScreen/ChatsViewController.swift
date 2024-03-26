//
//  ChatsViewController.swift
//  iOS_Team7
//
//  Created by Nitin Bhat on 3/26/24.
//

import UIKit
import FirebaseAuth

class ChatsViewController: UIViewController {
    private let notesView = ChatsView()
    private let model = Model()
    private var chats: [ChatPanel] = []

    
    override func loadView() {
        view = notesView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "My Chats"
          
        getAllChats()
        
        print("CHATS ON LOAD")
        print(chats)
        
        setupTableView()
        notesView.tableViewNote.dataSource = self
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            title: "Profile",
            style: .plain,
            target: self,
            action: #selector(profileButtonTapped)
        )

        
    }
    
    private func getAllChats() {
        guard let currentUserEmail = Auth.auth().currentUser?.email else {
                print("Error: Current user email is nil")
                return
            }

            model.getChatPanels(for: currentUserEmail) { [weak self] chatPanels, error in
                guard let self = self else { return }
                
                if let error = error {
                    print("Error fetching chat panels: \(error)")
                    return
                }
                
                if let chatPanels = chatPanels {
                    self.chats = chatPanels
                    
                    // Reload table view after fetching chat panels
                    DispatchQueue.main.async {
                        self.notesView.tableViewNote.reloadData()
                    }
                }
            }
    }
    
    
    
    @objc func profileButtonTapped() {
        if let currentUser = Auth.auth().currentUser {
            let uid = currentUser.uid
            let email = currentUser.email
            let displayName = currentUser.displayName
            
            // Assuming you have a 'User' struct or class
            let user = User(id: uid, name: displayName ?? "", email: email ?? "")
            
            // Proceed to display user information or navigate to profile view
            DispatchQueue.main.async {
                let profileViewController = ProfileViewController(userInfo: user)
                self.navigationController?.pushViewController(profileViewController, animated: true)
            }
        } else {
            // No user signed in, handle accordingly
            DispatchQueue.main.async {
                let alert = UIAlertController(title: "Error", message: "No user signed in", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    
    private func setupTableView() {
        notesView.tableViewNote.register(ChatsTableViewCell.self, forCellReuseIdentifier: ChatsTableViewCell.identifier)
    }
    
    
}

extension ChatsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chats.count // Return the number of chat groups
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ChatsTableViewCell.identifier, for: indexPath) as! ChatsTableViewCell
        let chat = chats[indexPath.row] // Get the chat group for the current row
        cell.configure(with: chat, at: indexPath) // Configure the cell with the chat group
        print("Chat :: ")
        print(chat)
        return cell
    }
}


