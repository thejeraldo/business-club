//
//  BusinessClubAPI.swift
//  Business Club
//
//  Created by Jerald Abille on 2/14/19.
//  Copyright © 2019 Jerald Abille. All rights reserved.
//

import Foundation

enum BusinessClubAPI {
  case getCompanyList()
}

extension BusinessClubAPI: APIProtocol {
  var baseURL: String {
    return "https://next.json-generator.com"
  }
  
  var path: String {
    return "api/json/get/Vk-LhK44U"
  }
  
  var method: String {
    return "GET"
  }
  
  func asURLRequest() throws -> URLRequest {
    guard let url = URL(string: baseURL)?.appendingPathComponent(path) else {
      throw URLError(.badURL)
    }
    var req = URLRequest(url: url)
    req.httpMethod = method
    return req
  }
}
