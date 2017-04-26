//
//  SortingIO.swift
//  Sorting
//
//  Created by meh on 4/22/17.
//
//

import Foundation

struct SortingIO {

  func compile(_ args: [String]) -> [Args] {
    guard let (head, tail) = args.slice.decompose()     else { return [Args]() }
    guard head.hasPrefix("--")                          else { return [Args]() }
    guard let pages = read(tail, until: read_condition) else { return [Args]() }
    let arg_enum: Args
    switch head {
      case "--input":
        arg_enum = Args.Input(pages.0)
      case "--print":
        arg_enum = Args.Print(pages.0)
      case "--algorithm":
        arg_enum = Args.Algorithm(pages.0[0])
      default:
        arg_enum = Args.Scheme([])
    }
    return [arg_enum] + compile([pages.1.0]+pages.1.1)
  }
}

extension SortingIO {
  enum Args {
    case Input([String])
    case Print([String])
    case Algorithm(String)
    case Scheme([Args])
  }

  func name(_ arg: Args) -> String {
    switch arg {
    case .Algorithm(_): return "algorithm"
    case .Input(_):     return "input"
    case .Print(_):     return "print"
    case .Scheme(_):    return "scheme"
    }
  }

  func execute(_ args: [Args]) -> String? {
    let unpackt = unpack(args)

    guard var input = unpackt.first(where: { (name_, input) -> Bool in
      return name_ == name(.Input([])) && input.count >= 1
    })?.1 else { return nil }

    guard let algo = unpackt.first(where: { (name_, input) -> Bool in
      return name_ == name(.Algorithm(""))
    })?.1[0] else { return nil }

    // convert input into an array if it is only one item
    if input.count == 1, let input_ = input.first {
      input = Array(input_.characters.flatMap({ (char) -> String? in
        return String(char)
      }))
    }

    let unfold_sequence: UnfoldSequence<
    (Int, Int, ArraySlice<String>),
    (Int, Int, ArraySlice<String>)>
    let printout: (UnfoldSequence<
    (Int, Int, ArraySlice<String>),
    (Int, Int, ArraySlice<String>)>) -> String


    if algo == "insertion" {
      let sorter = InsertionSort(source: input)
      unfold_sequence = sorter.sort(input)
      printout = sorter.printout
    } else {
      let sorter = SelectionSort(source: input)
      unfold_sequence = sorter.sort(input)
      printout = sorter.printout
    }

    return printout(unfold_sequence)
  }

  func unpack(_ args: [Args]) -> [(String, [String])] {
    var unpackt = [(String, [String])]()
    for each in args {
      if let each_ = unpack(each) { unpackt.append(each_) }
    }
    return unpackt
  }

  func unpack(_ arg: Args) -> (String, [String])? {
    switch arg {
    case .Algorithm(let algo):
      return (name(arg), [algo])
    case .Input(let input):
      return (name(arg), input)
    case .Print(let input):
      return (name(arg), input)
    default:
      return nil
    }
  }
}

extension SortingIO {

  func read_condition(input: String) -> Bool {
    return !input.hasPrefix("--")
  }

  func read(_ args: ArraySlice<String>,
            until condition: (String) -> Bool)
    -> ([String], (String, ArraySlice<String>))? {
    guard var (head, tail) = args.decompose() else { return nil }
    var array = [String]()
    repeat {
      array.append(head)
      (head, tail) = tail.decompose() ?? ("", [String]().slice)
    } while condition(head) && tail.count > 0 // weird, executes at least once; diff than while{...}
    return (array, (head, tail))
  }
}
