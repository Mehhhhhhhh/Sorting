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
