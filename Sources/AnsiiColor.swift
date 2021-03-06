//
//  AnsiiColor.swift
//  Sorting
//
//  Created by meh on 4/19/17.
//
//

import Foundation

// ANSI Colors
enum ANSIColors: String {
  case black    = "\u{001B}[0;30m"
  case gray     = "\u{001B}[2;30m"
  case red      = "\u{001B}[0;31m"
  case green    = "\u{001B}[0;32m"
  case yellow   = "\u{001B}[0;33m"
  case blue     = "\u{001B}[0;34m"
  case magenta  = "\u{001B}[0;35m"
  case cyan     = "\u{001B}[0;36m"
  case white    = "\u{001B}[0;37m"

  func name() -> String {
    switch self {
    case .black:    return "Black"
    case .red:      return "Red"
    case .green:    return "Green"
    case .yellow:   return "Yellow"
    case .blue:     return "Blue"
    case .magenta:  return "Magenta"
    case .cyan:     return "Cyan"
    case .white:    return "White"
    case .gray:     return "Gray"
    }
  }

  static func all() -> [ANSIColors] {
    return [.black,
            .gray,
            .red,
            .green,
            .yellow,
            .blue,
            .magenta,
            .cyan,
            .white]
  }
}

func + (left: ANSIColors, right: String) -> String {
  return left.rawValue + right
}
