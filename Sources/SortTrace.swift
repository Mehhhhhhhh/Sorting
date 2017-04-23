//
//  SortTrace.swift
//  Sorting
//
//  Created by meh on 4/14/17.
//
//

import Foundation

struct SortTrace<T> {
  let i: Int
  let j: Int
  let sequence: [T]
}

extension SortTrace {

  func ansii_color(i: Int, j: Int, index: Int) -> ANSIColors {
    switch index {
    case j:
      return ANSIColors.red
    case j...i:
      return ANSIColors.black
    default:
      return ANSIColors.gray
    }
  }

  func print_output() -> String {
    var output = "\(ANSIColors.black.rawValue)\(i)\t\(j)\t"
    for (index, value) in sequence.enumerated() {
      let value_ = "\(value)".padding(toLength: 2, withPad: " ", startingAt: 0)
      output += "\(ansii_color(i: i, j: j, index: index).rawValue)\(value_)"
    }
    return output
  }
}
