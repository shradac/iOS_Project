//
//  notes.swift
//  ContactAppA4
//
//  Created by Nitin Bhat on 3/17/24.
//

import Foundation

struct Note{
    var id: String?
    var text: String?
    
    init(
         id: String? = nil,
         text: String? = nil
         ) {
             self.id = id
             self.text = text
    }
}

