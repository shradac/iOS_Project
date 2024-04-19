//
//  Profile.swift
//  iOS_Team7
//
//  Created by Vasu Agarwal on 4/5/24.
//

import Foundation
import UIKit

struct Profile{
    var name: String?
    var email: String?
    var phoneType: String?
    var profileImage: String?
    var phone: Int?
    var role: String?
    var tags: [String]
    var address1: String?
    var address2: String?
    var address3: String?
    var experts : [String]
    
    init(name: String? = nil,
         email: String? = nil,
         experts: [String] = [],
         phoneType: String? = nil,
         profileImage: String? = nil,
         phone: Int? = nil,
         role: String? = nil,
         tags: [String] = [],
         address1: String? = nil,
         address2: String? = nil,
         address3: String? = nil) {
        self.name = name
        self.email = email
        self.experts = experts
        self.phoneType = phoneType
        self.profileImage = profileImage
        self.phone = phone
        self.role = role
        self.tags = tags
        self.address1 = address1
        self.address2 = address2
        self.address3 = address3
    }
    
}
