//
//  JSONStringify.swift
//  uniken_plugin
//
//  Created by iOS on 20/04/22.
//

import Foundation

/*
 
 var dic = [String: Any]()
 
 do {
     let strObj = try dic.stringify()
 } catch {
     DLog("ErrorHomeSocket: ", error)
     completion(false)
 }
 
 */

enum StringifyError: Error {
  case isNotValidJSONObject
}

struct JSONStringify {
    let value: Any
  
    func stringify(prettyPrinted: Bool = false) throws -> String {
        let options: JSONSerialization.WritingOptions = prettyPrinted ? .prettyPrinted : .init(rawValue: 0)
        if JSONSerialization.isValidJSONObject(self.value) {
            let data = try JSONSerialization.data(withJSONObject: self.value, options: options)
            if let string = String(data: data, encoding: .utf8) {
                return string
            }
        }
        throw StringifyError.isNotValidJSONObject
    }
}

protocol Stringifiable {
  func stringify(prettyPrinted: Bool) throws -> String
}

extension Stringifiable {
  func stringify(prettyPrinted: Bool = false) throws -> String {
    return try JSONStringify(value: self).stringify(prettyPrinted: prettyPrinted)
  }
}

extension Dictionary: Stringifiable {}
extension Array: Stringifiable {}
