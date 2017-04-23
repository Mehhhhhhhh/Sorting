#!/usr/bin/swift

import Foundation
import RxSwift

/// Terminal Input
/// sorting --input ThisIsAStringToSort --print trace exchanges compares --algorithm insertion
/// sorting --input <<input>> --print <<attributes>> --algorithm <<insertion|selection|h>>


let sample = ["S", "O", "R", "T", "E", "X", "A", "M", "P", "L", "E"]

let selection_sort = SelectionSort(sample)
let insertion_sort = InsertionSort<String>()
let unfold_sequence = selection_sort.sort(sample) // insertion_sort.sort(sample)
let args = ProcessInfo.processInfo.arguments

var min = 7
let i = selection_sort.tail(min: &min, head: 7, sequence: sample.slice)
print(i)

var mock_args =
  "--input ThisIsAStringToSort --print trace exchanges compares --algorithm insertion"
    .components(separatedBy: " ")

let sortingIO = SortingIO()
let args_enum = sortingIO.compile(mock_args)

let padding = String(stringInterpolationSegment: sample.count)
  .characters.count+1
var output = "i\tj\t"
for i in 0...sample.count-1 {
  output += "\(i)".padding(toLength: padding, withPad: " ", startingAt: 0)
}
output += "\n"
for i in unfold_sequence {
  var trace = SortTrace(i: i.0, j: i.1, sequence: i.2,
                        affected:i.0...i.2.count-1)
  trace.affectedRange = i.0...i.2.count-1
  output += (trace.print_output(with: padding) + "\n")
}
output += ANSIColors.black.rawValue
print(output)
