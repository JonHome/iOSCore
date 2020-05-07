//
//  ext_Dictionary.swift
//  core
//
//  Created by Jon Home on 2020/4/30.
//  Copyright © 2020 JonHome. All rights reserved.
//

import Foundation

extension Dictionary {
   var queryString: String {
      var output: String = ""
      for (key,value) in self {
          output += "\(key)=\(value)&"
      }
      output = String(output.dropLast())
      return output
   }
}

