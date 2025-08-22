//
//  MemoryGame.swift
//  Memorize
//
//  Created by 이효록 on 8/14/25.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable {
    private(set) var cards: Array<Card>
    
    init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent){
        cards = []
        // add numberOfPairsOfCards x 2 cards
        for pairIndex in 0..<max(2, numberOfPairsOfCards) {
            let content = cardContentFactory(pairIndex)
            cards.append(Card(content: content, id: "\(pairIndex+1)a"))
            cards.append(Card(content: content, id: "\(pairIndex+1)b"))
        }
    }
    
    var indexOfTheOneAndOnlyFaceUpCard: Int? {
        get { cards.indices.filter { index in cards[index].isFaceUp }.only }
        set { cards.indices.forEach { cards[$0].isFaceUp = (newValue == $0) } }
    }
    
    //firstIndex does a for loop and returns the found card index - firstIndex is of type Int?
    mutating func choose(card: Card){
        if let chosenIndex = cards.firstIndex(where: { $0.id == card.id }) {
            if !cards[chosenIndex].isFaceUp && !cards[chosenIndex].isMatched {
                if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
                    if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                        cards[chosenIndex].isMatched = true
                        cards[potentialMatchIndex].isMatched = true
                    }
                } else {
                    indexOfTheOneAndOnlyFaceUpCard = chosenIndex
                }
                cards[chosenIndex].isFaceUp = true
            }
        }
    }
    
    mutating func shuffle(){
        cards.shuffle()
//        print(cards)
    }
    
    //set all isFaceUp and isMatched to false
    mutating func reset(){
        if cards.count > 0{
            let endIndex = cards.count-1
            for index in 0...endIndex {
                if cards[index].isFaceUp || cards[index].isMatched {
                    cards[index].isFaceUp = false
                    cards[index].isMatched = false
                }
            }
        }
    }
    
    struct Card: Equatable, Identifiable, CustomDebugStringConvertible {
        var debugDescription: String {
            return "\(id): \(content) \(isFaceUp ? "up" : "down")\(isMatched ? "matched" : "")"
        }
        
        var isFaceUp = false
        var isMatched = false
        let content: CardContent
        
        var id: String
    }
    
}

extension Array {
    var only: Element? {
        count == 1 ? first : nil
    }
}
