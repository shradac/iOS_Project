import UIKit
import FirebaseAuth

class ChatsViewController: UIViewController {
    private let notesView = ChatsView()
    private let model = Model()
    private var chats: [Chat] = []

    
    override func loadView() {
        view = notesView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "My Chats"
          
        getAllChats()
        
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
        // Fetch chat groups
        model.fetchChats(for: Auth.auth().currentUser?.email ?? "") { chats, error in
                    if let error = error {
                        print("Error fetching chat groups: \(error)")
                        return
                    }
                    
                    if let chats = chats {
                        self.chats = chats
                        
                        print("Fetched chats:")
                        for chat in chats {
                                       print(chat.id)
                        }
                        
                        // Reload table view after fetching chats
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
        return cell
    }
}


