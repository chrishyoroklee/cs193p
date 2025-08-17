//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by 이효록 on 8/14/25.
//

import SwiftUI

class EmojiMemoryGame {
    private static let emojis = ["💀","👽","😈","👻","👺","🎃","🤡","👹"]
    
    private static func createMemorizeGame() -> MemorizeGame<String> {
        return MemorizeGame(numberOfPairsOfCards: 4){ pairIndex in
            if emojis.indices.contains(pairIndex){
                return emojis[pairIndex]
            } else {
                return "😳"
            }
        }
    }
    
    private var model = createMemorizeGame()
    
    var cards: Array<MemorizeGame<String>.Card> {
        return model.cards
    }
    
    //Intent function
    func choose(_ card: MemorizeGame<String>.Card){
        model.choose(card: card)
    }
}
