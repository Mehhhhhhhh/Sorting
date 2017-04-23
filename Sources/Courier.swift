//
//  Courier.swift
//  Sorting
//
//  Created by meh on 4/19/17.
//
//

import Foundation

func courier<A, B, C>(_ f: @escaping (A,B) -> C) -> (A) -> (B) -> C {
  return { a in
    { b in
      f(a,b)
    }
  }
}

func courier<A, B, C, D>(_ f: @escaping (A, B, C) -> D) -> (A) -> (B) -> (C) -> D {
  return { a in { b in { c in f(a, b, c) } } }
}
