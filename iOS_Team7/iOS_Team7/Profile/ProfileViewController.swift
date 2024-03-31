//
//  ProfileViewController.swift
//  ContactAppA4
//
//  Created by Nitin Bhat on 3/17/24.
//

import UIKit
import FirebaseAuth

class ProfileViewController: UIViewController {

    let profileScreen = ProfileView()
    let authAPIController = AuthAPIController()
    private let userInfo: User
    
    init(userInfo: User) {
       self.userInfo = userInfo
       super.init(nibName: nil, bundle: nil)
    }
       
   required init?(coder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
   }

    
    override func loadView() {
       view = profileScreen
    }

    override func viewDidLoad() {

        super.viewDidLoad()
        
        title = "Profile"
        if let email = userInfo.email{
            profileScreen.emailField.text = "Email: \(email)"
        }
        
        profileScreen.logoutBtn.addTarget(self, action: #selector(logoutBtnTapped), for: .touchUpInside)
    }
    
    
    @objc func logoutBtnTapped(){
        do {
            try Auth.auth().signOut()
            print("Logout successful")
            navigationController?.popToRootViewController(animated: true)
        } catch {
            print("Logout failed with error: \(error.localizedDescription)")
            showAlert(message: "Logout failed with error: \(error.localizedDescription)")
        }
    }
    
    private func showAlert(message: String) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
}
