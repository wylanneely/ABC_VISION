//
//  PlayerController.swift
//  ABC_Vision
//
//  Created by Wylan L Neely on 8/1/24.
//

import Foundation

class GameController {
    
    static var shared = GameController()
  
    private let userDefaultsController = PlayerUserDefaultsController()
    private var wordStackController = WordStackController()
    
    public var currentPlayer: Player?
    
    var players: [Player] = [] {
        didSet {
            savePlayers()
        }
    }

    var wordStacks: [WordStack] = []
    
    private init() {
        loadPlayers()
        loadWordStacks()
    }
    private func loadWordStacks() {
            wordStacks = [wordStackController.planetStack, wordStackController.animalStack, wordStackController.foodsStack]
    }
    
    private func savePlayers() {
        userDefaultsController.savePlayers(players)
    }
       
    private func loadPlayers() {
        if let savedPlayers = userDefaultsController.getPlayers() {
            players = savedPlayers
        } else {
            players = []
        }
    }
       
    func addPlayer(_ player: Player) {
        var newPlayer = Player(nickname: player.nickname, wordStacks: wordStacks)
        players.append(newPlayer)
        userDefaultsController.savePlayer(newPlayer)
    }

    func removePlayer(withNickname nickname: String) {
        players.removeAll { $0.nickname == nickname }
        savePlayers()
    }
    
    func getWords(forPlayer playerNickname: String, inStack stackName: String) -> [Word]? {
          guard let player = players.first(where: { $0.nickname == playerNickname }) else {
              return nil
          }
          
          // Find the word stack by name within the player's word stacks
          if let wordStack = player.wordStacks.first(where: { $0.name == stackName }) {
              return wordStack.words
          } else {
              return nil
          }
      }
}

//MARK: - Test later
struct PlayerUserDefaultsController {
    private let userDefaults = UserDefaults.standard
    private let playerKey = "players"

    func savePlayers(_ players: [Player]) {
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(players)
            userDefaults.set(data, forKey: playerKey)
        } catch {
            print("Failed to encode players: \(error)")
        }
    }
    
    func savePlayer(_ player: Player) {
        var players = getPlayers() ?? []
        players.append(player)
        savePlayers(players)
    }

    func getPlayers() -> [Player]? {
        guard let data = userDefaults.data(forKey: playerKey) else {
            return nil
        }

        do {
            let decoder = JSONDecoder()
            let players = try decoder.decode([Player].self, from: data)
            return players
        } catch {
            print("Failed to decode players: \(error)")
            return nil
        }
    }

    func deletePlayers() {
        userDefaults.removeObject(forKey: playerKey)
    }

}

extension GameController {
    
    func markWordComplete(forPlayer playerNickname: String, inStack stackName: String, wordName: String) {
        if let playerIndex = players.firstIndex(where: { $0.nickname == playerNickname }),
           let stackIndex = players[playerIndex].wordStacks.firstIndex(where: { $0.name == stackName }),  // for capital/lowecased letters
           let wordIndex = players[playerIndex].wordStacks[stackIndex].words.firstIndex(where: { $0.name.lowercased() == wordName.lowercased() }) {
            
            players[playerIndex].wordStacks[stackIndex].words[wordIndex].isComplete = true
            
            savePlayers() // Persist the updated players
        }
    }
    
    func areAllWordsComplete(forPlayer player: Player, inStack stackName: String) -> Bool? {
        // Find the specific word stack within the player's word stacks
        if let wordStack = player.wordStacks.first(where: { $0.name == stackName }) {
            // Check if all words in the word stack are complete
            for word in wordStack.words {
                if !word.isComplete {
                    return false // If any word is incomplete, return false
                }
            }
            return true // All words are complete
        } else {
            return nil // Return nil if the word stack is not found
        }
    }
    
    func areAllStacksComplete(forPlayer player: Player) -> Bool {
        // Find the specific word stack within the player's word stacks
        for stack in player.wordStacks {
            // Check if all words in the word stack are complete
            for word in stack.words {
                if !word.isComplete {
                    return false // If any word is incomplete, return false
                }
            }
            return true // All words are complete
        }
        return false
    }
    
    func isWordComplete(forPlayer playerNickname: String, inStack stackName: String, wordName: String) -> Bool? {
           guard let player = players.first(where: { $0.nickname == playerNickname }),
                 let wordStack = player.wordStacks.first(where: { $0.name == stackName }),
                 let word = wordStack.words.first(where: { $0.name == wordName }) else {
               return nil // Return nil if player, stack, or word is not found
           }
           return word.isComplete // Return the completion status of the word
       }
}
