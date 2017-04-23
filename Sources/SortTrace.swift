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
  let sequence: ArraySlice<T>

  init(i i_: Int, j j_: Int, sequence sequence_: ArraySlice<T>) {
    i = i_
    j = j_
    sequence = sequence_
    _affected = j...i
  }

  init(i i_: Int, j j_: Int, sequence sequence_: ArraySlice<T>,
       affected: ClosedRange<Int>) {
    i = i_
    j = j_
    sequence = sequence_
    _affected = affected
  }

  fileprivate var _affected: ClosedRange<Int>
  var affectedRange: ClosedRange<Int> {
    get { return _affected }
    set(value) {
      _affected = value
    }
  }
}

extension SortTrace {

  func ansii_color(i: Int, j: Int, index: Int) -> ANSIColors {
    switch index {
    case j:
      return ANSIColors.red
    case affectedRange:
      return ANSIColors.black
    default:
      return ANSIColors.gray
    }
  }

  func print_output(with padding: Int) -> String {
    var output    = "\(ANSIColors.black.rawValue)\(i)\t\(j)\t"
    for (index, value) in sequence.enumerated() {
      let value_  = "\(value)".padding(toLength: padding,
                                      withPad: " ", startingAt: 0)
      let color   = ansii_color(i: i, j: j, index: index).rawValue
      output      += "\(color)\(value_)"
    }
    return output
  }
}
