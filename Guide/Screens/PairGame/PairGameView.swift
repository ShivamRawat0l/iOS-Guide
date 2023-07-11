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
    
    var body : some View {
        VStack {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))],alignment: .leading) {
                ForEach(viewModel.cards) { emoji in
                    Card(emoji: emoji.emoji, isFaceDown: emoji.isFaceDown)
                        .aspectRatio(2/3, contentMode: .fit)
                        .onTapGesture {
                            viewModel.chooseCard(index: emoji.id)
                        }
                }
            }
        }
}

    struct Card : View {
        var emoji : String ;
        var isFaceDown :Bool = false;
        
        var body : some View{
            if isFaceDown {
                ZStack {
                    Text(emoji)
                        .font(.system(size: 30))
                    RoundedRectangle(cornerRadius: 20).fill().foregroundColor(.red)
                }
                .padding()
            }
            else  {
                ZStack {
                    Text(emoji)
                        .font(.system(size: 30))
                    RoundedRectangle(cornerRadius: 20).strokeBorder()
                }
                .padding()
            }
        }
    }
}
