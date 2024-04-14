//
//  User.swift
//  iOS_Team7
//
//  Created by Nitin Bhat on 4/4/24.
//

import Foundation
import UIKit

struct User{
    var id: String?
    var name:String?
    var email:String?
    var experts: [String]
    
    
    init(
         id: String? = nil,
         name: String? = nil,
         email: String? = nil,
         experts: [String] = []
         ) {
        self.id = id;
        self.name = name
        self.email = email
        self.experts = experts
    }
    
}
