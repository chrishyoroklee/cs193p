//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by 이효록 on 8/12/25.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var viewModel: EmojiMemoryGame

    @State var selectedThemeIndex = 0
    
    var body: some View {
        VStack{
            Text("Memorize!")
                .font(.title)
            ScrollView{
                cards
                    .animation(.default, value: viewModel.cards)
            }
            .padding()
            buttons
        }
    }
    
    var cards: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 85), spacing: 0)], spacing: 0){
            ForEach(viewModel.cards) { card in
                CardView(card)
                    .aspectRatio(2/3, contentMode: .fit)
                    .padding(4)
                    .onTapGesture {
                        viewModel.choose(card)
                    }
            }
        }
        .foregroundColor(Color.orange)
    }
    
    var buttons: some View{
        HStack{
//            ForEach(themes.indices, id: \.self) { index in
//                Button(action: {
//                    themes[index].emojis.shuffle()
//                    print(themes[index].emojis)
//                    selectedThemeIndex = index
//                }){
//                    VStack{
//                        Text("\(themes[index].symbol)")
//                        Text(" \(themes[index].name)")
//                    }
//                }
//            }
            Button("Shuffle"){
                viewModel.shuffle()
            }
        }
    }
}

struct CardView: View {
    var card: MemoryGame<String>.Card
    
    init(_ card: MemoryGame<String>.Card) {
        self.card = card
    }
    
    var body: some View {
        ZStack {
            let base: RoundedRectangle = RoundedRectangle(cornerRadius: 12)
            Group{
                base.fill(.white)
                base.strokeBorder(lineWidth: 3)
                Text(card.content)
                    .font(.system(size: 80))
                    .minimumScaleFactor(0.01)
                    .aspectRatio(1, contentMode: .fit)
            }
            .opacity(card.isFaceUp ? 1 : 0)
            base.fill().opacity(card.isFaceUp ? 0 : 1)
        }
        .opacity(card.isFaceUp || !card.isMatched ? 1 : 0)

    }
}

#Preview {
    EmojiMemoryGameView(viewModel: EmojiMemoryGame())
}
