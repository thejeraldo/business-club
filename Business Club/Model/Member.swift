//
//  Member.swift
//  Business Club
//
//  Created by Jerald Abille on 2/13/19.
//  Copyright © 2019 Jerald Abille. All rights reserved.
//

import Foundation

struct Name: Codable {
  let firstName: String
  let lastName: String
  
  enum CodingKeys: String, CodingKey {
    case firstName = "first"
    case lastName = "last"
  }
}

typealias Members = [Member]

struct Member: Codable {
  let memberId: String
  let age: Int
  let name: Name
  let email: String
  let phone: String
  
  enum CodingKeys: String, CodingKey {
    case memberId = "_id"
    case age = "age"
    case name = "name"
    case email = "email"
    case phone = "phone"
  }
}
