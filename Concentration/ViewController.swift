//
//  ViewController.swift
//  Concentration
//
//  Created by Andrei Korikov on 05.12.2021.
//

import UIKit

class ViewController: UIViewController {
    lazy var game = Concentration(numberOfPairsOfCards: (cardButtons.count + 1) / 2)
    lazy var themeManager = ThemeManager.main
    
    var emoji = [Int: String]()
    var emojiPool = [String]()
    
    var currentTheme: Theme! {
        didSet {
            flipCountLabel.textColor = UIColor(named: currentTheme.otherElementsColorAssetName)
            scoreLabel.textColor = UIColor(named: currentTheme.otherElementsColorAssetName)
            newGameBtn.setTitleColor(UIColor(named: currentTheme.otherElementsColorAssetName), for: .normal)
            view.backgroundColor = UIColor(named: currentTheme.backgroundColorAssetName)
            
            for cardButton in cardButtons {
                cardButton.backgroundColor = UIColor(named: currentTheme.cardBackColorAssetName)
            }
            
            emoji.removeAll(keepingCapacity: true)
            emojiPool = currentTheme.emojis
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
        currentTheme = themeManager.getRandomTheme()
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
        
        flipCountLabel.text = "Flips: \(game.flips)"
        scoreLabel.text = "Score: \(game.score)"
    }
    
    func emoji(for card: Card) -> String {
        if emoji[card.identifier] == nil, emojiPool.count > 0 {
            let randomIndex = Int.random(in: 0 ..< emojiPool.count)
            emoji[card.identifier] = emojiPool.remove(at: randomIndex)
        }
        
        return emoji[card.identifier, default: "?"]
    }
}
