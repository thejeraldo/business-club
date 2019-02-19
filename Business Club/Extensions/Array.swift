//
//  Array.swift
//  Business Club
//
//  Created by Jerald Abille on 2/19/19.
//  Copyright © 2019 Jerald Abille. All rights reserved.
//

import Foundation

extension Array {
  mutating func modifyForEach(_ body: (_ index: Index, _ element: inout Element) -> ()) {
    for index in indices {
      modifyElement(atIndex: index) { body(index, &$0) }
    }
  }
  
  mutating func modifyElement(atIndex index: Index, _ modifyElement: (_ element: inout Element) -> ()) {
    var element = self[index]
    modifyElement(&element)
    self[index] = element
  }
}
