//
//  NewPostViewController.swift
//  iOS_Team7
//
//  Created by Vasu Agarwal on 4/18/24.
//

import UIKit
import FirebaseFirestoreInternal
import PhotosUI
import FirebaseStorage

class NewPostViewController: UIViewController {

    let newPostScreen = NewPostView()
    var pickedImage:UIImage?
    
    override func loadView() {
       view = newPostScreen
    }

    override func viewDidLoad() {

        super.viewDidLoad()
        
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboardOnTap))
            tapRecognizer.cancelsTouchesInView = false
            view.addGestureRecognizer(tapRecognizer)
        
        title = "Create Post"
        
        newPostScreen.buttonTakePhoto.menu = getMenuImagePicker()
        newPostScreen.saveButton.addTarget(self, action: #selector(saveBtnTapped), for: .touchUpInside)
        
    }
    
    @objc func saveBtnTapped(){
        let postTitle = newPostScreen.titleTextField.text ?? ""
        let postContent = newPostScreen.contentTextView.text ?? ""
        //        let postImage = newPostScreen.imageView.image!
        var author = ""
        var tags: [String] = []
        
        if postTitle.isEmpty || postContent.isEmpty {
            showAlert(message: "Title or content cannot be empty.")
            return
        }
        
        // Get tags and author name from current user
        AuthModel().getCurrentUserDetails { (userDetails, error) in
            if let error = error {
                // Handle error
                print("Error fetching user details: \(error.localizedDescription)")
            } else {
                if let error = error {
                    // Handle error
                    print("Error fetching user details: \(error.localizedDescription)")
                } else {
                    if let name = userDetails["name"] as? String {
                        author = name
                    } else {
                        author = ""
                    }
                    
                    if let experts = userDetails["tags"] as? [String] {
                        tags = experts
                    } else {
                        tags = []
                    }
                }
                
                if let image = self.pickedImage {
                    // Convert the image to JPEG data
                    guard let imageData = image.jpegData(compressionQuality: 0.5) else {
                        print("Failed to convert image to data.")
                        return
                    }
                    
                    let storageRef = Storage.storage().reference().child("userImages/\(UUID().uuidString).jpg") // Create a unique filename
                    
                    // Upload image data to Firebase Storage
                    storageRef.putData(imageData, metadata: nil) { (metadata, error) in
                        guard let metadata = metadata else {
                            // Uh-oh, an error occurred!
                            print("Error uploading image: \(error?.localizedDescription ?? "Unknown error")")
                            return
                        }
                        
                        // You can access the download URL for the image from the metadata
                        storageRef.downloadURL { (url, error) in
                            guard let downloadURL = url else {
                                // Uh-oh, an error occurred!
                                print("Error getting download URL: \(error?.localizedDescription ?? "Unknown error")")
                                return
                            }
                            
                            let imageUrlString = downloadURL.absoluteString
                            
                            let newPost = Authpost(title: postTitle, content: postContent, timestamp: Date.now, image: imageUrlString, tags: tags, author: author)
                    
                            // Create a new post
                            let db = Firestore.firestore()
                            let postData: [String: Any] = [
                                "title": newPost.title,
                                "content": newPost.content,
                                "timestamp": newPost.timestamp,
                                "image": newPost.image,
                                "tags": newPost.tags,
                                "author": newPost.author
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
                        }
                    }
                    
                    self.navigationController?.popViewController(animated: true)
                }
//                if let image = self.pickedImage {
//                    // Convert the image to JPEG data
//                    guard let imageData = image.jpegData(compressionQuality: 0.5) else {
//                        print("Failed to convert image to data.")
//                        return
//                    }
//                    
//                    let storageRef = Storage.storage().reference().child("userImages/\(UUID().uuidString).jpg") // Create a unique filename
//                    // Upload image data to Firebase Storage
//                    
//                    
//                    let newPost = Authpost(title: postTitle, content: postContent, timestamp: Date.now, image: "", tags: tags, author: author)
//    
//                    // Create a new post
//                    let db = Firestore.firestore()
//                    let postData: [String: Any] = [
//                        "title": newPost.title,
//                        "content": newPost.content,
//                        "timestamp": newPost.timestamp,
//                        "image": newPost.image,
//                        "tags": newPost.tags,
//                        "author": newPost.author
//                    ]
//    
//                    db.collection("posts").addDocument(data: postData) { error in
//                        if let error = error {
//                            // Handle error while adding document
//                            print("Error adding document: \(error)")
//                        } else {
//                            // Post added successfully
//                            print("Document added successfully")
//                        }
//                    }
//    
//                    self.navigationController?.popViewController(animated: true)
//                }
            }
        }
    }
    
    private func showAlert(message: String) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    func getMenuImagePicker() -> UIMenu{
           var menuItems = [
               UIAction(title: "Camera",handler: {(_) in
                   self.pickUsingCamera()
               }),
               UIAction(title: "Gallery",handler: {(_) in
                   self.pickPhotoFromGallery()
               })
           ]
           
           return UIMenu(title: "Select source", children: menuItems)
    }
    
    func pickUsingCamera(){
        let cameraController = UIImagePickerController()
        cameraController.sourceType = .camera
        cameraController.allowsEditing = true
        cameraController.delegate = self
        present(cameraController, animated: true)
    }
        
    
    func pickPhotoFromGallery(){
        var configuration = PHPickerConfiguration()
        configuration.filter = PHPickerFilter.any(of: [.images])
        configuration.selectionLimit = 1
                
        let photoPicker = PHPickerViewController(configuration: configuration)
                
        photoPicker.delegate = self
        present(photoPicker, animated: true, completion: nil)
    }
    
    
    @objc func hideKeyboardOnTap(){
        //MARK: removing the keyboard from screen...
        view.endEditing(true)
    }

}

extension NewPostViewController:PHPickerViewControllerDelegate{
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        dismiss(animated: true)
        
        print(results)
        
        let itemprovider = results.map(\.itemProvider)
        
        for item in itemprovider{
            if item.canLoadObject(ofClass: UIImage.self){
                item.loadObject(ofClass: UIImage.self, completionHandler: { (image, error) in
                    DispatchQueue.main.async{
                        if let uwImage = image as? UIImage{
                            self.newPostScreen.buttonTakePhoto.setImage(
                                uwImage.withRenderingMode(.alwaysOriginal),
                                for: .normal
                            )
                            self.pickedImage = uwImage
                        }
                    }
                })
            }
        }
    }
}


extension NewPostViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)
        
        if let image = info[.editedImage] as? UIImage{
            self.newPostScreen.buttonTakePhoto.setImage(
                image.withRenderingMode(.alwaysOriginal),
                for: .normal
            )
            self.pickedImage = image
        }else{
            // Do your thing for No image loaded...
        }
    }
}
