//
//  ContactInfo.swift
//  ContactAppA4
//
//  Created by Nitin Bhat on 2/9/24.
//

import Foundation
import UIKit

struct User{
    var id: String?
    var name:String?
    var email:String?
    
    init(
         id: String? = nil,
         name: String? = nil,
         email: String? = nil
         ) {
        self.id = id;
        self.name = name
        self.email = email
    }
    
}
