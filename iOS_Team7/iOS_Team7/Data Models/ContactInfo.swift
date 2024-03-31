//
//  ContactInfo.swift
//  ContactAppA4
//
//  Created by Nitin Bhat on 2/9/24.
//

import Foundation
import UIKit

struct Profile{
    var id: String?
    var name:String?
    var email:String?
    var phone:String?
    var address:String?
    var state:String?
    var zipcode:String?
    var phoneType: String?
    var image: UIImage?

    
    init(
        id: String? = nil,
         name: String? = nil,
         email: String? = nil,
         phone: String? = nil,
         address: String? = nil,
         state: String? = nil,
         zipcode: String? = nil,
         phoneType: String? = nil,
         image: UIImage) {
        self.id = id;
        self.name = name
        self.email = email
        self.phone = phone
        self.address = address
        self.state = state
        self.zipcode = zipcode
        self.phoneType = phoneType
        self.image = image
    }
    
}
