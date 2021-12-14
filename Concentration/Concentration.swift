//
//  Concentration.swift
//  Concentration
//
//  Created by Andrei Korikov on 13.12.2021.
//

import Foundation

class Concentration {
    var cards = [Card]()
    var indexOfOneAndOnlyFaceUpCard: Int?
    var score = 0
    var flips = 0
    
    init(numberOfPairsOfCards: Int) {
        refillCards(numberOfCards: numberOfPairsOfCards * 2)
    }
    
    private func refillCards(numberOfCards: Int) {
        cards.removeAll(keepingCapacity: true)
        
        for _ in 0..<(numberOfCards / 2) {
            let card = Card()
            cards += [card, card]
        }
        
        cards.shuffle()
    }
    
    func chooseCard(at index: Int) {
        guard !cards[index].isMatched else { return }
        
        if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
            // check if cards match
            if cards[matchIndex].identifier == cards[index].identifier {
                cards[matchIndex].isMatched = true
                cards[index].isMatched = true
                score += 2
            } else {
                score += (cards[matchIndex].isAlreadySeen ? -1 : 0) + (cards[index].isAlreadySeen ? -1 : 0)
            }
            indexOfOneAndOnlyFaceUpCard = nil
        } else {
            // either no cards or 2 cards are face up
            for flipDownIndex in cards.indices {
                if cards[flipDownIndex].isFaceUp {
                    cards[flipDownIndex].isAlreadySeen = true
                    cards[flipDownIndex].isFaceUp = false
                }
            }
            indexOfOneAndOnlyFaceUpCard = index
        }
        
        cards[index].isFaceUp = true
        flips += 1
    }
    
    func resetState() {
        refillCards(numberOfCards: cards.count)
        indexOfOneAndOnlyFaceUpCard = nil
        score = 0
        flips = 0
    }
}
