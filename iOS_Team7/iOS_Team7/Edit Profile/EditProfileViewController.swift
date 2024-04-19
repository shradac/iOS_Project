//
//  EditProfileViewController.swift
//  iOS_Team7
//
//  Created by Vasu Agarwal on 4/5/24.
//

import UIKit
import PhotosUI

class EditProfileViewController: UIViewController {
    var selectedType = "Expert"
    let editProfileScreen = EditProfileView()
    var pickedImage:UIImage?
    let profileInfo: Profile
    
    override func loadView() {
        view = editProfileScreen
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
        title = "Edit"
        
        if let unwrappedName = profileInfo.name,
           let unwrappedEmail = profileInfo.email,
           let unwrappedPhoneNum = profileInfo.phone,
           let unwrappedProfileImage = profileInfo.profileImage,
           let unwrappedPhoneType = profileInfo.phoneType,
           let unwrappedAddress1 = profileInfo.address1,
           let unwrappedAddress2 = profileInfo.address2,
           let unwrappedAddress3 = profileInfo.address3 {
            if !unwrappedName.isEmpty{
                editProfileScreen.textFieldName.text = "\(unwrappedName)"
            }
            if !unwrappedEmail.isEmpty{
                editProfileScreen.textFieldEmail.text = unwrappedEmail
            }
            if unwrappedPhoneNum > 0{
                editProfileScreen.textFieldPhoneNum.text = "\(unwrappedPhoneNum)"
            }
            if !unwrappedPhoneType.isEmpty{
                editProfileScreen.buttonSelectType.setTitle(unwrappedPhoneType, for: .normal)
            }
            
//            editProfileScreen.buttonTakePhoto.setImage(unwrappedProfileImage.withRenderingMode(.alwaysOriginal), for: .normal)
            
            if !unwrappedAddress1.isEmpty{
                editProfileScreen.textFieldAddress1.text = unwrappedAddress1
            }
            if !unwrappedAddress2.isEmpty{
                editProfileScreen.textFieldAddress2.text = unwrappedAddress2
            }
            if !unwrappedAddress3.isEmpty{
                editProfileScreen.textFieldAddress3.text = unwrappedAddress3
            }
        }
        
        //MARK: adding menu to buttonSelectType...
        editProfileScreen.buttonSelectType.menu = getMenuTypes()
        editProfileScreen.buttonTakePhoto.menu = getMenuImagePicker()
        editProfileScreen.buttonSave.addTarget(self, action: #selector(onSaveButtonTapped), for: .touchUpInside)
        
        //MARK: recognizing the taps on the app screen, not the keyboard...
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboardOnTap))
        tapRecognizer.cancelsTouchesInView = false
        view.addGestureRecognizer(tapRecognizer)
    }
    
    func getMenuTypes() -> UIMenu{
        var menuItems = [UIAction]()
        
        for type in Utilities.types{
            let menuItem = UIAction(title: type,handler: {(_) in
                                self.selectedType = type
                                self.editProfileScreen.buttonSelectType.setTitle(self.selectedType, for: .normal)
                            })
            menuItems.append(menuItem)
        }
        
        return UIMenu(title: "Select type", children: menuItems)
    }
    
    func getMenuImagePicker() -> UIMenu{
        let menuItems = [
            UIAction(title: "Camera",handler: {(_) in
                self.pickUsingCamera()
            }),
            UIAction(title: "Gallery",handler: {(_) in
                self.pickPhotoFromGallery()
            })
        ]
        
        return UIMenu(title: "Select source", children: menuItems)
    }
    
    //MARK: take Photo using Camera...
    func pickUsingCamera(){
        let cameraController = UIImagePickerController()
        cameraController.sourceType = .camera
        cameraController.allowsEditing = true
        cameraController.delegate = self
        present(cameraController, animated: true)
    }
    
    //MARK: pick Photo using Gallery...
    func pickPhotoFromGallery(){
        var configuration = PHPickerConfiguration()
        configuration.filter = PHPickerFilter.any(of: [.images])
        configuration.selectionLimit = 1
        
        let photoPicker = PHPickerViewController(configuration: configuration)
        
        photoPicker.delegate = self
        present(photoPicker, animated: true, completion: nil)
    }
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    func isValidZip(_ zip: String) -> Bool {
        if let unwrappedZip = Int(zip) {
            let isValidZip = (zip.count == 5) && unwrappedZip > 0 && unwrappedZip <= 99950
            return isValidZip
        } else {
            return false
        }
    }
    
    func isValidPhoneNumber(_ phoneNumber: String) -> Bool {
        let phoneRegex = #"^\d{3}\d{3}\d{4}$"#
        let phonePredicate = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
        return phonePredicate.evaluate(with: phoneNumber)
    }
    
    func showErrorAlert(_ msg: String){
        let alert = UIAlertController(
            title: "Error", message: msg,
            preferredStyle: .alert
        )
        
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert, animated: true)
    }
    
    @objc func hideKeyboardOnTap(){
        //MARK: removing the keyboard from screen...
        view.endEditing(true)
    }
    
    @objc func onSaveButtonTapped(){
        
        if let unwrappedName = editProfileScreen.textFieldName.text,
           let unwrappedEmail = editProfileScreen.textFieldEmail.text,
           let unwrappedPhoneNum = editProfileScreen.textFieldPhoneNum.text,
           let unwrappedAddress1 = editProfileScreen.textFieldAddress1.text,
           let unwrappedAddress2 = editProfileScreen.textFieldAddress2.text,
           let unwrappedAddress3 = editProfileScreen.textFieldAddress3.text
        {
            if unwrappedName.isEmpty{
                showErrorAlert("Name cannot be empty!")
                return
            }
            if unwrappedEmail.isEmpty{
                showErrorAlert("Email cannot be empty!")
                return
            }
            if !isValidEmail(unwrappedEmail){
                showErrorAlert("The email is of invalid format!")
                return
            }
            if unwrappedPhoneNum.isEmpty{
                showErrorAlert("Phone number cannot be empty!")
                return
            } else {
                if !isValidPhoneNumber(unwrappedPhoneNum) {
                    showErrorAlert("Invalid Phone Number!")
                    return
                }
            }
            if unwrappedAddress1.isEmpty{
                showErrorAlert("Street address cannot be empty!")
                return
            }
            if unwrappedAddress2.isEmpty{
                showErrorAlert("City/State cannot be empty!")
                return
            }
            if (unwrappedAddress3.isEmpty){
                showErrorAlert("ZIP cannot be empty!")
                return
            } else {
                if !isValidZip(unwrappedAddress3){
                    showErrorAlert("Invalid ZIP!")
                    return
                }
            }
            
            let newProfile = Profile(name: unwrappedName,
                                     email: unwrappedEmail,
                                     phoneType: selectedType,
//                                     profileImage: pickedImage ?? (UIImage(systemName: "person.fill"))!,
                                     profileImage: "",
                                     phone: Int(unwrappedPhoneNum),
                                     address1: unwrappedAddress1,
                                     address2: unwrappedAddress2,
                                     address3: unwrappedAddress3)
            
            // TODO: Performa action when save is clicked
            
            navigationController?.popViewController(animated: true)
        }
    }
}

//MARK: adopting required protocols for PHPicker...
extension EditProfileViewController:PHPickerViewControllerDelegate{
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        dismiss(animated: true)
        
        print(results)
        
        let itemprovider = results.map(\.itemProvider)
        
        for item in itemprovider{
            if item.canLoadObject(ofClass: UIImage.self){
                item.loadObject(ofClass: UIImage.self, completionHandler: { (image, error) in
                    DispatchQueue.main.async{
                        if let uwImage = image as? UIImage{
                            self.editProfileScreen.buttonTakePhoto.setImage(
                                uwImage.withRenderingMode(.alwaysOriginal),
                                for: .normal
                            )
                            self.pickedImage = uwImage
                        }
                    }
                })
            }
        }
    }
}

extension EditProfileViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)
        
        if let image = info[.editedImage] as? UIImage{
            self.editProfileScreen.buttonTakePhoto.setImage(
                image.withRenderingMode(.alwaysOriginal),
                for: .normal
            )
            self.pickedImage = image
        }else{
            // Do your thing for No image loaded...
        }
    }
}
