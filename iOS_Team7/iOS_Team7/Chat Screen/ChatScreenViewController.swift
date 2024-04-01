//
//  ChatScreenViewController.swift
//  iOS_Team7
//
//  Created by Vasu Agarwal on 3/31/24.
//
import UIKit
import FirebaseFirestore
import FirebaseAuth

class ChatScreenViewController: UIViewController {
    // Declare properties
    var chatView: ChatScreenView!
    var messages: [ChatMessage] = []
    var chatID: String = "" // You need to set this with the specific chat ID
    
    // Firestore listener
    var listener: ListenerRegistration?
    
    init(chatID: String) {
       self.chatID = chatID
       print(self.chatID)
       super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
       fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        chatView = ChatScreenView()
        view = chatView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Chat"
        
        chatView.tableView.dataSource = self
        chatView.tableView.delegate = self
        
        // Fetch chat messages
        fetchMessages()
        
        // Listen for new messages
        listenForMessages()
    }
    
    deinit {
        // Remove Firestore listener when the view controller is deallocated
        listener?.remove()
    }
    
    func fetchMessages() {
        print("In fetch msg")
        Model().fetchMessages(for: chatID) { [weak self] (messages, error) in
            guard let self = self else { return }
            if let error = error {
                print("Error fetching messages: \(error.localizedDescription)")
                return
            }
            self.messages = messages ?? []
            self.chatView.tableView.reloadData()
        }
    }
    
    func listenForMessages() {
        listener = Model().listenForMessages(in: chatID) { [weak self] (newMessages, error) in
            guard let self = self else { return }
            if let error = error {
                print("Error listening for messages: \(error.localizedDescription)")
                return
            }
            self.messages = newMessages + self.messages
            self.chatView.tableView.reloadData()
        }
    }
}

extension ChatScreenViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChatCell", for: indexPath) as! ChatTableViewCell
        let message = messages[indexPath.row]
        
        // Determine message type (incoming or outgoing) based on senderId
        let messageType: MessageType = (message.senderId == Auth.auth().currentUser?.uid) ? .outgoing : .incoming
        
        // Configure cell with message data
        cell.configure(with: message.text, senderName: "", timestamp: message.timestamp.timeIntervalSince1970, type: messageType)
        
        return cell
    }
}
