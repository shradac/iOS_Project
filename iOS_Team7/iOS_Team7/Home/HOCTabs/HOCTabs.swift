//
//  HOCTabs.swift
//  iOS_Team7
//
//  Created by Nitin Bhat on 4/14/24.
//

import UIKit
import FirebaseAuth
import FirebaseFirestoreInternal

class HOCTabs: UITabBarController, UITabBarControllerDelegate {

//    var profile: Profile = Profile()
    var imageProfile: UIImageView!
    
    override func viewDidLoad() {
            super.viewDidLoad()
            self.delegate = self
        
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
                    self.viewControllers = [feedNavVC, exploreNavVC, profileNavVC]
                }
            }
            
            self.customizeTabBarItems()
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
    
    private func customizeTabBarItems() {
            // Change the color of tab bar item images
            if let items = tabBar.items {
                for item in items {
                    if let image = item.image {
                        item.image = image.withRenderingMode(.alwaysOriginal)
                        item.selectedImage = image.withRenderingMode(.alwaysOriginal)
                        item.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.red], for: .selected) // Change the selected color
                    }
                }
            }
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

extension HOCTabs {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        if let index = tabBarController.viewControllers?.firstIndex(of: viewController), index == 0 {
            // If the selected view controller is the first one (FeedViewController)
            if let feedNavVC = viewController as? UINavigationController,
               let feedVC = feedNavVC.viewControllers.first as? FeedViewController {
                // Reload table data in the FeedViewController
                feedVC.reloadTableData()
            }
        }
        
        if let index = tabBarController.viewControllers?.firstIndex(of: viewController), index == 1 {
            // If the selected view controller is the first one (FeedViewController)
            if let exploreNavVC = viewController as? UINavigationController,
               let exploreNavVC = exploreNavVC.viewControllers.first as? ExploreViewController {
                // Reload table data in the ExploreViewController
                exploreNavVC.reloadTableData()
            }
        }
    }
}
