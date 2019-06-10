//
//  User.swift
//  Potatso
//
//  Created by LEI on 8/18/16.
//  Copyright © 2016 TouchingApp. All rights reserved.
//

import Foundation

public class User {

    public static let currentUser = User()

    public var id: String {
        if let id = keychain["userId"] {
            return id
        } else {
            let random = UUID().uuidString
            keychain["userId"] = random
            return random
        }
    }

}
