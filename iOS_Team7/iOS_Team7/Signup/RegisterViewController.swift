//
//  RegisterViewController.swift
//  iOS_Team7
//
//  Created by Nitin Bhat on 4/4/24.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore
import PhotosUI
import Foundation
 
class RegisterViewController: UIViewController {
 
    let registerScreen = RegisterView()
    let model = AuthModel()
    
    let roleTypes: [String] = ["expert", "user"]
    var expertiseTags: [String] = []
    //var selectedRoleType:String? = "expert"
    var selectedRoleType: String? {
        didSet {
            guard let selectedRole = selectedRoleType else { return }
            
            // Update the visibility of tag-related components based on the selected role type
            if selectedRole == "expert" {
                registerScreen.showExpertiseTagComponents(true)
            } else {
                registerScreen.showExpertiseTagComponents(false)
            }
        }
    }
    
    var pickedImage:UIImage?
    
    override func loadView() {
       view = registerScreen
    }
 
    override func viewDidLoad() {
 
        super.viewDidLoad()
        
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboardOnTap))
            tapRecognizer.cancelsTouchesInView = false
            view.addGestureRecognizer(tapRecognizer)
        
        title = "Register"
        
        registerScreen.registerBtn.addTarget(self, action: #selector(registerBtnTapped), for: .touchUpInside)
        registerScreen.addExpertiseButton.addTarget(self, action: #selector(addExpertiseButtonTapped), for: .touchUpInside)
        //registerScreen.buttonSelectRoleType.addTarget(self, action: #selector(roleTypeSelected(_:)), for: .touchUpInside)
        
        registerScreen.buttonSelectRoleType.menu = getMenuTypes()
        registerScreen.buttonTakePhoto.menu = getMenuImagePicker()
        
    }
    
    
    @objc func addExpertiseButtonTapped() {
        guard let expertise = registerScreen.expertiseField.text, !expertise.isEmpty else {
                // Show alert or handle empty expertise field
                return
        }

        expertiseTags.append(expertise)
        registerScreen.expertiseTagsView.addTag(expertise)

        // Clear the expertise field
        registerScreen.expertiseField.text = nil
    }
    
    func getMenuTypes() -> UIMenu{
            var menuItems = [UIAction]()
            
            for type in roleTypes{
                let menuItem = UIAction(title: type,handler: {(_) in
                                    self.selectedRoleType = type
                                    self.registerScreen.buttonSelectRoleType.setTitle(self.selectedRoleType, for: .normal)
                                })
                menuItems.append(menuItem)
            }
            
            return UIMenu(title: "Select type", children: menuItems)
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
    
//    @objc func roleTypeSelected(_ sender: UIButton) {
//        guard let selectedRole = selectedRoleType else {
//                return
//        }
//        
//        // Update the visibility of tag-related components based on the selected role type
//        if selectedRole == "expert" {
//            registerScreen.showExpertiseTagComponents(true)
//        } else {
//            registerScreen.showExpertiseTagComponents(false)
//        }
//    }
    
    @objc func registerBtnTapped(){
        let name = registerScreen.nameField.text ?? ""
        let email  = registerScreen.emailField.text?.lowercased() ?? ""
        let password = registerScreen.passwordField.text ?? ""
        let confirmPassord = registerScreen.confirmPasswordField.text ?? ""

        
        if !isValidEmail(email) {
            self.showAlert(message: "Invalid Email")
            return
        }
        
        if name.isEmpty || email.isEmpty || password.isEmpty || confirmPassord.isEmpty {
            showAlert(message: "Please enter all name , email and password.")
            return
        }
        
        if password != confirmPassord{
            showAlert(message: "Passwords do not match")
            return
        }
        
        guard let selectedRole = selectedRoleType else {
                showAlert(message: "Please select a role.")
                return
        }
        
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] authResult, error in
            guard let self = self else { return }
            if let error = error {
                self.showAlert(message: "Registration failed. Please try again. \(error.localizedDescription)")
                print("Registration failed with error: \(error.localizedDescription)")
                return
            }
            
            // Check if an image is picked
            if let image = self.pickedImage {
                // Convert the image to JPEG data
                guard let imageData = image.jpegData(compressionQuality: 0.5) else {
                    self.showAlert(message: "Failed to convert image to data.")
                    return
                }
                
                // Pass the image data to createUser function
                self.model.createUser(name: name, email: email, imageData: imageData , role: selectedRole , tags: expertiseTags) { user, error in
                    if let error = error {
                        self.showAlert(message: "Failed to create user. \(error.localizedDescription)")
                        print("Failed to create user in Firestore: \(error.localizedDescription)")
                        return
                    }
                    
                    if let user = user {
                        print("User created successfully: \(user)")
                        do {
                            try Auth.auth().signOut()
                            print("Logout successful")
                            self.navigateToLoginViewController()
                        } catch {
                            print("Logout failed with error: \(error.localizedDescription)")
                        }
                        
                    } else {
                        print("User creation failed.")
                    }
                }
            } else {
                // If no image is picked, register user without image data
                self.model.createUser(name: name, email: email, imageData: nil , role: selectedRole, tags: expertiseTags) { user, error in
                    if let error = error {
                        self.showAlert(message: "Failed to create user. \(error.localizedDescription)")
                        print("Failed to create user in Firestore: \(error.localizedDescription)")
                        return
                    }
                    
                    if let user = user {
                        print("User created successfully: \(user)")
                        do {
                            try Auth.auth().signOut()
                            print("Logout successful")
                            self.navigateToLoginViewController()
                        } catch {
                            print("Logout failed with error: \(error.localizedDescription)")
                        }
                        
                    } else {
                        print("User creation failed.")
                    }
                }
            }
        }
    }

    
    func isValidEmail(_ email: String) -> Bool {
            // Improved email validation using regular expression
            let emailRegex = #"^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Z|a-z]{2,}$"#
            return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: email)
    }
    
    
    private func showAlert(message: String) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    
    private func navigateToLoginViewController() {
        let loginVC = LoginViewController()
        navigationController?.pushViewController(loginVC, animated: true)
    }
 
}


extension RegisterViewController:PHPickerViewControllerDelegate{
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        dismiss(animated: true)
        
        print(results)
        
        let itemprovider = results.map(\.itemProvider)
        
        for item in itemprovider{
            if item.canLoadObject(ofClass: UIImage.self){
                item.loadObject(ofClass: UIImage.self, completionHandler: { (image, error) in
                    DispatchQueue.main.async{
                        if let uwImage = image as? UIImage{
                            self.registerScreen.buttonTakePhoto.setImage(
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


extension RegisterViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)
        
        if let image = info[.editedImage] as? UIImage{
            self.registerScreen.buttonTakePhoto.setImage(
                image.withRenderingMode(.alwaysOriginal),
                for: .normal
            )
            self.pickedImage = image
        }else{
            // Do your thing for No image loaded...
        }
    }
}
