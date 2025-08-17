//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by 이효록 on 8/12/25.
//

import SwiftUI
struct Theme {
    let name: String
    let symbol: Image
    let color: Color
    var emojis: [String]
}

struct EmojiMemoryGameView: View {
//    var viewModel: EmojiMemoryGame
    
    @State var themes: [Theme] = [
        Theme(
            name: "Ghosts",
            symbol: Image(systemName: "figure"),
            color: Color.gray,
            emojis: ["💀","👽","😈","👻","👺","🎃","🤡","👹"]
        ),
        Theme(
            name: "Animals",
            symbol: Image(systemName: "teddybear"),
            color: Color.yellow,
            emojis: ["😾","🙊","🐻","🐿️","🐼","🐻‍❄️","🦁","🐯"]
        ),
        Theme(
            name: "Countries",
            symbol: Image(systemName: "flag"),
            color: Color.purple,
            emojis: ["🇦🇹","🇪🇨","🇯🇵","🇮🇳","🇰🇷","🇺🇸"]
        )
    ]

    @State var selectedThemeIndex = 0
    
    var body: some View {
        VStack{
            Text("Memorize!")
                .font(.title)
            ScrollView{
                cards
            }
            .padding()
            buttons
        }
    }
    
    var cards: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 120))]){
            ForEach(themes[selectedThemeIndex].emojis.indices, id: \.self) { index in
                CardView(content: themes[selectedThemeIndex].emojis[index])
                    .aspectRatio(2/3, contentMode: .fit)
            }
        }
        .foregroundColor(themes[selectedThemeIndex].color)
    }
    
    var buttons: some View{
        HStack{
            ForEach(themes.indices, id: \.self) { index in
                Button(action: {
                    themes[index].emojis.shuffle()
                    print(themes[index].emojis)
                    selectedThemeIndex = index
                }){
                    VStack{
                        Text("\(themes[index].symbol)")
                        Text(" \(themes[index].name)")
                    }
                }
            }
        }
    }
}

struct CardView: View {
    let content: String
    @State var isFaceUp: Bool = false
    
    var body: some View {
        ZStack {
            let base: RoundedRectangle = RoundedRectangle(cornerRadius: 12)
            Group{
                base.fill(.white)
                base.strokeBorder(lineWidth: 3)
                Text(content).font(.largeTitle)
            }
            .opacity(isFaceUp ? 1 : 0)
            base.fill().opacity(isFaceUp ? 0 : 1)
        }
        .onTapGesture {
            isFaceUp.toggle()
        }
    }
}

#Preview {
    EmojiMemoryGameView()
}
