//
//  RegisterViewController.swift
//  ContactAppA4
//
//  Created by Nitin Bhat on 3/17/24.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore


class RegisterViewController: UIViewController {

    let registerScreen = RegisterView()
    let authAPIController = AuthAPIController()
    let model = Model()
    
    override func loadView() {
       view = registerScreen
    }

    override func viewDidLoad() {

        super.viewDidLoad()
        
        title = "Register"
        
        registerScreen.registerBtn.addTarget(self, action: #selector(registerBtnTapped), for: .touchUpInside)
        
    }
    
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
        
        
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] authResult, error in
                guard let self = self else { return }
                if let error = error {
                    self.showAlert(message: "Registration failed. Please try again. \(error.localizedDescription)")
                    print("Registration failed with error: \(error.localizedDescription)")
                    return
                }
            
                self.model.createUser(name: name, email: email) { user, error in
                            if let error = error {
                                self.showAlert(message: "Failed to create user. \(error.localizedDescription)")
                                print("Failed to create user in Firestore: \(error.localizedDescription)")
                                return
                            }

                            if let user = user {
                                print("User created successfully: \(user)")
                                self.model.sendWelcomeMessageToAllUsers(senderId: email ,welcomeMessage: "Hey there I am to our app!") { error in
                                        if let error = error {
                                            print("Failed to send welcome message to all users: \(error.localizedDescription)")
                                                        // Handle the error accordingly, if needed
                                        } else {
                                            print("Welcome message sent to all users successfully.")
                                            // Proceed to the next view controller
                                            
                                        }
                                }
                                self.navigateToNotesViewController()
                            } else {
                                print("User creation failed.")
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
    
    private func navigateToNotesViewController() {
        print("calledd navigateToNotesViewController")
        let notesVC = ChatsViewController()
        navigationController?.pushViewController(notesVC, animated: true)
    }

}
