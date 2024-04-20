//
//  UserSingleton.swift
//  SnapchatClone
//
//  Created by Omer Keskin on 18.04.2024.
//

import Foundation


class UserSingleton{
    
    static let shareUserInfo = UserSingleton()
    
    var email = ""
    var username = ""
    
    private init() {

    }
    
}
