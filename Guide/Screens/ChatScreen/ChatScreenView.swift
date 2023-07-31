//
//  ChatScreenView.swift
//  Guide
//
//  Created by Shivam Rawat on 31/07/23.
//

import SwiftUI

struct Header: View {
    var body : some View {
        HStack{
            Image(systemName: "arrow.backward")
            Spacer()
            Circle()
                .frame(width: 6,height: 6)
                .foregroundColor(.green)
            Text("Harrison")
                .font(.system(size: 18))
            Spacer()
            Image(systemName: "plus")
        }
        .padding(.horizontal, 30)
    }
}

private struct ChatBubbleView : View {
    var message: ChatMessage ;
    init(message: ChatMessage) {
        self.message = message;
    }
    
    @State var selected : Bool = false;
    
    var backgroundColor : Color {
        selected ? Color.blue : Color.gray;
    }
    
    var profileImage : some View {
        AsyncImage(url: URL(string: message.profileImage))
            .scaledToFit()
            .frame(width: 50,height: 50)
            .clipShape(Circle())
    }
    
    var textBubble : some View  {
        Text(message.message)
            .foregroundStyle(.white)
            .padding(.vertical,15)
            .padding(.horizontal,24)
            .frame(minWidth: 0,maxWidth: 230,alignment:.leading)
        
    }
    
    var sendMessage : some View {
        HStack (alignment: .top){
            Spacer()
            textBubble
                .background(.green)
                .clipShape(MessageBubble()
                    .scale(x: -1))
            VStack{
                profileImage
                Text(message.time)
                    .font(.system(size: 12))
            }
        }
    }
    
    var recievedMessage : some View {
        HStack (alignment: .top){
            VStack{
                profileImage
                Text(message.time)
                    .font(.system(size: 12))
            }
            VStack{
                textBubble
                    .background(backgroundColor)
                    .clipShape(MessageBubble())
                if selected {
                    HStack {
                        Image(systemName: "face.dashed.fill")
                            .foregroundColor(.orange)
                        Image(systemName: "paperplane.fill")
                            .foregroundColor(.blue)
                        Image(systemName: "ellipsis")
                            .foregroundColor(.teal)
                    }
                    .padding()
                    .background(.gray)
                    .clipShape(RoundedRectangle(cornerRadius: 24))
                }
            }
        }
        .gesture(LongPressGesture().onEnded({ _ in
            selected = !selected;
        }))
    }
    
    var body : some View {
        if message.isUserMessage {
            sendMessage
        } else {
            recievedMessage
        }
    }
}

private struct Chat: View {
    @StateObject var viewModel = ChatScreenViewModel();
    var body : some View {
        ScrollView {
            LazyVStack(alignment: .leading){
                ForEach(viewModel.messages){message in
                    ChatBubbleView(message: message)
                }
            }
        }
    }
}

struct Input: View {
    @State var input : String = "";
    var body : some View {
        HStack{
            Image(systemName: "plus")
                .foregroundColor(.white)
                .padding()
                .background(.blue)
                .clipShape(Circle())
            TextField("Type your message...", text: $input )
            Image(systemName: "face.smiling")
            
        }
        .background(.gray)
    }
}

struct ChatScreenView: View {
    var body: some View {
        VStack{
            Header()
            Spacer()
            Chat()
                .padding(.vertical,20)
                .padding(.horizontal,10)
            Input()
            
        }
    }
}

struct ChatScreenView_Preview : PreviewProvider {
    
    static var previews : some View {
        ChatScreenView()
    }
}
