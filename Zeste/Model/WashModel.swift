//
//  WashModel.swift
//  Zeste
//
//  Created by miori Lee on 2021/11/11.
//

import Foundation

enum WashSequence: String, CaseIterable {
    case tree1 = "베이킹 소다 한 스푼에 미지근한 물을 넣어 섞어준 후 뚜껑을 닫고 1시간 기다린다."
    case tree2 = "식초 한 방울에 미지근한 물을 넣어 섞어준 후 뚜껑을 닫고 30분 기다린다."
    case tree3 = "구연산 한 스푼에 미지근한 물을 넣어 섞어준 후 뚜껑을 열은 채로 1시간 기다린다."
    case tree4 = "달걀 껍데기를 부숴 미지근한 물을 텀블러에 넣고 흔든다."
    case tree5 = "텀블러를 뒤집어서 바람이 잘 통하는 곳에 건조시킨다."
}

struct WashSeq: Encodable {
    let desText: [String] = WashSequence.allCases.map { $0.rawValue }

}
