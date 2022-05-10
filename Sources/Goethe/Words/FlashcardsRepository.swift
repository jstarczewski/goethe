//
//  File.swift
//  
//
//  Created by Jan Starczewski on 26/04/2022.
//

import Foundation

struct Word {
    let value : String
    let translation : String
    let meaning : String = ""
}

protocol WordsRepository {
    
    func getWords() async throws -> [Word]
}

class FileBasedWordsRepository: WordsRepository {
    
    private let words : [Word]
    
    init(fileDataSource: FileDataSource) {
        words = fileDataSource.getWordTuples().map{ tuple in
            return Word(value: tuple.0, translation: tuple.1)
        }
    }
    
    func getWords() async throws -> [Word] { words }
}
