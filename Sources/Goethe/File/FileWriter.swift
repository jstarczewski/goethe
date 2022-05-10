//
//  File.swift
//  
//
//  Created by Jan Starczewski on 10/05/2022.
//

import Foundation

protocol FileWriter {
    
    func appendToFile(path: String, content: String) async throws
}

class OverflowingFileWriter : FileWriter {
    
    let fileReader: FileReader
    
    init(
        fileReader: FileReader
    ) {
        self.fileReader = fileReader
    }
    
    func appendToFile(path: String, content: String) async throws {
        let fileContent = try fileReader.readFile(path: path)
        let finalContent = fileContent.appending(content)
        try finalContent.write(toFile: path, atomically: true, encoding: String.Encoding.utf8)
    }
}
