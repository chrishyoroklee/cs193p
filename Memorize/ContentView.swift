//
//  ContentView.swift
//  Memorize
//
//  Created by 이효록 on 8/12/25.
//

import SwiftUI

struct ContentView: View {
    //0 array ghosts, 1th array animals, 2nd array countries
    @State var emojis: [[String]] = [["💀","👽","😈","👻","👺","🎃","🤡","👹"],["😾","🦅","🙊","🐻","🐿️","🐼","🐻‍❄️","🦁","🐯"],["🇦🇹","🇪🇨","🇯🇵","🇮🇳","🇰🇷","🇺🇸"]]
    @State var emojiIndex = 0
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
            ForEach(emojis[emojiIndex].indices, id: \.self) { index in
                CardView(content: emojis[emojiIndex][index])
                    .aspectRatio(2/3, contentMode: .fit)
            }
        }
        .foregroundColor(color)
    }
    
    var buttons: some View{
        HStack{
            Button(action: ghostTheme){
                    Text("👻Ghost")
                }
            Button(action: animalTheme){
                    Text("🐻‍❄️Animals")
                }
            Button(action: countryTheme){
                    Text("🇺🇸Countries")
                }
        }
    }
    func ghostTheme(){
        emojiIndex = 0
        color = Color.gray
    }
    func animalTheme(){
        emojiIndex = 1
        color = Color.yellow
    }
    func countryTheme(){
        emojiIndex = 2
        color = Color.black
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
