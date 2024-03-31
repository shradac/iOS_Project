//
//  ViewController.swift
//  ContactAppA4
//
//  Created by Nitin Bhat on 3/17/24.
//

import UIKit
import FirebaseAuth

class ViewController: UIViewController {
    
    let loginScreen = LoginView()
    
    var handleAuth: AuthStateDidChangeListenerHandle?
    var currentUser:FirebaseAuth.User?
    
    let authAPIController = AuthAPIController()
    
    override func loadView() {
       view = loginScreen
    }

    override func viewDidLoad() {

        super.viewDidLoad()
        
        title = "Login"
        
        loginScreen.registerBtn.addTarget(self, action: #selector(registerBtnTapped), for: .touchUpInside)
        loginScreen.loginBtn.addTarget(self, action: #selector(loginBtnTapped), for: .touchUpInside)
        
        if Auth.auth().currentUser != nil {
                navigateToNotesViewController()
        }
        
        
    }
    
    @objc func registerBtnTapped(){
        let registerController = RegisterViewController()
        navigationController?.pushViewController(registerController, animated: true)
    }
    
    @objc func loginBtnTapped(){
        let email = loginScreen.emailField.text?.lowercased() ?? ""
        let password = loginScreen.passwordField.text ?? ""
            
        if !isValidEmail(email) {
            self.showAlert(message: "Invalid Email")
            return
        }
        
        if email.isEmpty || password.isEmpty {
            showAlert(message: "Please enter both email and password.")
            return
        }
        
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
                guard let self = self else { return }
                if let error = error {
                    self.showAlert(message: "Login failed. Please try again. Issue maybe invalid username or password.")
                    print("Login failed with error: \(error.localizedDescription)")
                    return
                }
                // Authentication successful
                self.navigateToNotesViewController()
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
        let notesVC = ChatsViewController()
        navigationController?.pushViewController(notesVC, animated: true)
    }
    
    
}
