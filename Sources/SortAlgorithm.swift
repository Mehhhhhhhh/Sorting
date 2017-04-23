//
//  SortAlgo.swift
//  Sorting
//
//  Created by meh on 4/14/17.
//
//

import Foundation
import RxSwift

protocol SortAlgorithm { }

extension SortAlgorithm {

  func iterate(forward to: Int) -> Observable<Int> {
    return Observable.create {
      observer in
      for index in stride(from: 0, to: to, by: 1) {
        observer.on(.next(index))
      }
      observer.on(.completed)
      return Disposables.create()
    }
  }

  /// !!!TODO: replace with Sequence protocol
  func iterate(backward from: Int, to until: Int, by: Int) -> Observable<Int> {
    return Observable.create {
      observer in
      for index in stride(from: from, to: until, by: by) {
        observer.on(.next(index))
      }
      observer.on(.completed)
      return Disposables.create()
    }
  }
}
