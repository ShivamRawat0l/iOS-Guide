//
//  ImageListModel.swift
//  Guide
//
//  Created by Shivam Rawat on 03/08/23.
//

import Foundation
struct ImageList : Identifiable, Codable {
    var id: String;
    var author: String;
    var width: Int;
    var height: Int;
    var url: String;
    var download_url : String ;
}
