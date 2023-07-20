//
//  EmojiArtViewModel.swift
//  Guide
//
//  Created by Shivam Rawat on 19/07/23.
//

import Foundation

class EmojiArtViewModel: ObservableObject {
    @Published var model = EmojiArtModel();
    
    var emojis: [String] {
        get {
            model.emojis
        }
    }
    
    var emojisData : [Emoji] {
        get {
            model.emojisData
        }
    }
    
    func addEmoji(name : String , posx : Int , posy: Int){
        model.addEmoji(name: name, posx: posx, posy: posy)
    }
    
    func moveEmoji(id : Int, posx : Int ,posy :Int){
        model.moveEmoji(id: id, posx: posx, posy: posy)
    }
    
}
