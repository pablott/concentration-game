//
//  ViewController.swift
//  Concentration
//
//  Created by Pablo Tamayo on 29/06/2020.
//  Copyright © 2020 Pablo Tamayo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    lazy var game = Concentration(numberOfPairsOfCards: (cardButtons.count + 1) / 2)
    lazy var pickedEmojiTheme = emojiThemePicker()
    
    var emojiThemes: [[String]] = [
        ["🐶", "🐱", "🐭", "🐹", "🐰", "🦊", "🐻", "🐼", "🐨", "🐯", "🦁", "🐮"],
        ["🍏", "🍎", "🍐", "🍊", "🍋", "🍌", "🍉", "🍇", "🍓", "🍈", "🍒", "🍑"],
        ["😀", "😃", "😄", "😁", "😆", "😅", "😂", "🤣", "☺️", "😊", "😇", "🙂"],
        // Add new themes below:
        ["🚗", "🚕", "🚙", "🚌", "🚎", "🏎", "🚓", "🚑", "🚒", "🚐", "🚚", "🚛"]
    ]
    var emoji = [Int:String]()

    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var flipCountLabel: UILabel!
    @IBOutlet var cardButtons: [UIButton]!
        
    @IBAction func touchStartButton(_ sender: UIButton) {
        game.startGame()
        updateViewFromModel()
        emoji = [:]
        pickedEmojiTheme = emojiThemePicker()
    }
    @IBAction func touchCard(_ sender: UIButton) {
        if let cardNumber = cardButtons.firstIndex(of: sender), !game.cards[cardNumber].isMatched {
            game.addToFlipCounter()
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        }
    }
    
    func updateViewFromModel() {
        // Update counter/score
        scoreLabel.text = "Score: \(game.score)"
        flipCountLabel.text = "Flips: \(game.flipCount)"
        
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

    func emojiThemePicker() -> [String] {
        var selectedTheme: [String]?
        if emojiThemes.count > 0 {
            let randomIndex = Int(arc4random_uniform(UInt32(emojiThemes.count)))
            selectedTheme = emojiThemes[randomIndex]
        }
        return selectedTheme ?? Array(repeating: "?", count: cardButtons.count)
    }
    
    func emoji(for card: Card) -> String {
        if emoji[card.identifier] == nil, pickedEmojiTheme.count > 0 {
            let randomIndex = Int(arc4random_uniform(UInt32(pickedEmojiTheme.count)))
            emoji[card.identifier] = pickedEmojiTheme.remove(at: randomIndex)
        }
        return emoji[card.identifier] ?? "?"
    }
}

