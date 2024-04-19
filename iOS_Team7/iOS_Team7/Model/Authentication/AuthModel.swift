//
//  AuthModel.swift
//  iOS_Team7
//
//  Created by Nitin Bhat on 4/4/24.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

import FirebaseStorage

class AuthModel {
    
    // Function to update the current user's 'follow' list
    func followPost(for postTitle: String, completion: @escaping (Error?) -> Void) {
        getCurrentUserDetails { userDetails, error in
            guard error == nil else {
                completion(error)
                return
            }

            var updatedFollows = userDetails["follows"] as? [String] ?? []
            // Check if the post title is not already in the 'follows' list
            if !updatedFollows.contains(postTitle) {
                updatedFollows.append(postTitle)
                let db = Firestore.firestore()
                let email = userDetails["email"] as? String ?? ""
                
                // Query Firestore to find the user document using email
                let usersRef = db.collection("users")
                let query = usersRef.whereField("email", isEqualTo: email)
                
                query.getDocuments { (querySnapshot, error) in
                    if let error = error {
                        completion(error)
                        return
                    }
                    
                    // Check if any document matches the query
                    if let document = querySnapshot?.documents.first {
                        // Document found, update 'follows' field
                        document.reference.updateData(["follows": updatedFollows]) { error in
                            if let error = error {
                                completion(error)
                            } else {
                                completion(nil)
                            }
                        }
                    } else {
                        let error = NSError(domain: "User document not found", code: 0, userInfo: nil)
                        completion(error)
                    }
                }
            } else {
                // Post title already exists in 'follows' list
                completion(nil)
            }
        }
    }
    
    func getCurrentUserDetails(completion: @escaping ([String: Any], Error?) -> Void) {
        if let currentUser = Auth.auth().currentUser {
            // Fetch basic user details from Firebase Authentication
            let email = currentUser.email ?? ""
            
            // Query Firestore to fetch additional user details including role using email
            let db = Firestore.firestore()
            let usersRef = db.collection("users")
            let query = usersRef.whereField("email", isEqualTo: email)
            
            query.getDocuments { (querySnapshot, error) in
                if let error = error {
                    // Error occurred
                    completion([:], error)
                } else {
                    // Check if any document matches the query
                    if let document = querySnapshot?.documents.first {
                        // Document found, extract user details including role
                        let userData = document.data()
                        let role = userData["role"] as? String ?? ""
                        let name = userData["name"] as? String ?? ""
                        let email = userData["email"] as? String ?? ""
                        let follows = userData["follows"] as? [String] ?? []
                        let tags = userData["tags"] as? [String] ?? []
                        let profileImageURL = userData["profileImageURL"] as? String ?? ""
                        
                        // Create a User object with fetched details
                        let user: [String: Any] = [
                            "name": name,
                            "email": email,
                            "role": role,
                            "follows" : follows,
                            "tags" : tags,
                            "profileImageURL": profileImageURL
                        ]
                        completion(user, nil)
                    } else {
                        // Document not found
                        let error = NSError(domain: "User document not found", code: 0, userInfo: nil)
                        completion([:], error)
                    }
                }
            }
        } else {
            // No user logged in
            let error = NSError(domain: "User not logged in", code: 0, userInfo: nil)
            completion([:], error)
        }
    }
    
    // Create a new user in Firestore
    func createUser(name: String, email: String, imageData: Data?, role: String, tags: [String], completion: @escaping (User?, Error?) -> Void) {
        let db = Firestore.firestore()
        let storageRef = Storage.storage().reference().child("userImages/\(UUID().uuidString).jpg") // Create a unique filename
        
        var newUserRef: DocumentReference?

        var userData: [String: Any] = [
            "name": name,
            "email": email,
            "role": role,
            "follows" : [],
            "tags" : tags
        ]

        if let imageData = imageData {
            // Upload image data to Firebase Storage
            storageRef.putData(imageData, metadata: nil) { metadata, error in
                guard let _ = metadata else {
                    completion(nil, error ?? NSError(domain: "Unknown error occurred while uploading image", code: 0, userInfo: nil))
                    return
                }
                
                // Get download URL for the uploaded image
                storageRef.downloadURL { (url, error) in
                    if let downloadURL = url {
                        // Add image URL to user data
                        userData["profileImageURL"] = downloadURL.absoluteString
                        
                        // Add user data to Firestore
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
                            completion(newUser, nil)
                        }
                    } else {
                        completion(nil, error ?? NSError(domain: "Unknown error occurred while retrieving image URL", code: 0, userInfo: nil))
                    }
                }
            }
        } else {
            // Add user data to Firestore without image
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
                completion(newUser, nil)
            }
        }
    }
}
