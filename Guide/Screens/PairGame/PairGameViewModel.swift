//
//  PairGameViewModel.swift
//  Guide
//
//  Created by Shivam Rawat on 07/07/23.
//

import Foundation

class PairGameViewModel : ObservableObject {
    @Published var model = PairGameModel();
    
    var cards : [card] {
        model.cards
    }
    
    func chooseCard(index : Int) {
        model.chooseCard(index: index)
    }
    
}
