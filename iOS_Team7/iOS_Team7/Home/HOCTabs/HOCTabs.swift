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
    var imageProfile: UIImageView!
    
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
        
        var role = "user"
        var profileImg = ""
        AuthModel().getCurrentUserDetails { (userDetails, error) in
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
                    if let img = userDetails["profileImageURL"] as? String {
                        profileImg = img
                    } else {
                        profileImg = ""
                    }
                    
                    if let roleName = userDetails["role"] as? String {
                        role = roleName
                    } else {
                        role = "user"
                    }
                    
                    
                    // Assign user details to variables
                    var userProfile = Profile(
                        name: userDetails["name"] as? String,
                        email: userDetails["email"] as? String,
                        experts: experts,
                        phoneType: "",
                        profileImage: profileImg,
                        phone: 1234567890,
                        role: role,
                        tags: experts,
                        address1: "",
                        address2: "",
                        address3: ""
                    )
                    
//                    self.profile = userProfile
                    
                    let profileVC = ShowProfileViewController(profileInfo: userProfile)
                    let profileNavVC = UINavigationController(rootViewController: profileVC)
                    profileNavVC.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person"), tag: 0)
                    
                    if(role == "expert"){
                        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Create Post", style: .plain, target: self, action: #selector(self.AddTapped))
                        
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
        navigationController?.popToRootViewController(animated: true)
    }

}
