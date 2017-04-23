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

  func sort(_ seq: [T]) -> UnfoldSequence<(Int, Int, [T]), (Int, Int, [T])> {
    let head_tail = sequence(state: (0, 0, seq)) {
      (state: inout (Int, Int, [T])) -> (Int, Int, [T])? in
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

  func tail(head i: Int, sequence: [T]) -> Int {
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
