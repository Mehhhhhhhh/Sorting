//
//  InsertionSort.swift
//  Sorting
//
//  Created by meh on 4/13/17.
//
//

import Foundation
import RxSwift

struct InsertionSort<T: Comparable> {
  let source: [T]

  func tail(head i: Int, sequence: ArraySlice<T>) -> Int {
    var offset = i
    while offset > 0 && sequence[i] < sequence[offset-1] {
      offset -= 1
    }
    return offset
  }

  func insert(left of: Int, into sequence: [T]) -> Bool {
    return sequence[of] < sequence[of-1]
  }
}

extension InsertionSort: SortAlgorithm { }

extension InsertionSort: TraceableAlgorithm {

  func sort(_ seq: [T])
    -> UnfoldSequence<(Int, Int, ArraySlice<T>), (Int, Int, ArraySlice<T>)> {
      let head_tail = sequence(state: (0, 0, seq.slice)) {
        (state: inout (Int, Int, ArraySlice<T>)) -> (Int, Int, ArraySlice<T>)? in
        defer {
          let head = state.0+1
          if head < state.2.count {
            let tail = self.tail(head: head, sequence: state.2)
            var seq_ = state.2
            if (head != tail) {
              for i in (tail...head-1).reversed() {
                swap(&seq_[i], &seq_[i+1])
              }
            }
            state = (head, tail, seq_)
          } else {
            state = (state.0+1, state.0+1, state.2)
          }
        }
        return state.0 < state.2.count ? state : nil
      }
      return head_tail
  }

  func printout(_ seq:
    UnfoldSequence<(Int, Int, ArraySlice<T>), (Int, Int, ArraySlice<T>)>)
    -> String {
    let padding =
      String(stringInterpolationSegment: source.count)
        .characters.count+1
    var output = "i\tj\t"
    for i in 0...source.count-1 {
      output += "\(i)".padding(toLength: padding, withPad: " ", startingAt: 0)
    }
    output += "\n"
    for i in seq {
      var trace = SortTrace(i: i.0, j: i.1, sequence: i.2,
                            affected:i.0...i.2.count-1)
      trace.affectedRange = i.1...i.0
      output += (trace.print_output(with: padding) + "\n")
    }
    output += ANSIColors.black.rawValue
    return output
  }
}
