//
//  Company.swift
//  Business Club
//
//  Created by Jerald Abille on 2/13/19.
//  Copyright © 2019 Jerald Abille. All rights reserved.
//

import Foundation

typealias Companies = [Company]

struct Company: Codable {
  let companyId: String
  let name: String
  let website: String
  let logo: String
  let about: String
  var members: [Member]
  
  var isFollowing: Bool = false
  var isFavorite: Bool = false
  
  enum CodingKeys: String, CodingKey {
    case companyId = "_id"
    case name = "company"
    case website = "website"
    case logo = "logo"
    case about = "about"
    case members = "members"
  }
}

extension Company {
  mutating func toggleFollow() {
    isFollowing = isFollowing ? false : true
  }
  
  mutating func toggleFavorite() {
    isFavorite = isFavorite ? false : true
  }
  
  mutating func toggleFavorite(_ member: Member) {
    guard let index = members.lastIndex(where: { $0.memberId == member.memberId }) else { return }
    members.modifyElement(atIndex: index) { $0.toggleFavorite() }
  }
}
