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

  func sort(_ seq: [T]) ->
    UnfoldSequence<(Int, Int, ArraySlice<T>), (Int, Int, ArraySlice<T>)> {
    var min   = (0, seq[0])
    let tail_ = tail(min: &min, head: 0, sequence: seq.slice).0
    let head_tail = sequence(state: (0, tail_, seq.slice)) {
      (state: inout (Int, Int, ArraySlice<T>)) -> (Int, Int, ArraySlice<T>)? in
      defer {
        if (state.0 != state.1) {
          swap(&state.2[state.0], &state.2[state.1])
        }
        if state.0+1 < state.2.count {
          var min = (state.0+1,state.2[state.0+1])
          let tail = self.tail(min: &min,
                               head: state.0+1,
                               sequence: state.2)
          state = (state.0+1, tail.0, state.2)
        } else {
          state = (state.0+1, state.0+1, state.2)
        }
      }
      return state.0 < state.2.count ? state : nil
    }
    return head_tail
  }

  func tail(min: inout (Int,T), head i: Int, sequence: ArraySlice<T>) ->
    (Int,T) {
    var drop_first = sequence.count-(original.count-i)
    drop_first = max(0, drop_first)
    guard let (head, tail) = sequence.dropFirst(drop_first).decompose()
      else { return min }
    if head < min.1 {
      min = (i, head)
    }
    return self.tail(min: &min, head: i+1, sequence: tail)
  }
}

extension SelectionSort: SortAlgorithm { }
