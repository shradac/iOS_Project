//
//  HOCTabs.swift
//  iOS_Team7
//
//  Created by Nitin Bhat on 4/14/24.
//

import UIKit
import FirebaseAuth
import FirebaseFirestoreInternal

class HOCTabs: UITabBarController {

//    var profile: Profile = Profile()
    override func viewDidLoad() {
            super.viewDidLoad()
        
            self.navigationItem.title = ""
        
            navigationItem.hidesBackButton = true
        
            NotificationCenter.default.addObserver(self, selector: #selector(logoutCompleted), name: NSNotification.Name("logoutCompleted"), object: nil)
            
            // Create LoggedInHomeViewController
            let feedVC = FeedViewController()
            let feedNavVC = UINavigationController(rootViewController: feedVC)
            feedNavVC.tabBarItem = UITabBarItem(title: "Feed", image: UIImage(systemName: "newspaper"), tag: 0)
        
            let exploreVC = ExploreViewController()
            let exploreNavVC = UINavigationController(rootViewController: exploreVC)
            exploreNavVC.tabBarItem = UITabBarItem(title: "Explore", image: UIImage(systemName: "magnifyingglass"), tag: 0)
        
           
            //TODO: hit the api to fetch the currently logged in user data
//            let profile = Profile(
//                name: "John Doe",
//                email: "john.doe@example.com",
//                phoneType: "Mobile",
//                profileImage: UIImage(named: "profile_pic"),
//                phone: 1234567890,
//                address1: "123 Main Street",
//                address2: "Apt 101",
//                address3: "City, Country"
//            )
        
        var role = "user"
        getCurrentUserDetails { (userDetails, error) in
            if let error = error {
                // Handle error
                print("Error fetching user details: \(error.localizedDescription)")
            } else {
                let experts: [String]
                if let tags = userDetails["tags"] as? [String] {
                    experts = tags
                } else {
                    experts = []
                }
                
                if let error = error {
                    // Handle error
                    print("Error fetching user details: \(error.localizedDescription)")
                } else {
                    if let roleName = userDetails["role"] as? String {
                        role = roleName
                    } else {
                        role = "user"
                    }
                    // Assign user details to variables
                    var userProfile = Profile(
                        name: userDetails["name"] as? String,
                        email: userDetails["name"] as? String,
                        experts: experts,
                        phoneType: "",
                        profileImage: UIImage(named: "profile_pic"),
                        phone: 1234567890,
                        address1: "",
                        address2: "",
                        address3: ""
                    )
                    
//                    self.profile = userProfile
                    
                    let profileVC = ShowProfileViewController(profileInfo: userProfile)
                    let profileNavVC = UINavigationController(rootViewController: profileVC)
                    profileNavVC.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person"), tag: 0)
                    
                    if(role == "expert"){
                        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add Post", style: .plain, target: self, action: #selector(self.AddTapped))
                        
                    }
                    
                    // Set view controllers
                    self.viewControllers = [profileNavVC , exploreNavVC , feedNavVC]
                }
            }
        }
        
//        let profileVC = ShowProfileViewController(profileInfo: self.profile)
//        let profileNavVC = UINavigationController(rootViewController: profileVC)
//        profileNavVC.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person"), tag: 0)
//        
//        if(role == "expert"){
//            self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add Post", style: .plain, target: self, action: #selector(self.AddTapped))
//            
//        }
//        
//        // Set view controllers
//        self.viewControllers = [profileNavVC , exploreNavVC , feedNavVC]
            
        }
    
    @objc func AddTapped(){
        let newPostVC = NewPostViewController()
        navigationController?.pushViewController(newPostVC, animated: true)
    }
    
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
            // Prevent the title from switching to "Welcome" when a tab is selected
            if let selectedViewController = selectedViewController {
                selectedViewController.navigationItem.title = item.title
            }
    }
    
    @objc func logoutCompleted() {
        // Dismiss the UITabBarController
        self.dismiss(animated: true, completion: nil)
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
                        
                        // Create a User object with fetched details
                        let user: [String: Any] = [
                            "name": name,
                            "email": email,
                            "role": role,
                            "follows" : follows,
                            "tags" : tags
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


    
//    func getCurrentUserDetails(completion: @escaping ([String: Any], Error?) -> Void) {
//            if let currentUser = Auth.auth().currentUser {
//                // Fetch basic user details from Firebase Authentication
//                let name = currentUser.displayName ?? ""
//                let email = currentUser.email ?? ""
//                let uid = currentUser.uid
//                
//                // Query Firestore to fetch additional user details including role
//                let db = Firestore.firestore()
//                let userRef = db.collection("users").document(uid)
//                
//                userRef.getDocument { (document, error) in
//                    if let document = document, document.exists {
//                        // Document found, extract user details including role
//                        let userData = document.data()
//                        let role = userData?["role"] as? String ?? ""
//                        let name = userData?["name"] as? String ?? ""
//                        let email = userData?["email"] as? String ?? ""
//                        let follows = userData?["follows"] as? [String] ?? []
//                        let tags = userData?["name"] as? [String] ?? []
//                        
//                        // Create a User object with fetched details
//                        var user: [String: Any] = [
//                            "name": name,
//                            "email": email,
//                            "role": role,
//                            "follows" : [],
//                            "tags" : tags
//                        ]
//                        completion(user, nil)
//                    } else {
//                        // Document not found or error occurred
//                        let error = error ?? NSError(domain: "User document not found", code: 0, userInfo: nil)
//                        completion([:], error)
//                    }
//                }
//            } else {
//                // No user logged in
//                let error = NSError(domain: "User not logged in", code: 0, userInfo: nil)
//                completion([:], error)
//            }
//        }

}
