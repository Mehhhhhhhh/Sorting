import Foundation
import RxSwift

let sample = ["S", "O", "R", "T", "E", "X", "A", "M", "P", "L", "E"]
let insertion_sort = InsertionSort<String>()
let unfold_sequence = insertion_sort.sort(sample)

//var output = " \t \t\(sample)\n"
let padding = String(stringInterpolationSegment: sample.count).characters.count+1
var output = "i\tj\t"
for i in 0...sample.count-1 {
  output += "\(i)".padding(toLength: padding, withPad: " ", startingAt: 0)
}
output += "\n"
for i in unfold_sequence {
  let trace = SortTrace(i: i.0, j: i.1, sequence: i.2)
  output += (trace.print_output(with: padding) + "\n")
}

print(output)

//func printTree(height: Int, padding: Int) {
//  if height == 1 {
//    println("   " * padding + "*")
//  } else {
//    printTree(height - 1, padding + 1)
//    println("   " * padding + "*")
//    printTree(height - 1, padding + 1)
//  }
//}


//let one   = character { $0 == "1" }
////let parse = one.parse("123".characters)
//print(one.run("123"))
//let digit = character { CharacterSet.decimalDigits.contains_2($0) }
//let digit_2 = character { CharacterSet.decimalDigits.contains(String($0).unicodeScalars.first!) }
//let integer = digit.many.map { Int(String($0))! } // eager aggregator of integers
//let many  = digit.many.run("123")
//let many_2 = integer.run("123abc")

//print(many_2)


/// @Description accepts the tuple created from a non-homogenous sequences
/// @Discussion   at the moment this function is applied, we have a tuple and a result
//func multiply(lhs: (Int, Character), rhs: Int) -> Int {
//  return lhs.0 * rhs
//}

/// @Description `imperative` implementation of multiply.
/// @Discussion   method requires that all parameters are known @ the moment the
/// function is applied
func multiply(_ x: Int, _ op: Character, _ y: Int) -> Int {
  return x*y
}


/// @Description  functional implementation of multiply
/// @Discussion   @ the moment this method is appied, only the first parameter is known
func curriedMultiply(_ x: Int) -> (Character) -> (Int) -> Int {
  /* 
   return a closure that looks like the following:
   return { character -> (Int) -> Int in 
    return { integer -> (Int) in
      return x * integer
    }
   }
  */
  return { character -> (Int) -> Int in
    return { y -> (Int) in
      // innermost return
      return x * y
    }
  }
}

//let c = Character("*")
//let multiply_curried_2 = courier(multiply)
//print(multiply_curried_2)
// 2*3 parser multiplication
//let multiplication  = integer.followed(by: character { $0 == "*"}).followed(by: integer)
//let t     = multiplication.run("2*3")
//print(t)
//let multiplication_2 = multiplication.map { $0.0 * $1 }
//print(multiplication_2.run("2*3"))

// curried
//let p1 = integer.map(courier(multiply))
//let p2 = p1.followed(by: character { $0 == "*" }).map { f, op in f(op) }
//let p3 = p2.followed(by: integer).map { f, i in f(i) }
//let p4 = p3.run("2*3")
//
//let multiplyBy = character { $0 == "*" }
//let p5 = integer.map(courier(multiply))
//  .followed(by: multiplyBy).map { f, op in f(op) }
//  .followed(by: integer).map { f, y in f(y) }
//print(p5.run("2*3"))
//

/// !!!TODO: use the Observables.from to create a sequence from a sequence
///     the sort algorithms will then pass in the sequences
//print(sample)
//print("i\tj")

//// insertion sort
//var insertion_sequence = [String]()// sample
//let sorter    = InsertionSort<String>()
//sorter.iterate(forward: insertion_sequence.count).subscribe(
//  onNext: { i in
//    var min_j_index: Int = i
//    sorter.iterate(backward: i, to: 0, by: -1)
//      .takeWhile({ j in
//        return sorter.insert(left: j, into: insertion_sequence)
//    }).subscribe(onNext: { j in
//      swap(&insertion_sequence[j], &insertion_sequence[j-1])
//      min_j_index = j-1
//    }).dispose()
//    print("\(i)\t\(min_j_index)")
//}).dispose()
//print(insertion_sequence)
//
//// selection sort
//print("\n\n\(sample)")
//print("i\tj")
//var selection_sequence = [String]() //sample
//let sorter_2 = SelectionSort<String>()
//sorter_2.iterate(forward: selection_sequence.count).subscribe(
//  onNext: { i in
//    var min = i
//    sorter_2.iterate(backward: selection_sequence.count-1, to: i+1, by: -1)
//      .subscribe(
//        onNext: { j in
//          if selection_sequence[j] <= selection_sequence[min] {
//            min = j }
//    }).dispose()
//    print("\(i)\t\(min)")
//    if i != min {
//      swap(&selection_sequence[i], &selection_sequence[min]) }
//}).dispose()
//print(selection_sequence)
//
//// shell sort
//var shell_sequence = [String]() // "SHELLSORTEXAMPLE".characters.map { "\($0)" }
//let shell_sorter    = ShellSort<String>()
//
//shell_sorter.hsorter(shell_sequence.count).subscribe(
//  onNext: { h in
//    shell_sorter.iterate(forward: shell_sequence.count).subscribe(
//      onNext: { i in
//        shell_sorter.iterate(backward: i, to: h-1, by: -h).subscribe(
//          onNext: { j in
//            if shell_sequence[j] < shell_sequence[j-h] {
//              swap(&shell_sequence[j], &shell_sequence[j-h])}
//          }
//        ).dispose()
//      }
//    ).dispose()
//  }
//).dispose()
//print(shell_sequence)
