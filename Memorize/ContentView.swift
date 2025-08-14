//
//  ContentView.swift
//  Memorize
//
//  Created by 이효록 on 8/12/25.
//

import SwiftUI
struct Theme {
    let name: String
    let symbol: String
    let color: Color
    var emojis: [String]
}
struct ContentView: View {
    @State var themes: [Theme] = [
        Theme(
            name: "Ghosts",
            symbol: "👻",
            color: Color.gray,
            emojis: ["💀","👽","😈","👻","👺","🎃","🤡","👹"]
        ),
        Theme(
            name: "Animals",
            symbol: "🐻‍❄️",
            color: Color.yellow,
            emojis: ["😾","🙊","🐻","🐿️","🐼","🐻‍❄️","🦁","🐯"]
        ),
        Theme(
            name: "Countries",
            symbol: "🇺🇸",
            color: Color.black,
            emojis: ["🇦🇹","🇪🇨","🇯🇵","🇮🇳","🇰🇷","🇺🇸"]
        )
    ]

    @State var selectedThemeIndex = 0
    @State var color = Color.pink
    
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
        .foregroundColor(color)
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
    @State var isFaceUp: Bool = true
    
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
    ContentView()
}
