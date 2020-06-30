//
//  Concentration.swift
//  Concentration
//
//  Created by Pablo Tamayo on 29/06/2020.
//  Copyright © 2020 Pablo Tamayo. All rights reserved.
//

import Foundation

class Concentration {
    var cards = [Card]()
    var flipCount = 0
    var score = 0
    var numberOfPairsOfCards: Int?
    var indexOfOneAndOnlyFaceUpCard: Int?
    
    func chooseCard(at index: Int) {
        if !cards[index].isMatched {
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                // One card face up, and touched on a different card
                // Check if cards match and marked pair as matched
                if cards[matchIndex].identifier == cards[index].identifier {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                    score += 2
                } else {
                    // Mismatch
                    var penalty = 0
                    penalty = cards[matchIndex].hasBeenMismatched ? -1 : 0
                    penalty += cards[index].hasBeenMismatched ? -1 : 0
                    print("i:\(matchIndex) \t \(cards[matchIndex].hasBeenMismatched)")
                    print("i:\(index) \t \(cards[index].hasBeenMismatched)")
                    print("Penalty: \(penalty)")
                    score += penalty
                    cards[matchIndex].hasBeenMismatched = true
                    cards[index].hasBeenMismatched = true
                }
                // Two cards up at this point, so nilify indexOfOneAndOnlyFaceUpCard
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = nil
            } else {
                // Either no cards, two cards are face up, or touched same card
                // Flip cards down
                for flipDownIndex in cards.indices {
                    cards[flipDownIndex].isFaceUp = false
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }
    
    func addToFlipCounter() {
        flipCount += 1
    }
    
    func startGame() {
        flipCount = 0
        score = 0
        indexOfOneAndOnlyFaceUpCard = nil
        // Reset deck and pairs
        for flipDownIndex in cards.indices {
            cards[flipDownIndex].isFaceUp = false
            cards[flipDownIndex].isMatched = false
        }
        addCards(pairs: numberOfPairsOfCards)
    }
    
    func addCards(pairs: Int?) {
        cards = []
        // Add pairs
        if let pairs = pairs {
            for _ in 0..<pairs {
                let card = Card()
                cards += [card, card]
            }
        }
        
        // Shuffle
        cards.shuffle()
    }
    
    init(numberOfPairsOfCards: Int) {
        self.numberOfPairsOfCards = numberOfPairsOfCards
        addCards(pairs: numberOfPairsOfCards)
    }
}
