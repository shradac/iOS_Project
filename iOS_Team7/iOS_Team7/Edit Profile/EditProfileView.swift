//
//  EditProfileView.swift
//  iOS_Team7
//
//  Created by Vasu Agarwal on 4/5/24.
//

import UIKit

class EditProfileView: UIView {

    var textFieldName: UITextField!
    var textFieldEmail: UITextField!
    var textFieldPhoneNum: UITextField!
    var textFieldAddress1: UITextField!
    var textFieldAddress2: UITextField!
    var textFieldAddress3: UITextField!
    var pickerType: UIPickerView!
    var buttonSelectType: UIButton!
    var buttonTakePhoto: UIButton!
    var buttonSave: UIButton!
    
//    var labelCreateProfile: UILabel!
    var labelPhoneType: UILabel!

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        
//        setupLabelCreateProfile()
        setupTextFieldName()
        setupTextFieldEmail()
//        setupLabelPhoneType()
        setupbuttonSelectType()
        setupbuttonTakePhoto()
        setupTextFieldPhoneNum()
        setupTextFieldAddress1()
        setupTextFieldAddress2()
        setupTextFieldAddress3()
        setupbuttonSave()
//        setuppickerType()
//        setupbuttonAdd()
        
        initConstraints()
    }
    
//    func setupLabelCreateProfile(){
//        labelCreateProfile = UILabel()
//        labelCreateProfile.textColor = .black
//        labelCreateProfile.text = "Add a New Contact"
//        labelCreateProfile.font = labelCreateProfile.font.withSize(28)
//        labelCreateProfile.translatesAutoresizingMaskIntoConstraints = false
//        self.addSubview(labelCreateProfile)
//    }
    func setupbuttonSave(){
        buttonSave = UIButton(type: .system)
        buttonSave.setTitle("Save", for: .normal)
        buttonSave.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(buttonSave)
    }
    
    func setupLabelPhoneType(){
        labelPhoneType = UILabel()
        labelPhoneType.textColor = .black
        labelPhoneType.text = "Add Phone"
        labelPhoneType.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(labelPhoneType)
    }
    
    func setupTextFieldName(){
        textFieldName = UITextField()
        textFieldName.placeholder = "Name"
        textFieldName.borderStyle = .roundedRect
        textFieldName.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(textFieldName)
    }
    
    func setupTextFieldEmail(){
        textFieldEmail = UITextField()
        textFieldEmail.placeholder = "Email"
        textFieldEmail.borderStyle = .roundedRect
        textFieldEmail.keyboardType = UIKeyboardType.emailAddress
        textFieldEmail.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(textFieldEmail)
    }
    
    func setupTextFieldPhoneNum(){
        textFieldPhoneNum = UITextField()
        textFieldPhoneNum.placeholder = "Phone number"
        textFieldPhoneNum.borderStyle = .roundedRect
        textFieldPhoneNum.keyboardType = UIKeyboardType.phonePad
        textFieldPhoneNum.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(textFieldPhoneNum)
    }
    
    func setupTextFieldAddress1(){
        textFieldAddress1 = UITextField()
        textFieldAddress1.placeholder = "Address"
        textFieldAddress1.borderStyle = .roundedRect
        textFieldAddress1.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(textFieldAddress1)
    }
    
    func setupTextFieldAddress2(){
        textFieldAddress2 = UITextField()
        textFieldAddress2.placeholder = "City, State"
        textFieldAddress2.borderStyle = .roundedRect
        textFieldAddress2.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(textFieldAddress2)
    }
    
    func setupTextFieldAddress3(){
        textFieldAddress3 = UITextField()
        textFieldAddress3.placeholder = "ZIP"
        textFieldAddress3.borderStyle = .roundedRect
        textFieldAddress3.keyboardType = UIKeyboardType.numberPad
        textFieldAddress3.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(textFieldAddress3)
    }
    
    func setupbuttonSelectType(){
        buttonSelectType = UIButton(type: .system)
        buttonSelectType.setTitle(Utilities.types[0], for: .normal)
        //MARK: the on-tap primary action will pop up the menu...
        buttonSelectType.showsMenuAsPrimaryAction = true
        buttonSelectType.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(buttonSelectType)
    }
    
    func setupbuttonTakePhoto(){
        buttonTakePhoto = UIButton(type: .system)
        buttonTakePhoto.setTitle("", for: .normal)
        buttonTakePhoto.setImage(UIImage(systemName: "camera.fill"), for: .normal)
        buttonTakePhoto.tintColor = .black
        buttonTakePhoto.showsMenuAsPrimaryAction = true
        buttonTakePhoto.contentHorizontalAlignment = .fill
        buttonTakePhoto.contentVerticalAlignment = .fill
        buttonTakePhoto.imageView?.contentMode = .scaleAspectFit
        buttonTakePhoto.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(buttonTakePhoto)
    }
    
    func setuppickerType(){
        pickerType = UIPickerView()
        pickerType.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(pickerType)
    }
    
    //MARK: initialize the constraints...
    func initConstraints(){
        NSLayoutConstraint.activate([
//            labelCreateProfile.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
//            labelCreateProfile.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 8),
            
            textFieldName.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            textFieldName.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 72),
            textFieldName.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 32),
            textFieldName.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -32),
            
            buttonTakePhoto.topAnchor.constraint(equalTo: textFieldName.bottomAnchor, constant: 16),
            buttonTakePhoto.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            buttonTakePhoto.widthAnchor.constraint(equalToConstant: 100),
            buttonTakePhoto.heightAnchor.constraint(equalToConstant: 100),
            
            textFieldEmail.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            textFieldEmail.topAnchor.constraint(equalTo: buttonTakePhoto.bottomAnchor, constant: 12),
            textFieldEmail.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 32),
            textFieldEmail.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -32),
            
            textFieldPhoneNum.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            textFieldPhoneNum.topAnchor.constraint(equalTo: textFieldEmail.bottomAnchor, constant: 12),
            textFieldPhoneNum.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 32),
            textFieldPhoneNum.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor, constant: 100),
            
            buttonSelectType.topAnchor.constraint(equalTo: textFieldEmail.bottomAnchor, constant: 12),
//            buttonSelectType.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            buttonSelectType.leadingAnchor.constraint(equalTo: textFieldPhoneNum.trailingAnchor),
            buttonSelectType.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -12),
            
            textFieldAddress1.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            textFieldAddress1.topAnchor.constraint(equalTo: textFieldPhoneNum.bottomAnchor, constant: 12),
            textFieldAddress1.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 32),
            textFieldAddress1.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -32),
            
            textFieldAddress2.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            textFieldAddress2.topAnchor.constraint(equalTo: textFieldAddress1.bottomAnchor, constant: 12),
            textFieldAddress2.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 32),
            textFieldAddress2.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -32),
            
            textFieldAddress3.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            textFieldAddress3.topAnchor.constraint(equalTo: textFieldAddress2.bottomAnchor, constant: 12),
            textFieldAddress3.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 32),
            textFieldAddress3.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -32),
            
            buttonSave.topAnchor.constraint(equalTo: textFieldAddress3.bottomAnchor, constant: 72),
            buttonSave.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
        ])
    }
    
    //MARK: unused methods...
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
