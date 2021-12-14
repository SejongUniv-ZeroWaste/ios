//
//  NewsDataModel.swift
//  Zeste
//
//  Created by miori Lee on 2021/12/13.
//

struct NewsDataModel: Decodable {
    var results: [NewsData]
}

struct NewsData: Decodable {
    var nTitle : String
    var tag : String
    var link : String
}

