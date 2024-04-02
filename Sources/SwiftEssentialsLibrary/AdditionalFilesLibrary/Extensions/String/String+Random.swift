//
//  String+Random.swift
//  twotwotwo-ios
//
//  Created by Adam Novak on 5/31/23
//

import Foundation

    
func randomStringOfNumbers(length: Int) -> String {
  let letters = "0123456789"
  return String((0..<length).map{ _ in letters.randomElement()! })
}
    
