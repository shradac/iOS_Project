//
//  AuthModel.swift
//  iOS_Team7
//
//  Created by Nitin Bhat on 4/4/24.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class AuthModel {
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
                   completion(newUser, nil)
               }
           }

}
