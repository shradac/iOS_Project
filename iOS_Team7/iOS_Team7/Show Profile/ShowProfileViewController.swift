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
    var receivedPackage: ViewController.Package = ViewController.Package()
    
    //MARK: patch the view of the controller to the DisplayView...
    override func loadView() {
        view = showProfileScreen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .edit, target: self,
            action: #selector(onEditBarButtonTapped)
        )

        if let unwrappedName = receivedPackage.contactName,
           let unwrappedEmail = receivedPackage.contactEmail,
           let unwrappedPhoneNum = receivedPackage.contactPhoneNum,
           let unwrappedContactImage = receivedPackage.contactImage,
           let unwrappedPhoneType = receivedPackage.contactPhoneType,
           let unwrappedAddress1 = receivedPackage.contactAddress1,
           let unwrappedAddress2 = receivedPackage.contactAddress2,
           let unwrappedAddress3 = receivedPackage.contactZip {
            if !unwrappedName.isEmpty{
                showProfileScreen.labelName.text = "\(unwrappedName)"
            }
            if !unwrappedEmail.isEmpty{
                showProfileScreen.labelEmail.text = "Email: " + unwrappedEmail
            }
            if !unwrappedPhoneNum.isEmpty{
                showProfileScreen.labelPhoneNum.text = "Phone: " + unwrappedPhoneNum + " (\(unwrappedPhoneType))"
            }
            if (unwrappedContactImage != nil) {
                showProfileScreen.imageContact.image = unwrappedContactImage
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
    
    func delegateOnEditContact(contact: Contact){
        if let unwrappedName = contact.name,
           let unwrappedEmail = contact.email,
           let unwrappedPhoneNum = contact.phone,
           let unwrappedContactImage = contact.contactImage,
           let unwrappedPhoneType = contact.phoneType,
           let unwrappedAddress1 = contact.address1,
           let unwrappedAddress2 = contact.address2,
           let unwrappedAddress3 = contact.address3 {
            if !unwrappedName.isEmpty{
                showProfileScreen.labelName.text = "\(unwrappedName)"
            }
            if !unwrappedEmail.isEmpty{
                showProfileScreen.labelEmail.text = "Email: " + unwrappedEmail
            }
            
            showProfileScreen.labelPhoneNum.text = "Phone: " + "\(unwrappedPhoneNum)" + " (\(unwrappedPhoneType))"
            
            if (unwrappedContactImage != nil) {
                showProfileScreen.imageContact.image = unwrappedContactImage
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
        
        delegate.delegateOnEditContact(contact: contact, indexToUpdate: receivedPackage.contactArrayIndex)
    }
    
    @objc func onEditBarButtonTapped(){
        let editContactController = EditContactViewController()
        editContactController.receivedPackage = self.receivedPackage
        editContactController.delegate = self
        navigationController?.pushViewController(editContactController, animated: true)
    }
}
