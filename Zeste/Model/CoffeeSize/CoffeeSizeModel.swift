//
//  CoffeeSizeModel.swift
//  Zeste
//
//  Created by miori Lee on 2021/12/03.
//

struct CoffeeSizeModel: Decodable {
    var results: [CafeData]
}

struct CafeData: Decodable {
    var caffee : String
    var iced : Int
    var hot : Int
}

