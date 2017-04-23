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
