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
}

extension SortingIO {

  func read_condition(input: String) -> Bool {
    return !input.hasPrefix("--")
  }

  func read(_ args: ArraySlice<String>,
            until condition: (String) -> Bool) -> ([String], (String, ArraySlice<String>))? {
    guard var (head, tail) = args.decompose() else { return nil }
    var array = [String]()
    repeat {
      array.append(head)
      (head, tail) = tail.decompose() ?? ("", [String]().slice)
    } while condition(head) && tail.count > 0 // weird, executes at least once; diff than while{...}
    return (array, (head, tail))
  }
}
