//
//  CharacterSetExtension.swift
//  Sorting
//
//  Created by meh on 4/16/17.
//
//

import Foundation

extension CharacterSet {

  func contains(_ c: Character) -> Bool {
    let scalars = String(c).unicodeScalars
    guard scalars.count == 1 else { return false }
    return contains(scalars.first!)
  }

  func contains_2(_ c:Character) -> Bool {
    guard let scalar = String(c).unicodeScalars.first else { return false }
    return contains(scalar)
  }
}
