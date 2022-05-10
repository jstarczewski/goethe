import Foundation

@main
struct Goethe {
    
    static func main() async throws {
        let path = FileManager.default.currentDirectoryPath
        let finalPath = path + "/" + "words.txt"
        print(finalPath)
        let flashCardUseCase : FlashcardUseCase = provideFlashcardUseCase(filePath: finalPath)
        let addFlashCardUseCase: AddFlashCardUseCase = provideAddFlashcardUseCase(filePath: finalPath)
        guard let argument : String = CommandLine.arguments.dropFirst().first else {
            return
        }
        switch (argument) {
        case "-r", "random":
            try await startRandomMode(flashCardsUseCase: flashCardUseCase)
        case "-a", "add":
            try await startAdditionMode(addFlashCardUseCase: addFlashCardUseCase)
        default:
            return
        }
    }
}

func startRandomMode(flashCardsUseCase: FlashcardUseCase) async throws {
    while(true) {
        let card = try await flashCardsUseCase.getRandomFlashcard()
        print(card.name)
        guard let input = readLine() else {
            return
        }
        if (input.isQuitCommand()) {
            return
        }
        print(card.meaning)
        guard let nextInput = readLine() else {
            return
        }
        if (nextInput.isQuitCommand()) {
            return
        }
    }
}

extension String {
    
    func isQuitCommand() -> Bool {
        if(self == "quit" || self == "-q") {
            return true
        } else {
            return false
        }
    }
}

func startAdditionMode(addFlashCardUseCase: AddFlashCardUseCase) async throws {
    while(true) {
        print("Insert name")
        guard let name = readLine() else {
            print("Name cannot be nil, aborting")
            return
        }
        if (name.isQuitCommand()) {
            return
        }
        print("Insert meaning")
        guard let meaning = readLine() else {
            print("Meaning cannot be nil, aborting")
            return
        }
        if (meaning.isQuitCommand()) {
            return
        }
        let flashCard = Flashcard(name: name, meaning: meaning)
        try await addFlashCardUseCase.addFlashCard(flashCard: flashCard)
    }
}
