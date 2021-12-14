//
//  NewsDataManager.swift
//  Zeste
//
//  Created by miori Lee on 2021/12/13.
//

import Foundation
import Alamofire

class NewsDataManager {
    func getNewsList(viewController: NewsViewController) {
        let url = "\(Constant.Git)/news.json"
        AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil)
            .validate()
            .responseDecodable(of: NewsDataModel.self) { response in
                switch response.result {
                case .success(let response):
                    viewController.didSuccess(result: response)
                case .failure(let error):
                    print(error.localizedDescription)
                    viewController.failedToRequest(message: "서버와의 연결이 원활하지 않습니다")
                }
            }
    }
}
