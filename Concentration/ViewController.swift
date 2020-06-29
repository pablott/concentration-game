//
//  ViewController.swift
//  Concentration
//
//  Created by Pablo Tamayo on 29/06/2020.
//  Copyright © 2020 Pablo Tamayo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var flipCount = 0 {
        didSet {
            flipCountLabel.text = "Flips \(flipCount)"
        }
    }

    @IBOutlet weak var flipCountLabel: UILabel!
    @IBOutlet var cardButtons: [UIButton]!
    
    var emojiChoices: Array<String> = ["🎃", "👻", "🎃", "👻"]
    
    @IBAction func touchCard(_ sender: UIButton) {
        flipCount += 1
        if let cardNumber = cardButtons.index(of: sender) {
            flipCard(withEmoji: emojiChoices[cardNumber], on: sender)
            print("cardNumber = \(cardNumber)")
        }
    }

    
    func flipCard(withEmoji emoji: String, on button: UIButton) {
        print("flip car emoji \(emoji)")
        if button.currentTitle == emoji {
            button.setTitle("", for: UIControl.State.normal)
            button.backgroundColor = #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
        } else {
            button.setTitle(emoji, for: UIControl.State.normal)
            button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        }
    }
}

