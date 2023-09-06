//
//  ImageSearchModel.swift
//  Guide
//
//  Created by Shivam Rawat on 31/08/23.
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
