//
//  FlickerStore.swift
//  Guide
//
//  Created by Shivam Rawat on 05/09/23.
//

import Foundation

struct FlickerClass : Codable{
    struct Photo : Codable {
        var id : String;
        var owner : String;
        var title : String ;
        var secret : String ;
        var server : String ;
    }
    struct Photos : Codable{
        var page : Int;
        var pages :Int;
        var perpage : Int;
        var total : Int ;
        var photo : [Photo];
    }
    var photos : Photos;
}

struct AppState {
    var images : [(String, String)];
    var imageURL : String?;
    var imageID : String?;
}

enum Action {
    case fetch(String) ;
}

struct Reducer {
    func update (_ state : inout AppState , _ action : Action) async {
        switch action {
        case .fetch(let searchText) :
            let data : FlickerClass? = await NetworkService.fetchJSON(url: FlickerAPI.searchAPI(searchText: searchText), type: FlickerClass.self)
            guard let data else {
                print("Error Occurred while parsing images")
                return
            }
            state.images = data.photos.photo.map { photo in
                (photo.title, FlickerAPI.createPhotoURL(server: photo.server, id: photo.id, secret: photo.secret))
            }
        }
    }
}

 class FlickerStore  : ObservableObject{
    var reducer : Reducer ;
    @Published  var state : AppState;
    
    init (reducer : Reducer = Reducer() , state : AppState = AppState(images: []) ){
        self.reducer = reducer;
        self.state = state;
    }
    
    func dispatch(_ action : Action ) async {
        await  self.reducer.update(&self.state, action)
    }
}
