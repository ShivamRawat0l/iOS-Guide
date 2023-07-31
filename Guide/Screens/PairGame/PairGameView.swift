//
//  PairGameView.swift
//  Guide
//
//  Created by Shivam Rawat on 07/07/23.
//

import Foundation
import SwiftUI

struct PairGameView : View {
    @ObservedObject var viewModel = PairGameViewModel();
    @Namespace private var dealCardsNamespace;
    @State var cardDealt  = false;
   
    func deal(card: card){
        viewModel.deal(card: card);
    }
    
    func cardDealAnimation(index: Double) -> Animation {
        return Animation.linear(duration: 0.1).delay(index * 0.1);
    }
    
    func zIndex(of :card ) -> Double {
        return -Double(viewModel.cards.firstIndex(where: { $0.id == of.id }) ?? 0)
                }
    
    var body : some View {
        ScrollView{
                ZStack {
                    VStack {
                        LazyVGrid(
                            columns: [GridItem(.adaptive(minimum: 100))],
                            alignment: .leading,
                            spacing: 0
                        ) {
                            ForEach(viewModel.cards) {   emoji in
                                Card(
                                    emoji: emoji.emoji,
                                    isFaceDown: emoji.isFaceDown,
                                    isMatched: emoji.isMatched
                                )
                                .matchedGeometryEffect(id: emoji.id, in: dealCardsNamespace)
                                .aspectRatio(2/3, contentMode: .fit)
                                .onTapGesture {
                                    withAnimation {
                                        viewModel.chooseCard(index: emoji.id)
                                    }
                                }
                                .frame(width: 120)
                            }
                        }
                    
                    }
                }
                ZStack (alignment: .bottom) {
                    ForEach(viewModel.dealt) {  emoji in
                        Card(
                            emoji: emoji.emoji,
                            isFaceDown: emoji.isFaceDown,
                            isMatched: emoji.isMatched
                        )
                        .zIndex(zIndex(of: emoji))
                        .matchedGeometryEffect(id: emoji.id, in: dealCardsNamespace)
                        .aspectRatio(2/3, contentMode: .fit)
                        .frame(width: 120)
                    }
                }
                .onTapGesture {
                    for index in viewModel.dealt.indices  {
                        withAnimation(cardDealAnimation(index:Double(index))){
                            deal(card: viewModel.dealt[index])
                        }
                    }
            }
          Buttons()
        }
    }
    
    struct Buttons : View {
        var body : some View {
            HStack{
                Button {
                  //  viewModel.reset()
                } label: {
                    Text("Restart")
                }
                Button {
                    withAnimation(.easeInOut){
                    }
                } label: {
                    Text("Shuffle")
                }
            }
        }
    }
    
    struct Card : View {
        var emoji : String ;
        var isFaceDown :Bool = true;
        var isMatched: Bool = false;
        
         var rotation : Double {
            get {
                isFaceDown ? 0 : 180
            }
        };
        
        var body : some View{
            ZStack {
                if isFaceDown {
                    RoundedRectangle(cornerRadius: 20).fill().foregroundColor(.red)
                }  else {
                Text(emoji)
                    .font(.system(size: 30))
                    RoundedRectangle(cornerRadius: 20).strokeBorder()
                }
            }
            .animation(.snappy.delay(0.35/2), value: isFaceDown)
            .rotation3DEffect(
                Angle.degrees(rotation),
                axis: (x: 0.0, y: 1.0, z: 0.0)
            )
            .padding()
            .opacity(isMatched ? 0: 1)
        }
    }
}
