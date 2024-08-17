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
    
    public var currentPlayer: Player?
    
    var players: [Player] = [] {
        didSet {
            savePlayers()
        }
    }

    private init() {
        loadPlayers()
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
        players.append(player)
        userDefaultsController.savePlayer(player) // Save the single player
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
