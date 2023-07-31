//
//  ChatScreenViewModel.swift
//  Guide
//
//  Created by Shivam Rawat on 31/07/23.
//

import Foundation

class ChatScreenViewModel : ObservableObject {
    @Published var model = ChatScreenModel();
    
    var messages : [ChatMessage] {
       return self.model.messages
    }
}
