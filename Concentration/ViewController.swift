//
//  ViewController.swift
//  Concentration
//
//  Created by Andrei Korikov on 05.12.2021.
//

import UIKit

class ViewController: UIViewController {
    lazy var game = Concentration(numberOfPairsOfCards: (cardButtons.count + 1) / 2)
    
    var flipCount = 0 {
        didSet {
            flipCountLabel.text = "Flips: \(flipCount)"
        }
    }
    
    let themes: [Theme] = {
        var themes = [Theme]()
        
        themes.append(Theme(
            name: "Halloween",
            emojis: ["🦇", "😱", "🙀", "😈", "👻", "🎃", "🍭", "🍬"]))
        themes.append(Theme(
            name: "Winter",
            cardBackColorAssetName: "WinterCardBack",
            cardForeColorAssetName: "WinterCardFore",
            otherElementsColorAssetName: "WinterElements",
            emojis: ["🥶", "❄️", "⛷", "☃️", "🌨", "🧣", "⛸", "🎅🏻"]))
        themes.append(Theme(
            name: "Sport",
            cardBackColorAssetName: "SportCardBack",
            cardForeColorAssetName: "SportCardFore",
            otherElementsColorAssetName: "SportElements",
            emojis: ["⚽️", "🎳", "🥊", "🏓", "🥏", "🥋", "🥌", "⛳️"]))
        
        return themes
    }()
    
    var emoji = [Int: String]()
    
    var currentTheme: Theme! {
        didSet {
            flipCountLabel.textColor = UIColor(named: currentTheme.otherElementsColorAssetName)
            scoreLabel.textColor = UIColor(named: currentTheme.otherElementsColorAssetName)
            newGameBtn.setTitleColor(UIColor(named: currentTheme.otherElementsColorAssetName), for: .normal)
            
            for cardButton in cardButtons {
                cardButton.backgroundColor = UIColor(named: currentTheme.cardBackColorAssetName)
            }
            
            emoji.removeAll(keepingCapacity: true)
        }
    }
    
    @IBOutlet var cardButtons: [UIButton]!
    @IBOutlet weak var flipCountLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var newGameBtn: UIButton!
    
    override func viewDidLoad() {
        setRandomTheme()
    }
    
    @IBAction func touchCard(_ sender: UIButton) {
        flipCount += 1
        if let cardNumber = cardButtons.firstIndex(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        } else {
            print("There is no such card in Cards array.")
        }
    }
    
    @IBAction func touchNewGameBtn(_ sender: UIButton) {
        game.resetState()
        setRandomTheme()
        updateViewFromModel()
    }
    
    func setRandomTheme() {
        currentTheme = themes.randomElement()
    }
    
    func updateViewFromModel() {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: .normal)
                button.backgroundColor = UIColor(named: currentTheme.cardForeColorAssetName)
            } else {
                button.setTitle("", for: .normal)
                button.backgroundColor = card.isMatched ? .clear : UIColor(named: currentTheme.cardBackColorAssetName)
            }
        }
    }
    
    func emoji(for card: Card) -> String {
        if emoji[card.identifier] == nil, currentTheme.emojis.count > 0 {
            let randomIndex = Int.random(in: 0..<currentTheme.emojis.count)
            emoji[card.identifier] = currentTheme.emojis.remove(at: randomIndex)
        }
        
        return emoji[card.identifier, default: "?"]
    }
}

