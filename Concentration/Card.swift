//
//  Card.swift
//  Concentration
//
//  Created by Pablo Tamayo on 29/06/2020.
//  Copyright © 2020 Pablo Tamayo. All rights reserved.
//

import Foundation

struct Card: Hashable {
    
    //MARK: Protocol
    
    var hashValue: Int { return identifier }
    
    static func ==(lhs: Card, rhs: Card) -> Bool {
        return lhs.identifier == rhs.identifier
    }
    
    var isFaceUp = false
    var isMatched = false
    var hasBeenMismatched = false
    private var identifier: Int
    
    private static var identifierFactory = 0
    
    private static func getUniqueIdentifier() -> Int {
        identifierFactory += 1
        return identifierFactory
    }
    
    init() {
        self.identifier = Card.getUniqueIdentifier()
    }
}
