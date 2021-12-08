//
//  CoffeeSizeDataManager.swift
//  Zeste
//
//  Created by miori Lee on 2021/12/03.
//

import Foundation
import Alamofire

class CoffeeSizeDataManager {
    func getSizeList(viewController: CoffeeSizeViewController) {
        let url = "\(Constant.Git)/size.json"
        AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil)
            .validate()
            .responseDecodable(of: CoffeeSizeModel.self) { response in
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
