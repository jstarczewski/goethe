//
//  File.swift
//  
//
//  Created by Jan Starczewski on 10/05/2022.
//

import Foundation

class AddFlashCardUseCase {
    
    let fileWriter: FileWriter
    let path: String
    
    init(fileWriter: FileWriter, path: String) {
        self.fileWriter = fileWriter
        self.path = path
    }
    
    func addFlashCard(flashCard: Flashcard) async throws {
        let content = flashCard.name + ":" + flashCard.meaning + ";"
        print(content)
        try await fileWriter.appendToFile(path: path, content: content)
    }
}
