//
//  SelectionSort.swift
//  Sorting
//
//  Created by meh on 4/14/17.
//
//

import Foundation

struct SelectionSort<T: Comparable> {

  let original: [T]
  init(_ source: [T]) {
    original = source
  }

  func sort(_ seq: [T]) ->
    UnfoldSequence<(Int, Int, ArraySlice<T>), (Int, Int, ArraySlice<T>)> {
    var min   = 0
    let tail_ = tail(min: &min, head: 0, sequence: seq.slice)
    let head_tail = sequence(state: (0, tail_, seq.slice)) {
      (state: inout (Int, Int, ArraySlice<T>)) -> (Int, Int, ArraySlice<T>)? in
      defer {
        var min = state.0+1
        if state.0+1 < state.2.count {
          let tail = self.tail(min: &min,
                               head: state.0+1,
                               sequence: state.2)
          var seq_ = state.2
          if (state.0 != state.1) {
            swap(&seq_[state.0], &seq_[state.1])
          }
          state = (state.0+1, tail, seq_)
        } else {
          state = (state.0+1, state.0+1, state.2)
        }
      }
      return state.0 < state.2.count ? state : nil
    }
    return head_tail
  }

  func tail(min: inout Int, head i: Int, sequence: ArraySlice<T>) -> Int {
    let drop_first = sequence.count-(original.count-i)
    guard let (head, tail) = sequence.dropFirst(drop_first).decompose()
      else { return min }
    if head < original[min] {
      min = i
    }
    return self.tail(min: &min, head: i+1, sequence: tail)
  }
}

extension SelectionSort: SortAlgorithm { }
