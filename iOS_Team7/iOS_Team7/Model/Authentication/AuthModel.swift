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
