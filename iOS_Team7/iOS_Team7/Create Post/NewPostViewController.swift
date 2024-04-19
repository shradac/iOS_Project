//
//  NewPostViewController.swift
//  iOS_Team7
//
//  Created by Vasu Agarwal on 4/18/24.
//

import UIKit
import FirebaseFirestoreInternal

class NewPostViewController: UIViewController {

    let newPostScreen = NewPostView()
    
    override func loadView() {
       view = newPostScreen
    }

    override func viewDidLoad() {

        super.viewDidLoad()
        
        title = "Create Post"
        
        newPostScreen.saveButton.addTarget(self, action: #selector(saveBtnTapped), for: .touchUpInside)
        
    }
    
    @objc func saveBtnTapped(){
        let postTitle = newPostScreen.titleTextField.text ?? ""
        let postContent = newPostScreen.contentTextView.text ?? ""
//        let postImage = newPostScreen.imageView.image!
        
        if postTitle.isEmpty || postContent.isEmpty {
            showAlert(message: "Title or content cannot be empty.")
            return
        }
        
        let newPost = Unauthpost(title: postTitle, content: postContent, timestamp: Date.now, image: "")
                
        // Create a new post
        let db = Firestore.firestore()
                
        let postData: [String: Any] = [
            "title": newPost.title,
            "content": newPost.content,
            "timestamp": newPost.timestamp,
            "image": newPost.image
        ]
        
        db.collection("posts").addDocument(data: postData) { error in
            if let error = error {
                // Handle error while adding document
                print("Error adding document: \(error)")
            } else {
                // Post added successfully
                print("Document added successfully")
            }
        }
                
        navigationController?.popViewController(animated: true)
    }
    
    private func showAlert(message: String) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }

}
