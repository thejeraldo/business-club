//
//  Company.swift
//  Business Club
//
//  Created by Jerald Abille on 2/13/19.
//  Copyright © 2019 Jerald Abille. All rights reserved.
//

import Foundation

struct Company: Codable {
  let companyId: String
  let name: String
  let website: String
  let logo: String
  let about: String
  let members: [Member]
  
  enum CodingKeys: String, CodingKey {
    case companyId = "_id"
    case name = "company"
    case website = "website"
    case logo = "logo"
    case about = "about"
    case members = "members"
  }
}
