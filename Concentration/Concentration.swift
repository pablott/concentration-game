//
//  Concentration.swift
//  Concentration
//
//  Created by Pablo Tamayo on 29/06/2020.
//  Copyright © 2020 Pablo Tamayo. All rights reserved.
//

import Foundation

class Concentration {
    private(set) var cards = [Card]()
    var flipCount = 0
    var score = 0
    var numberOfPairsOfCards: Int?
    private var indexOfOneAndOnlyFaceUpCard: Int? {
        get {
            var foundIndex: Int?
            for index in cards.indices {
                if cards[index].isFaceUp {
                    if foundIndex == nil {
                        foundIndex = index
                    } else {
                        // Two cards up at this point, so nilify indexOfOneAndOnlyFaceUpCard
                        return nil
                    }
                }
            }
            return foundIndex
        }
        set {
            // Either no cards, two cards are face up
            // Flip cards down
            for index in cards.indices {
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    
    func chooseCard(at index: Int) {
        assert(cards.indices.contains(index), "Concentration.chooseCard(at: \(index)): chosen index not in the cards")
        if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
            // One card face up, and touched on a different card
            // Check if cards match and marked pair as matched
            if cards[matchIndex] == cards[index] {
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
            cards[index].isFaceUp = true
        } else {
            indexOfOneAndOnlyFaceUpCard = index
        }
    }
    
    func addToFlipCounter() {
        flipCount += 1
    }
    
    func startGame() {
        flipCount = 0
        score = 0
//        indexOfOneAndOnlyFaceUpCard = nil
        // Reset deck and pairs
        for flipDownIndex in cards.indices {
            cards[flipDownIndex].isFaceUp = false
            cards[flipDownIndex].isMatched = false
        }
        addCards(pairs: numberOfPairsOfCards)
    }
    
    private func addCards(pairs: Int?) {
        cards = []
        // Add pairs
        if let pairs = pairs {
            for _ in 0..<pairs {
                let card = Card()
                cards += [card, card]
            }
        }
        
        // Shuffle
//        cards.shuffle()
    }
    
    init(numberOfPairsOfCards: Int) {
        assert(numberOfPairsOfCards > 0, "Concentration.init(\(numberOfPairsOfCards)): you must have at least one paircards ")
        self.numberOfPairsOfCards = numberOfPairsOfCards
        addCards(pairs: numberOfPairsOfCards)
    }
}
