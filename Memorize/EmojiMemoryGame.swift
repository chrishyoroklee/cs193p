//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by 이효록 on 8/14/25.
//

import SwiftUI

class EmojiMemoryGame {
    private static let emojis = ["💀","👽","😈","👻","👺","🎃","🤡","👹"]
    
    private static func createMemorizeGame() -> MemoryGame<String> {
        return MemoryGame(numberOfPairsOfCards: 6){ pairIndex in
            if emojis.indices.contains(pairIndex){
                return emojis[pairIndex]
            } else {
                return "😳"
            }
        }
    }
    
    private var model = createMemorizeGame()
    
    var cards: Array<MemoryGame<String>.Card> {
        return model.cards
    }
    
    //MARK: - Intents
    func choose(_ card: MemoryGame<String>.Card){
        model.choose(card: card)
    }
    
    func shuffle(){
        model.shuffle()
    }
}
