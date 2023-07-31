//
//  EmojiArtView.swift
//  Guide
//
//  Created by Shivam Rawat on 19/07/23.
//

import SwiftUI

struct EmojiArtView: View {
    @ObservedObject var emojiArtViewModel = EmojiArtViewModel();
    var body: some View {
        VStack {
            ZStack {
                Color.yellow
                ForEach(emojiArtViewModel.emojisData){emoji in
                    Text(emoji.name)
                        .font(.system(size: 30))
                        .position(x:CGFloat(emoji.posx), y:CGFloat(emoji.posy))
                        .onDrag({ NSItemProvider(object: emoji.name as NSString) })
                }
                
            }.onDrop(of: [.plainText,.url,.image], isTargeted: nil, perform: { providers,location in
            
        providers.first?.loadObject(
                    ofClass: URL.self, completionHandler: { object,error in
                        guard object == nil else  {
                            return;
                        }
                    })
             
                    providers.first?.loadObject(ofClass: String.self, completionHandler: { object, error in
                        if let object {
                            emojiArtViewModel.addEmoji(name: object, posx: Int(location.x) , posy: Int(location.y))
                        }
                    })
                
             
                return false
            })
            
            HStack{
                ForEach(emojiArtViewModel.emojis, id: \.self) { emoji in
                    Text(emoji)
                        .font(.system(size: 30))
                        .onDrag {NSItemProvider(object: emoji as NSString) }
                }
            }
        }
    }
}


