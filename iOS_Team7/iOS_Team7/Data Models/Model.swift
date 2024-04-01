import Foundation
import FirebaseAuth
import FirebaseFirestore

class Model {
    var chats: [Chat] = []
    var chatMessages: [ChatMessage] = []
    var users: [User] = []
    
    
    func sendWelcomeMessageToAllUsers(senderId: String , welcomeMessage: String, completion: @escaping (Error?) -> Void) {
            // Retrieve all users from Firestore
            getAllUsers { [weak self] users, error in
                guard let self = self else { return }
                if let error = error {
                    completion(error)
                    return
                }
                
                // Iterate through each user and send the welcome message
                if let users = users {
                    let dispatchGroup = DispatchGroup()
                    
                   
                    
                    for user in users {
                        guard user.email != senderId else {
                                // Skip sending the welcome message to the user if their email matches the senderId
                                continue
                        }
                        dispatchGroup.enter()
                        
                        // Create a new chat
                            createChat(participants: [senderId, user.email ?? ""]) { [weak self] chatId, error in
                                guard let self = self else { return }
                                
                                if let unwrappedChatId = chatId {
                                    // Send welcome message to the new chat
                                    self.sendMessage(text: welcomeMessage, chatId: unwrappedChatId, senderId: senderId) { error in
                                        if let error = error {
                                            print("Failed to send welcome message to all users: \(error.localizedDescription)")
                                        }
                                        completion(error)
                                    }
                                } else if let error = error {
                                    // Handle error if creating chat failed
                                    completion(error)
                                } else {
                                    // Handle unexpected case where both chatId and error are nil
                                    let error = NSError(domain: "Unexpected error", code: 0, userInfo: nil)
                                    print("Failed to send welcome message to all users: \(error.localizedDescription)")
                                    completion(error)
                                }
                            }
                    }
                    
                    // Notify completion when all messages are sent
                    dispatchGroup.notify(queue: .main) {
                        completion(nil)
                    }
                }
            }
    }
    
    func appendUser(_ user: User) {
            users.append(user)
    }
    
    // Create a new user in Firestore
       func createUser(name: String, email: String, completion: @escaping (User?, Error?) -> Void) {
           let db = Firestore.firestore()
           var newUserRef: DocumentReference?
           
           let userData: [String: Any] = [
               "name": name,
               "email": email
           ]
           
           newUserRef = db.collection("users").addDocument(data: userData) { error in
               if let error = error {
                   completion(nil, error)
                   return
               }
               
               guard let userId = newUserRef?.documentID else {
                   completion(nil, NSError(domain: "User document ID is nil", code: 0, userInfo: nil))
                   return
               }
               
               let newUser = User(id: userId, name: name, email: email)
               self.appendUser(newUser) // Add the new user to the list
               completion(newUser, nil)
           }
       }

       // Get all users from Firestore
       func getAllUsers(completion: @escaping ([User]?, Error?) -> Void) {
           let db = Firestore.firestore()
           db.collection("users").getDocuments { snapshot, error in
               if let error = error {
                   completion(nil, error)
                   return
               }

               var users: [User] = []
               for document in snapshot!.documents {
                   let userData = document.data()
                   let userId = document.documentID
                   let name = userData["name"] as? String ?? ""
                   let email = userData["email"] as? String ?? ""
                   let user = User(id: userId, name: name, email: email)
                   users.append(user)
               }

               completion(users, nil)
           }
      }
   
    
    
    private func createChat(participants: [String], completion: @escaping (String?, Error?) -> Void) {
        let db = Firestore.firestore()
        let chatData: [String: Any] = [
            "participants": participants
        ]
        
        let chatRef = db.collection("chats").document()
        let chatId = chatRef.documentID
        
        chatRef.setData(chatData) { error in
            if let error = error {
                completion(nil, error)
            } else {
                completion(chatId, nil)
            }
        }
    }
    

    // Fetch 1:1 chats for the current user
    func fetchChats(for email: String, completion: @escaping ([Chat]?, Error?) -> Void) {
        print("SEARCHING CHATS for ", email)
        let db = Firestore.firestore()
        db.collection("chats")
            .whereField("participants", arrayContains: email)
            .getDocuments { snapshot, error in
                if let error = error {
                    print("ERROR caught looking for ",email)
                    completion(nil, error)
                } else {
                    var chats: [Chat] = []
                    for document in snapshot!.documents {
                        let chat = Chat(id: document.documentID, participants: document["participants"] as? [String] ?? [])
                        chats.append(chat)
                    }
                    completion(chats, nil)
                }
            }
    }
    
    // Fetch chat messages for a specific chat
    func fetchMessages(for chatId: String, completion: @escaping ([ChatMessage]?, Error?) -> Void) {
        let db = Firestore.firestore()
        db.collection("chats").document(chatId).collection("messages")
            .order(by: "dateCreated", descending: false) // Update orderBy to match ChatMessage timestamp
            .getDocuments { snapshot, error in
                if let error = error {
                    completion(nil, error)
                } else {
                    var messages: [ChatMessage] = []
                    for document in snapshot!.documents {
                        let message = ChatMessage(messageId: document.documentID, // Assign documentID as messageId
                                                  senderId: document["uid"] as? String ?? "",
                                                  text: document["text"] as? String ?? "",
                                                  timestamp: (document["dateCreated"] as? Timestamp)?.dateValue() ?? Date())
                        messages.append(message)
                    }
                    completion(messages, nil)
                }
            }
    }

    // Send a message to a specific chat
    func sendMessage(text: String, chatId: String, senderId: String, completion: @escaping (Error?) -> Void) {
        let db = Firestore.firestore()
        let messageData: [String: Any] = [
            "text": text,
            "uid": senderId,
            "dateCreated": FieldValue.serverTimestamp()
        ]
        db.collection("chats").document(chatId).collection("messages")
            .addDocument(data: messageData) { error in
                completion(error)
            }
    }

    // Listen for new messages in a specific chat
    func listenForMessages(in chatId: String, completion: @escaping ([ChatMessage], Error?) -> Void) -> ListenerRegistration {
        let db = Firestore.firestore()
        return db.collection("chats").document(chatId).collection("messages")
            .order(by: "dateCreated", descending: true)
            .addSnapshotListener { snapshot, error in
                if let error = error {
                    completion([], error)
                    return
                }
                
                guard let snapshot = snapshot else {
                    completion([], nil)
                    return
                }
                
                var newMessages: [ChatMessage] = []
                for document in snapshot.documents {
                    let message = ChatMessage(messageId: document.documentID,
                                              senderId: document["uid"] as? String ?? "",
                                              text: document["text"] as? String ?? "",
                                              timestamp: (document["dateCreated"] as? Timestamp)?.dateValue() ?? Date())
                    newMessages.append(message)
                }
                completion(newMessages, nil)
            }
    }
    
    
    func getChatPanels(for email: String, completion: @escaping ([ChatPanel]?, Error?) -> Void) {
            fetchChats(for: email) { [weak self] (chats, error) in
                guard let self = self else { return }
                if let error = error {
                    completion(nil, error)
                    return
                }
                
                var chatPanels: [ChatPanel] = []
                let dispatchGroup = DispatchGroup()
                
                if let chats = chats {
                    for chat in chats {
                        dispatchGroup.enter()
                        
                        let otherParticipantEmail = chat.participants.first { $0 != email }
                        print("EMAIL")
                        print(otherParticipantEmail)
                        if let otherParticipantEmail = otherParticipantEmail {
                            self.fetchLastMessage(for: chat.id) { (lastMessage, timestamp, error) in
                                
                                print("CHAT ID")
                                print(chat.id)
                                
                                print("LAST MSG")
                                print(lastMessage)
                                
                                
                                if let error = error {
                                    print("Error fetching last message: \(error)")
                                    dispatchGroup.leave()
                                    return
                                }
                                
                                let chatPanel = ChatPanel(
                                    chatID: chat.id,
                                    senderEmail: otherParticipantEmail,
                                    lastMessage: lastMessage ?? "",
                                    timestampLastMsg: timestamp ?? Date()
                                )
                                chatPanels.append(chatPanel)
                                dispatchGroup.leave()
                            }
                        }
                    }
                }
                
                dispatchGroup.notify(queue: .main) {
                    completion(chatPanels, nil)
                }
            }
        }
        
    func fetchLastMessage(for chatID: String, completion: @escaping (String?, Date?, Error?) -> Void) {
         let db = Firestore.firestore()
         db.collection("chats").document(chatID).collection("messages")
                .order(by: "dateCreated", descending: true)
                .limit(to: 1)
                .getDocuments { snapshot, error in
                    if let error = error {
                        completion(nil, nil, error)
                        return
                    }

                    guard let snapshot = snapshot else {
                        completion(nil, nil, NSError(domain: "Snapshot is nil", code: 0, userInfo: nil))
                        return
                    }

                    if let document = snapshot.documents.first {
                        print("doc found")
                        print(document)
                        let message = document["text"] as? String ?? ""
                        let timestamp = (document["dateCreated"] as? Timestamp)?.dateValue()
                        completion(message, timestamp, nil)
                    } else {
                        print("No messages found")
                        completion(nil, nil, nil) // No messages found
                    }
                }
    }

}
