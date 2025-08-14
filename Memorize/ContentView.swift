//
//  ContentView.swift
//  Memorize
//
//  Created by 이효록 on 8/12/25.
//

import SwiftUI

struct ContentView: View {
    let ghosts: [String] = ["💀","👽","😈","👻","👺","🎃","🤡","👹"]
    let animals: [String] = ["😾","🦅","🙊","🐻","🐿️","🐼","🐻‍❄️","🦁","🐯"]
    let countries: [String] = ["🇦🇹","🇪🇨","🇯🇵","🇮🇳","🇰🇷","🇺🇸"]
    var theme: [String] = []
    var body: some View {
        VStack{
            Text("Memorize!")
                .font(.title)
            ScrollView{
                cards
            }
            .padding()
            
            HStack{
                Button(action: ghostTheme){
                    Text("Ghost")
                }
                Button(action: ghostTheme){
                    Text("Animals")
                }
                Button(action: ghostTheme){
                    Text("Countries")
                }
            }
        }
    }
    
    var cards: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 120))]){
            ForEach(animals.indices, id: \.self) { index in
                CardView(content: animals[index])
                    .aspectRatio(2/3, contentMode: .fit)
            }
        }
        .foregroundColor(.pink)
    }
    func ghostTheme(){
        
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

struct ButtonView: View{
    @State var theme: String = "Ghosts"
    
    var body: some View{
        HStack{
            Button(action: themeChooser){
                Text("Ghosts")
            }
        }
    }
    
    func themeChooser(){
        
    }
}

#Preview {
    ContentView()
}
