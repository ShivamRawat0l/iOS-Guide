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
    @State var selected : Bool = false;
    
    var backgroundColor : Color {
        selected ? Color.blue : Color("chat-default");
    }
    
    var profileImage : some View {
        AsyncImage(url: URL(string: message.profileImage))
            .scaledToFit()
            .frame(width: 50,height: 50)
            .clipShape(Circle())
    }
    
    var textBubble : some View  {
        Text(message.message)
            .foregroundStyle(selected ? .white : .black)
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
    
    var messageOptions : some View {
        HStack {
            Image(systemName: "face.dashed.fill")
                .foregroundColor(.orange)
            Image(systemName: "paperplane.fill")
                .foregroundColor(.blue)
            Image(systemName: "ellipsis")
                .foregroundColor(.teal)
        }
        .padding()
        .background(Color("chat-default"))
        .clipShape(RoundedRectangle(cornerRadius: 24))
    }
    
    var recievedMessage : some View {
        HStack (alignment: .top){
            VStack{
                profileImage
                Text(message.time)
                    .font(.system(size: 12))
            }
            VStack(alignment:.trailing){
                textBubble
                    .background(backgroundColor)
                    .clipShape(MessageBubble())
                    .shadow(radius: selected ?  6: 0)
                if selected {
                    messageOptions
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
    
    var typing : some View {
        HStack (alignment: .top){
            VStack{
                AsyncImage(url: URL(string:"https://i.pravatar.cc/150?img=3"))
                    .scaledToFit()
                    .frame(width: 50,height: 50)
                    .clipShape(Circle())
                
            }
            HStack {
                Circle()
                    .foregroundStyle(.blue)
                    .frame(width: 10)
                    .opacity(1)
                Circle()
                    .foregroundStyle(.blue)
                    .frame(width: 10)
                    .opacity(0.7)
                Circle()
                    .foregroundStyle(.blue)
                    .frame(width: 10)
                    .opacity(0.3)
            }
            .padding()
            .background(Color("chat-default"))
            .clipShape(MessageBubble())
        }
    }
    
    var body : some View {
        ScrollView {
            LazyVStack(alignment: .leading){
                ForEach(viewModel.messages){message in
                    ChatBubbleView(message: message)
                }
                typing
            }
        }
    }
}

private struct Input: View {
    @State var input : String = "";
    var body : some View {
        HStack{
            Image(systemName: "plus")
                .font(.system(size: 14))
                .foregroundColor(.white)
                .padding(6)
                .background(Gradient(colors: [Color(red: 0.0, green: 1.0, blue: 1.0),Color(red: 0.0, green: 0.2, blue: 0.7)]))
                .clipShape(Circle())
            TextField("Type your message...", text: $input )
            Image(systemName: "face.smiling")
        }
        // ASK: Why do we need to do multiple padding
        .padding(.vertical, 10)
        .padding(.horizontal,8)
        .background(Color("chat-default"))
        .clipShape(RoundedRectangle(cornerRadius: 25))
        .padding()
    }
}

struct ChatScreenView: View {
    var body: some View {
        VStack{
            Header()
            Chat()
                .padding(.top,20)
                .padding(.horizontal,10)
            Input()
        }
    }
}
