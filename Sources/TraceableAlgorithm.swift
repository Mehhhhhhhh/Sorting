//
//  TraceableAlgorithm.swift
//  Sorting
//
//  Created by meh on 4/25/17.
//
//

import Foundation

protocol TraceableAlgorithm {
  associatedtype ItemType
  func sort(_ seq: [ItemType]) -> UnfoldSequence<
    (Int, Int, ArraySlice<ItemType>),
    (Int, Int, ArraySlice<ItemType>)>
}
