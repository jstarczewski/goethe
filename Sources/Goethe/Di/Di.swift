//
//  File.swift
//  
//
//  Created by Jan Starczewski on 09/05/2022.
//

import Foundation


func provideFlashcardUseCase(filePath: String) -> FlashcardUseCase {
    let repository : WordsRepository = FileBasedWordsRepository(fileDataSource: FileDataSource(filePath: filePath))
    let randomizer = { (flashcards: [Flashcard]) in
        return flashcards.randomElement()!
    }
    return FlashcardUseCase(wordsRepository: repository, picker: randomizer)
}

func provideAddFlashcardUseCase(filePath: String) -> AddFlashCardUseCase {
    return AddFlashCardUseCase(fileWriter: OverflowingFileWriter(fileReader: OverflowingFileReader()), path: filePath)
}
