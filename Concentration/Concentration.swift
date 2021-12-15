//
//  Concentration.swift
//  Concentration
//
//  Created by Andrei Korikov on 13.12.2021.
//

import Foundation

class Concentration {
    private(set) var cards = [Card]()
    
    private var indexOfOneAndOnlyFaceUpCard: Int? {
        get {
            var foundIndex: Int?
            for index in cards.indices {
                guard cards[index].isFaceUp else { continue }
                if foundIndex == nil {
                    foundIndex = index
                } else {
                    return nil
                }
            }
            return foundIndex
        }
         
        set {
            for index in cards.indices {
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    
    private(set) var score = 0
    private(set) var flips = 0
    private var startGameTime = Date()
    
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
            }
            score += calculateScoreForCards(index1: matchIndex, index2: index)
            cards[index].isFaceUp = true
        } else {
            // either no cards or 2 cards are face up
            for flipDownIndex in cards.indices {
                if cards[flipDownIndex].isFaceUp {
                    cards[flipDownIndex].isAlreadySeen = true
                }
            }
            indexOfOneAndOnlyFaceUpCard = index
        }
        
        flips += 1
    }
    
    /// Calculate score for match situation and penalty if cards already was seen.
    /// Takes into account bonus time from start of the game when all scores and penalties are calculating at highest rates.
    private func calculateScoreForCards(index1: Int, index2: Int) -> Int {
        var bonusTimeMatchScore = 2
        var bonusTimePenaltyScore = -1
        
        let bonusTimeLeft = Int(30.0 - Date().timeIntervalSince(startGameTime))
        if bonusTimeLeft > 0  {
            bonusTimeMatchScore *= bonusTimeLeft
            bonusTimePenaltyScore *= bonusTimeLeft
        }
        
        if cards[index1].identifier == cards[index2].identifier {
            return bonusTimeMatchScore
        } else {
            return (cards[index1].isAlreadySeen ? bonusTimePenaltyScore : 0) + (cards[index2].isAlreadySeen ? bonusTimePenaltyScore : 0)
        }
    }
    
    func resetState() {
        refillCards(numberOfCards: cards.count)
        indexOfOneAndOnlyFaceUpCard = nil
        score = 0
        flips = 0
        startGameTime = Date()
    }
}
