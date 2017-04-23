//
//  Decompose.swift
//  Sorting
//
//  Created by meh on 4/22/17.
//
//

import Foundation

extension Array {
  var slice: ArraySlice<Element> {
    return ArraySlice(self)
  }
}

extension ArraySlice {
  /// Retuns a decomposed array (Element, ArraySlice<Element>)
  func decompose() -> (Element, ArraySlice<Element>)? {
    return isEmpty ? nil : (self[startIndex], self.dropFirst())
  }
}
