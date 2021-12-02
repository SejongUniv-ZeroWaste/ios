//
//  QuizModel.swift
//  Zeste
//
//  Created by miori Lee on 2021/12/03.
//

struct QuizModel: Decodable {
    var results: [ArrData]
}

struct ArrData: Decodable {
    var quizId : Int
    var title : String
    var a1 : String
    var a2 : String
    var a3 : String
    var a4 : String
    var ans : Int
}
