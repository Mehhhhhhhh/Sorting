//
//  ShellSort.swift
//  Sorting
//
//  Created by meh on 4/14/17.
//
//

import Foundation
import RxSwift

struct ShellSort<T: Comparable> {

  let source: [T]

  func h_sequence(_ end_index: Int) -> UnfoldSequence<Int, Int> {
    var h = 1
    while h < end_index/3 { h=1+3*h }
    let h_decrementer = sequence(state: (h)) {
      (state:inout (Int)) -> Int? in
      defer {
        if h >= 1 {
          h /= 3
        } else { h = 0 }
        state = h
      }
      return state >= 1 ? state : nil
    }
    return h_decrementer
  }

  func sort(_ seq: [T], h: Int)
    -> UnfoldSequence<(Int, Int, ArraySlice<T>), (Int, Int, ArraySlice<T>)> {
      let head_tail = sequence(state: (h, 0, seq.slice)) {
        (state: inout (Int, Int, ArraySlice<T>)) -> (Int, Int, ArraySlice<T>)? in
        defer {
          let head = state.0
          if head < state.2.count {
            let tail = self.tail(head: head, h: h, sequence: state.2)
            var seq_ = state.2
            if (head != tail) {
              for i in (tail...head-1).reversed() {
                swap(&seq_[i], &seq_[i+1])
              }
            }
            state = (head+1, tail, seq_)
          } else {
            state = (state.0+1, state.0+1, state.2)
          }
        }
        return state.0 < state.2.count ? state : nil
      }
      return head_tail
  }

  func tail(head i: Int, h: Int, sequence: ArraySlice<T>) -> Int {
    var offset = i
    while offset-h >= 0 && sequence[i] < sequence[offset-h] {
      offset -= h
    }
    return offset
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

  func hsorter(_ endIndex: Int) -> Observable<Int> {
    return Observable.create {
      observer in
      var h = 1
      while h < endIndex/3 { h = 1+3*h }
      while h >= 1 {
        observer.on(.next(h))
        h /= 3
      }
      observer.on(.completed)
      return Disposables.create()
    }
  }
}

extension ShellSort: SortAlgorithm { }
