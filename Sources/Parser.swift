//
//  Parser.swift
//  Sorting
//
//  Created by meh on 4/15/17.
//
//

import Foundation

//typealias Stream = String.CharacterView
//typealias Parser<Result> = (Stream) -> (Result, Stream)?

struct Parser<Result> {
  typealias Stream = String.CharacterView
  let parse: (Stream) -> (Result, Stream)?

  init(_ parse_: @escaping (Stream) -> (Result, Stream)?) {
    parse = parse_
  }
}

func character(matching condition: @escaping (Character) -> Bool) -> Parser<Character> {
  return Parser<Character>({ input in
    guard let char = input.first, condition(char) else { return nil }
    return (char, input.dropFirst())
  })
}

extension Parser {

  /// @Description  run the parser on a stream
  /// @Returns the result and remainder as a `String` or nil
  func run(_ string: String) -> (Result, String)? {
    guard let (result, remainder) = parse(string.characters) else { return nil }
    return (result, String(remainder))
  }
}

extension Parser {

  /// @Description aggregator for a homogenous sequence
  var many: Parser<[Result]> {
    return Parser<[Result]> { input in
      var results: [Result] = []
      var remainder = input
      while let (result, remainder_) = self.parse(remainder) {
        results.append(result)
        remainder = remainder_
      }
      return (results, remainder)
    }
  }

  /// @Description aggregator for non-homogenous sequence
  func followed<A>(by next: Parser<A>) -> Parser<(Result, A)> {
    return Parser<(Result, A)> { input in
      guard let (result, remainder) = self.parse(input) else { return nil }
      guard let (next_, remainder_) = next.parse(remainder) else { return nil }
      return ((result, next_), remainder_)
    }
  }
}

extension Parser {

  func map<T>(_ transform: @escaping (Result) -> T) -> Parser<T> {
    return Parser<T> { input in
      guard let (result, remainder) = self.parse(input) else { return nil }
      return (transform(result), remainder)
    }
  }
}
