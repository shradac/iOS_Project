//
//  tokenManager.swift
//  ContactAppA4
//
//  Created by Nitin Bhat on 3/17/24.
//

import Foundation


class AuthTokenManager {
    static let shared = AuthTokenManager() // Singleton instance
    
    private let tokenKey = "AuthToken"
    
    // Store the token
    func storeToken(_ token: String) {
        UserDefaults.standard.set(token, forKey: tokenKey)
    }
    
    // Retrieve the token
    func retrieveToken() -> String? {
        return UserDefaults.standard.string(forKey: tokenKey)
    }
    
    // Clear the token
    func clearToken() {
        UserDefaults.standard.removeObject(forKey: tokenKey)
    }
    
    func isLoggedIn() -> Bool {
        return retrieveToken() != nil
    }
}
