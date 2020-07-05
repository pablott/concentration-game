//
//  ViewController.swift
//  Concentration
//
//  Created by Pablo Tamayo on 29/06/2020.
//  Copyright © 2020 Pablo Tamayo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    private lazy var game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
    lazy var pickedEmojiTheme = emojiThemePicker()
    
    var numberOfPairsOfCards: Int {
        return (cardButtons.count + 1) / 2
    }
    
    private let emojiThemes = [
        "🐶🐱🐭🐹🐰🦊🐻🐼🐨🐯🦁🐮",
        "🍏🍎🍐🍊🍋🍌🍉🍇🍓🍈🍒🍑",
        "😀😃😄😁😆😅😂🤣☺️😊😇🙂",
        // Add new themes below:
        "🚗🚕🚙🚌🚎🏎🚓🚑🚒🚐🚚🚛"
    ]
    private var emoji = [Card:String]()

    @IBOutlet private weak var scoreLabel: UILabel!
    @IBOutlet private weak var flipCountLabel: UILabel! {
        didSet {
            updateFlipCountLabel()
        }
    }
    @IBOutlet private var cardButtons: [UIButton]!
        
    @IBAction private func touchStartButton(_ sender: UIButton) {
        game.startGame()
        updateViewFromModel()
        emoji = [:]
        pickedEmojiTheme = emojiThemePicker()
    }
    @IBAction private func touchCard(_ sender: UIButton) {
        if let cardNumber = cardButtons.firstIndex(of: sender), !game.cards[cardNumber].isMatched {
            game.addToFlipCounter()
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        }
    }
    
    private func updateFlipCountLabel() {
        let attributes: [NSAttributedString.Key: Any] = [
            .strokeWidth : 5.0,
            .strokeColor : UIColor(named: "orange")!
        ]
        let attributedString = NSAttributedString(string: "Flips: \(game.flipCount)", attributes: attributes)
        flipCountLabel.attributedText = attributedString
    }
    
    private func updateViewFromModel() {
        // Update counter/score
        scoreLabel.text = "Score: \(game.score)"
        updateFlipCountLabel()
        
        // Update cards
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: UIControl.State.normal)
                button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            } else {
                button.setTitle("", for: UIControl.State.normal)
                button.backgroundColor = card.isMatched ?  #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0) : #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
            }
        }
    }

    private func emojiThemePicker() -> String {
        var selectedTheme: String?
        if emojiThemes.count > 0 {
            selectedTheme = emojiThemes[emojiThemes.count.arc4random]
        }
        return selectedTheme ?? Array(repeating: "?", count: cardButtons.count).joined()
    }
    
    private func emoji(for card: Card) -> String {
        if emoji[card] == nil, pickedEmojiTheme.count > 0 {
            let randomStringIndex = pickedEmojiTheme.index(pickedEmojiTheme.startIndex, offsetBy: pickedEmojiTheme.count.arc4random)
            emoji[card] = String(pickedEmojiTheme.remove(at: randomStringIndex))
        }
        return emoji[card] ?? "?"
    }
}

extension Int {
    var arc4random: Int {
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        } else if self < 0 {
            return -Int(arc4random_uniform(UInt32(abs(self))))
        } else {
            return 0
        }
    }
}
