//
//  File.swift
//  
//
//  Created by Jan Starczewski on 26/04/2022.
//

import Foundation

class FileDataSource {
    
    private let contentOfFile : String
    
    init(filePath: String) {
        do {
            contentOfFile = try String(contentsOfFile: filePath, encoding: .utf8)
        } catch is Error {
            contentOfFile = ""
        }
    }
    
    func getWordTuples() -> [(String, String)] {
        contentOfFile
            .split(separator: ";")
            .map(tupledOrEmpty)
            .filter { tuple in !tuple.0.isEmpty && !tuple.1.isEmpty }
    }
    
    private func tupledOrEmpty(pair: Substring) -> (String, String) {
        let values = pair.split(separator: ":")
        if values.indices.count != 2 {
            return ("", "")
        }
        let word : String? = String(values[0])
        let translation: String? = String(values[1])
        let tuple : (String, String) = (word.orEmpty(), translation.orEmpty())
        return tuple
    }
}

private extension Optional where Wrapped == String {
    
    func orEmpty() -> String {
        if self != nil {
            return self!
        } else {
            return ""
        }
    }
}

