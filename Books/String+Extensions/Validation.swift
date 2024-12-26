//
//  Validation.swift
//  Books
//
//  Created by Edgar Adamyan on 21.12.24.
//

import Foundation

extension String{
  
  func isValidPassword() -> Bool{
    
    let patern = "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{7,}"
    do {
      let regex = try NSRegularExpression(pattern: patern)
      let range = NSRange(self.startIndex..<self.endIndex,in: self)
      return regex.firstMatch(in: self, range: range) != nil
    }catch{
      print("Error: \(error.localizedDescription)")
    }
    return false
  }
  
  func isValidEmail() -> Bool{
    let pattern = "[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
    do{
      let regex = try NSRegularExpression(pattern: pattern)
      let range = NSRange(self.startIndex..<self.endIndex, in: self)
      return regex.firstMatch(in: self, range: range) != nil
    }catch{
      print("Error: \(error.localizedDescription)")
    }
    return false
  }
}
