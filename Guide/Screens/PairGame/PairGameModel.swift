//
//  PairGameModel.swift
//  Guide
//
//  Created by Shivam Rawat on 07/07/23.
//

import Foundation

struct card : Identifiable{
    var id : Int;
    var emoji : String;
    var isFaceDown: Bool;
}

struct PairGameModel {
    static var emojis = ["😃","😎","🥳","👾","🧌"]
    var cards = [card]()
    private var oldCardChoosen = -1;
    private var previousCardChoosen = -1;
    
    init() {
        for i in 0..<PairGameModel.emojis.count {
            cards.append(card(id: 2*i, emoji: PairGameModel.emojis[i], isFaceDown: true))
            cards.append(card(id: 2*i + 1, emoji: PairGameModel.emojis[i], isFaceDown: true))
        }
    }
    
    mutating func chooseCard(index: Int){
        if self.cards[index].isFaceDown == false {
            return ;
        }
        if previousCardChoosen == -1{
            self.previousCardChoosen = index;
            self.cards[index].isFaceDown = false;
        }
        else {
            if self.oldCardChoosen == -1 {
                self.oldCardChoosen = self.previousCardChoosen;
                self.previousCardChoosen = index;
                self.cards[index].isFaceDown = false;
            } else {
                print("\(self.previousCardChoosen)  \(self.oldCardChoosen)")
                self.cards[oldCardChoosen].isFaceDown = true;
                self.cards[index].isFaceDown = false;
                self.oldCardChoosen = self.previousCardChoosen;
                self.previousCardChoosen = index;
            }
        }
    }
    
    func getCards() -> [card] {
        return self.cards;
    }
}
