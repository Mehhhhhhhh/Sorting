#!/usr/bin/swift

import Foundation
import RxSwift

/// Terminal Input
/// sorting --input ThisIsAStringToSort --print trace exchanges compares --algorithm insertion
/// sorting --input <<input>> --print <<attributes>> --algorithm <<insertion|selection|h>>

let default_args =
"--input thisisastringtosort --print trace exchanges compares --algorithm mergesort"
  .components(separatedBy: " ")
let args = (ProcessInfo.processInfo.arguments.count == 1
  ? default_args
  : Array(ProcessInfo.processInfo.arguments.dropFirst()))

let sortingIO = SortingIO()
let args_enum = sortingIO.compile(args)
if let printout = sortingIO.execute(args_enum) {
  print(printout)
}
