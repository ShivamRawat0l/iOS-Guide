//
//  PairGameViewModel.swift
//  Guide
//
//  Created by Shivam Rawat on 07/07/23.
//

import Foundation

class PairGameViewModel : ObservableObject{
    @Published var model = PairGameModel();
    
    var cards : [card] {
        model.cards
    }
    
    var dealt: [card] {
        model.dealtCards
    }
    
    func reset () {
        model.resetDealtCards()
    }
    
    func chooseCard(index : Int) {
        model.chooseCard(id: index)
    }
    
    func deal(card:card) {
        model.deal(card: card);
    }
    
}
