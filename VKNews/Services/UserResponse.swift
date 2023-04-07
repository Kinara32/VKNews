//
//  UserResponse.swift
//  VKNews
//
//  Created by Matvei Bykadorov on 07.04.2023.
//

import Foundation

struct UserResponseWrapped: Decodable {
    let response: [UserResponse]
}

struct UserResponse: Decodable {
    let photo100: String?
}
