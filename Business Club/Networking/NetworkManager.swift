//
//  NetworkManager.swift
//  Business Club
//
//  Created by Jerald Abille on 2/14/19.
//  Copyright © 2019 Jerald Abille. All rights reserved.
//

import Foundation

struct NetworkManager {
  static let shared = NetworkManager()
  private init() {}
  
  func get<T:Codable>(_ api: BusinessClubAPI, resultType: T.Type, completion: @escaping ((_ result: T?, _ error: Error?) -> ())) {
    guard let request = try? api.asURLRequest() else {
      completion(nil, URLError(.badURL))
      return
    }
    let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
      guard error == nil else {
        completion(nil, error)
        return
      }
      if let data = data {
        do {
          let result = try JSONDecoder().decode(T.self, from: data)
          completion(result, nil)
        } catch {
          completion(nil, error)
        }
      }
    }
    task.resume()
  }
}
