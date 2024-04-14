//
//  HOCTabs.swift
//  iOS_Team7
//
//  Created by Nitin Bhat on 4/14/24.
//

import UIKit

class HOCTabs: UITabBarController {

    override func viewDidLoad() {
            super.viewDidLoad()
        
            self.navigationItem.title = ""
        
            navigationItem.hidesBackButton = true
        
        
            
            // Create LoggedInHomeViewController
            let feedVC = FeedViewController()
            let feedNavVC = UINavigationController(rootViewController: feedVC)
            feedNavVC.tabBarItem = UITabBarItem(title: "Feed", image: UIImage(systemName: "newspaper"), tag: 0)
        
            let exploreVC = ExploreViewController()
            let exploreNavVC = UINavigationController(rootViewController: exploreVC)
            exploreNavVC.tabBarItem = UITabBarItem(title: "Explore", image: UIImage(systemName: "magnifyingglass"), tag: 0)
        
           
            //TODO: hit the api to fetch the currently logged in user data
            let profile = Profile(
                name: "John Doe",
                email: "john.doe@example.com",
                phoneType: "Mobile",
                profileImage: UIImage(named: "profile_pic"),
                phone: 1234567890,
                address1: "123 Main Street",
                address2: "Apt 101",
                address3: "City, Country"
            )
        
           let role = "user"

            let profileVC = ShowProfileViewController(profileInfo: profile)
            let profileNavVC = UINavigationController(rootViewController: profileVC)
            profileNavVC.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person"), tag: 0)
            
            
            if(role == "expert"){
                self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add Post", style: .plain, target: self, action: #selector(AddTapped))
                
            }
            
            // Set view controllers
            viewControllers = [profileNavVC , exploreNavVC , feedNavVC]
        }
    
    @objc func AddTapped(){
        print("navigate to add note")
    }
    
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
            // Prevent the title from switching to "Welcome" when a tab is selected
            if let selectedViewController = selectedViewController {
                selectedViewController.navigationItem.title = item.title
            }
    }

}
