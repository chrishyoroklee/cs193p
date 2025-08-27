//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by 이효록 on 8/14/25.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    private static let emojis = ["💀","👽","😈","👻","👺","🎃","🤡","👹"]
    var themes: [Theme] = [
        Theme(
            name: "Ghosts",
            symbol: Image(systemName: "figure"),
            color: Color.gray,
            emojis: ["💀","👽","😈","👻","👺","🎃","🤡","👹"],
            numPairs: 10
        ),
        Theme(
            name: "Animals",
            symbol: Image(systemName: "teddybear"),
            color: Color.yellow,
            emojis: ["😾","🙊","🐻","🐿️","🐼","🐻‍❄️","🦁","🐯"],
            numPairs: 10
        ),
        Theme(
            name: "Countries",
            symbol: Image(systemName: "flag"),
            color: Color.purple,
            emojis: ["🇦🇹","🇪🇨","🇯🇵","🇮🇳","🇰🇷","🇺🇸"],
            numPairs: 10
        )
    ]
    
    private static func createMemorizeGame() -> MemoryGame<String> {
        return MemoryGame(numberOfPairsOfCards: 6){ pairIndex in
            if emojis.indices.contains(pairIndex){
                return emojis[pairIndex]
            } else {
                return "😳"
            }
        }
    }
    
    //@Published allows the model to change 
    @Published private var model = createMemorizeGame()
    
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
    
    //MARK: - FIX
    //reset the game - turn all the isFaceUp and isMatched to false
    func reset(){
        model.reset()
    }
}
