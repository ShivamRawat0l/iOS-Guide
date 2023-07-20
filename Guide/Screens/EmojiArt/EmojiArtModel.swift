//
//  EmojiArtModel.swift
//  Guide
//
//  Created by Shivam Rawat on 19/07/23.
//

import Foundation

struct Emoji :Identifiable {
    var name : String;
    var posx : Int;
    var posy : Int ;
    var id : Int ;
}


struct EmojiArtModel {
    var emojis = ["👩‍💼","😋","😛","😜","🤪","😝","🤑"]
    var emojisData :  [Emoji] = [Emoji]();
    var uniqueIdentifier = 0;
    
    init(){
            addEmoji(name: emojis[0], posx: 0, posy: 0)
    }
        
    mutating func addEmoji(name : String , posx : Int , posy: Int){
        self.emojisData.append(Emoji(name:name,posx: posx, posy: posy, id: uniqueIdentifier))
        uniqueIdentifier += 1;
    }
    
    mutating func moveEmoji(id : Int, posx : Int ,posy :Int){
        let index = emojisData.firstIndex { emoji in
            emoji.id == id
        }
        guard let index else {
            return
        }
        self.emojisData[index].posx = posx;
        self.emojisData[index].posy = posy;
    }
    
}
