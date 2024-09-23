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
        userDefaultsController.savePlayer(newPlayer) // Save the single player
    }

    func removePlayer(withNickname nickname: String) {
        players.removeAll { $0.nickname == nickname }
        savePlayers() // Save the updated players list
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
    
    // Update a specific word's completion status for a player
    func markWordComplete(forPlayer playerNickname: String, inStack stackName: String, wordName: String) {
        if let playerIndex = players.firstIndex(where: { $0.nickname == playerNickname }),
           let stackIndex = players[playerIndex].wordStacks.firstIndex(where: { $0.name == stackName }),
           let wordIndex = players[playerIndex].wordStacks[stackIndex].words.firstIndex(where: { $0.name == wordName }) {
            
            players[playerIndex].wordStacks[stackIndex].words[wordIndex].isComplete = true
            
            savePlayers() // Persist the updated players
        }
    }
}
