//
//  Card.swift
//  Concentration
//
//  Created by Andrei Korikov on 13.12.2021.
//

import Foundation

struct Card {
    var isFaceUp = false
    var isMatched = false
    var isAlreadySeen = false
    var identifier: Int
    
    private static var identifierFactory = 0
    
    private static func getUniqueIdentifier() -> Int {
        identifierFactory += 1
        return identifierFactory
    }
    
    init() {
        self.identifier = Self.getUniqueIdentifier()
    }
}
