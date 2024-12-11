//
//  File.swift
//  ABC_Vision
//
//  Created by Wylan L Neely on 8/1/24.
//

import Foundation

struct Player: Codable {
    
    
    let nickname: String
    var wordStacks: [WordStack]
    var playerImageNameString: String?
   // let id:  UUID
    
    init(nickname: String, wordStacks: [WordStack], playerImageNameString: String? = nil) {
          self.nickname = nickname
          self.wordStacks = wordStacks
          self.playerImageNameString = playerImageNameString
      }
    
}

