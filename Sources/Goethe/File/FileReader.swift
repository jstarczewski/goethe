//
//  File.swift
//  
//
//  Created by Jan Starczewski on 25/04/2022.
//

import Foundation

protocol FileReader {
    
    func readFile(path: String) throws -> String
}

class OverflowingFileReader : FileReader {
    
    func readFile(path: String) throws -> String {
        return try String(contentsOfFile: path, encoding: .utf8)
    }
}
