//
//  FlashcardUseCase.swift
//  
//
//  Created by Jan Starczewski on 26/04/2022.
//

import Foundation

class FlashcardUseCase {
    
    let wordsRepository: WordsRepository
    let picker: ([Flashcard]) -> Flashcard
    
    init(
        wordsRepository: WordsRepository,
        picker : @escaping ([Flashcard]) -> Flashcard
    ) {
        self.wordsRepository = wordsRepository
        self.picker = picker
    }
    
    func getRandomFlashcard() async throws -> Flashcard {
        let words = try await wordsRepository.getWords()
        let flashcards = words.map { word in
            return Flashcard(name: word.value, meaning: word.translation)
        }
        return picker(flashcards)
    }
}
