//
//  UIImageView.swift
//  Business Club
//
//  Created by Jerald Abille on 2/15/19.
//  Copyright © 2019 Jerald Abille. All rights reserved.
//

import Foundation
import UIKit

let imageCache = NSCache<AnyObject, AnyObject>()

extension UIImageView {
  func setURL(_ url: URL) {
    if let imageFromCache = imageCache.object(forKey: url.absoluteString as AnyObject) as? UIImage {
      self.image = imageFromCache
      return
    } else {
      self.image = nil
    }
    URLSession.shared.dataTask(with: url) { data, response, error in
      guard error == nil else { return }
      guard let data = data else { return }
      DispatchQueue.main.async {
        if let imageToCache = UIImage(data: data) {
          imageCache.setObject(imageToCache, forKey: url.absoluteString as AnyObject)
          self.image = imageToCache
        }
      }
    }.resume()
  }
}
