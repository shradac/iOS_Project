//
//  LoginViewController.swift
//  iOS_Team7
//
//  Created by Nitin Bhat on 4/4/24.
//

import UIKit
import FirebaseAuth


class LoginViewController:  UIViewController {
    
    let loginScreen = LoginView()
    
    var handleAuth: AuthStateDidChangeListenerHandle?
    var currentUser:FirebaseAuth.User?
    
    
    override func loadView() {
       view = loginScreen
    }

    override func viewDidLoad() {

        super.viewDidLoad()
        
        title = "Login"
        
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboardOnTap))
            tapRecognizer.cancelsTouchesInView = false
            view.addGestureRecognizer(tapRecognizer)
        
        loginScreen.loginBtn.addTarget(self, action: #selector(loginBtnTapped), for: .touchUpInside)
        
        if Auth.auth().currentUser != nil {
            //navigateToLandingViewController()
            navigateToTabsViewController()
        }
        
        
    }
    
    @objc func hideKeyboardOnTap(){
        //MARK: removing the keyboard from screen...
        view.endEditing(true)
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
                //self.navigateToLandingViewController()
            self.navigateToTabsViewController()
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
    
//    private func navigateToLandingViewController() {
//        print("navigate")
//        let loggedinHomeView = LoggedInHomeViewController()
//        navigationController?.pushViewController(loggedinHomeView, animated: true)
//    }
    
    private func navigateToTabsViewController() {
            let tabsViewController = HOCTabs()
            navigationController?.pushViewController(tabsViewController, animated: true)
    }
    
    
}
