//
//  APIProtocol.swift
//  Business Club
//
//  Created by Jerald Abille on 2/14/19.
//  Copyright © 2019 Jerald Abille. All rights reserved.
//

import Foundation

protocol APIProtocol {
  var baseURL: String { get }
  var path: String { get }
  var method: String { get }
  func asURLRequest() throws -> URLRequest
}
