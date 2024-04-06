//
//  ShowProfileViewController.swift
//  iOS_Team7
//
//  Created by Vasu Agarwal on 4/5/24.
//

import UIKit

class ShowProfileViewController: UIViewController {

    var delegate: ViewController!
    let showProfileScreen = ShowProfileView()
    let profileInfo: Profile
    
    //MARK: patch the view of the controller to the DisplayView...
    override func loadView() {
        view = showProfileScreen
    }
    
    init(profileInfo: Profile) {
       self.profileInfo = profileInfo
       super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
   }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .edit, target: self,
            action: #selector(onEditBarButtonTapped)
        )

        if let unwrappedName = profileInfo.name,
           let unwrappedEmail = profileInfo.email,
           let unwrappedPhoneNum = profileInfo.phone,
           let unwrappedProfileImage = profileInfo.profileImage,
           let unwrappedPhoneType = profileInfo.phoneType,
           let unwrappedAddress1 = profileInfo.address1,
           let unwrappedAddress2 = profileInfo.address2,
           let unwrappedAddress3 = profileInfo.address3 {
            if !unwrappedName.isEmpty{
                showProfileScreen.labelName.text = "\(unwrappedName)"
            }
            if !unwrappedEmail.isEmpty{
                showProfileScreen.labelEmail.text = "Email: " + unwrappedEmail
            }
            if unwrappedPhoneNum > 0{
                showProfileScreen.labelPhoneNum.text = "Phone: " + "\(unwrappedPhoneNum)" + unwrappedPhoneType
            }
            if (unwrappedProfileImage != nil) {
                showProfileScreen.imageProfile.image = unwrappedProfileImage
            }
            showProfileScreen.labelAddressHeading.text = "Address:"
            if !unwrappedAddress1.isEmpty{
                showProfileScreen.labelAddress1.text = unwrappedAddress1
            }
            if !unwrappedAddress2.isEmpty{
                showProfileScreen.labelAddress2.text = unwrappedAddress2
            }
            if !unwrappedAddress3.isEmpty{
                showProfileScreen.labelZip.text = unwrappedAddress3
            }
        }
    }
    
    func onEditProfile(profile: Profile){
        if let unwrappedName = profile.name,
           let unwrappedEmail = profile.email,
           let unwrappedPhoneNum = profile.phone,
           let unwrappedProfileImage = profile.profileImage,
           let unwrappedPhoneType = profile.phoneType,
           let unwrappedAddress1 = profile.address1,
           let unwrappedAddress2 = profile.address2,
           let unwrappedAddress3 = profile.address3 {
            if !unwrappedName.isEmpty{
                showProfileScreen.labelName.text = "\(unwrappedName)"
            }
            if !unwrappedEmail.isEmpty{
                showProfileScreen.labelEmail.text = "Email: " + unwrappedEmail
            }
            
            showProfileScreen.labelPhoneNum.text = "Phone: " + "\(unwrappedPhoneNum)" + " (\(unwrappedPhoneType))"
            
            if (unwrappedProfileImage != nil) {
                showProfileScreen.imageProfile.image = unwrappedProfileImage
            }
            showProfileScreen.labelAddressHeading.text = "Address:"
            if !unwrappedAddress1.isEmpty{
                showProfileScreen.labelAddress1.text = unwrappedAddress1
            }
            if !unwrappedAddress2.isEmpty{
                showProfileScreen.labelAddress2.text = unwrappedAddress2
            }
            if !unwrappedAddress3.isEmpty{
                showProfileScreen.labelZip.text = unwrappedAddress3
            }
        }
        
        // TODO: Save the changed profile fields
        
    }
    
    @objc func onEditBarButtonTapped(){
        let editProfileController = EditProfileViewController(profileInfo: profileInfo)
        navigationController?.pushViewController(editProfileController, animated: true)
    }
}
