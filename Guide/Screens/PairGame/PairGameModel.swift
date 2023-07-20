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
    var isFaceDown: Bool = false;
    var isMatched: Bool = false;
}

struct PairGameModel {
    static var emojis = ["😃","😎","🥳","👾","🧌"]
    var cards = [card]()
    var dealtCards = [card]()
    private var oldCardChoosen = -1;
    private var previousCardChoosen = -1;
    
    init() {
        for i in 0..<PairGameModel.emojis.count {
            dealtCards.append(card(id: 2*i, emoji: PairGameModel.emojis[i]))
            dealtCards.append(card(id: 2*i + 1, emoji: PairGameModel.emojis[i]))
            //cards.append(card(id: 2*i, emoji: PairGameModel.emojis[i]))
            //cards.append(card(id: 2*i + 1, emoji: PairGameModel.emojis[i]))
        }
        shuffleCards()
    }
    
    mutating func chooseCard(id: Int) {
        let index = self.cards.firstIndex { card in
            card.id == id;
        }
        guard let index else {
            return
        }
        if previousCardChoosen > -1 ,
           oldCardChoosen > -1,
           self.cards[previousCardChoosen].emoji == self.cards[oldCardChoosen].emoji {
            self.cards[previousCardChoosen].isMatched = true;
            self.cards[oldCardChoosen].isMatched = true; 
        }
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
    
    mutating func shuffleCards() {
        if previousCardChoosen > 0 {
            self.cards[previousCardChoosen].isFaceDown = true;
        }
        if oldCardChoosen > 0 {
            self.cards[oldCardChoosen].isFaceDown = true;
        }
        self.previousCardChoosen = -1;
        self.oldCardChoosen = -1;
        self.cards.shuffle()
    }
    
    mutating func resetDealtCards () {
        self.dealtCards = []
    }
    mutating func deal (card:card){
        self.cards.append(card)
    }
}
