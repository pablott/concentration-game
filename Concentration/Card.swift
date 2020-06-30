//
//  Card.swift
//  Concentration
//
//  Created by Pablo Tamayo on 29/06/2020.
//  Copyright © 2020 Pablo Tamayo. All rights reserved.
//

import Foundation

struct Card {
    var isFaceUp = false
    var isMatched = false
    var hasBeenMismatched = false
    var identifier: Int
    
    static var identifierFactory = 0
    
    static func getUniqueIdentifier() -> Int {
        identifierFactory += 1
        return identifierFactory
    }
    
    init() {
        self.identifier = Card.getUniqueIdentifier()
    }
}
