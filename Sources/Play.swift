//
//  Play.swift
//  Sorting
//
//  Created by meh on 4/19/17.
//
//

import Foundation

//let fibonnaci = sequence(state: (0, 1)) {
//  (state: inout (Int, Int)) -> Int? in
//  defer { state = (state.1, state.0+state.1) }
//  return state.0
//}
//
//// is prime: using seive of Eras
//var prime_seed = 2
//var k: Int // increment by += 1
//let n = 30
//
//
//var seive: [Int] = []
//while (prime_seed*prime_seed) < n {
//  k = 2
//  while (prime_seed*k)<n {
//    seive.append(prime_seed*k)
//    k += 1
//  }
//  // increment prime seed
//  prime_seed += 1
//  while (seive.contains(prime_seed)) {
//    prime_seed += 1
//  }
//}
//
//print(seive)
//
//let s = sequence(state: (2, prime_seed, prime_seed+1)) {
//  (state: inout (Int, Int, Int)) -> Int? in
//
//  var k = state.0
//  // a refinement
//  while k*prime_seed < prime_seed*prime_seed {
//    k += 1
//  }
//  state.0 = k
//
//  defer {
//    // if seed^2
//    if prime_seed*prime_seed > n {
//      prime_seed += 1
//      for i in 2..<prime_seed {
//
//      }
//    }
//  }
//
//  return state.0*state.1
//}
