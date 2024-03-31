//
//  ChatModel.swift
//  iOS_Team7
//
//  Created by Nitin Bhat on 3/25/24.
//

import Foundation

struct Chat {
    let id: String
    let participants: [String]

    init(id: String, participants: [String]) {
        self.id = id
        self.participants = participants
    }
}



