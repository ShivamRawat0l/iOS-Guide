//
//  ChatScreenModel.swift
//  Guide
//
//  Created by Shivam Rawat on 31/07/23.
//

import Foundation

struct ChatMessage : Identifiable {
    var id : Int ;
    var time : String;
    var message : String;
    var profileImage: String ;
    var isUserMessage : Bool;
}

struct ChatScreenModel {
    var messages = [ChatMessage]() ;
    init() {
        self.messages = [
            ChatMessage(id: 0 ,time: "17:03", message: "As long as it is a payment system with money transactions, it is highly safe...",profileImage: "https://i.pravatar.cc/150?img=3",isUserMessage: false),
            ChatMessage(id: 1, time: "15:03", message: "I think you are quite right.The trial method of credit cards is important for property secuirity",profileImage: "https://i.pravatar.cc/150?img=5",isUserMessage: true),
            ChatMessage(id:2,time: "17:03", message: "OK ... ",profileImage: "https://i.pravatar.cc/150?img=3",isUserMessage: false),
            ChatMessage(id:3,time: "17:03", message: "As long as it is a payment system with money transactions, it is highly safe...",profileImage: "https://i.pravatar.cc/150?img=3",isUserMessage: false),
            ChatMessage(id:4,time: "17:03", message: "Thank you for your reminder, let me learn a lot.",profileImage: "https://i.pravatar.cc/150?img=5",isUserMessage: true)
        ]
    }
}

