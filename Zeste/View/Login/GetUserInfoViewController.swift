//
//  GetUserInfoViewController.swift
//  Zeste
//
//  Created by miori Lee on 2021/11/30.
//

import UIKit

class GetUserInfoViewController: BaseViewController {

    let pageControl = UIPageControl().then {
        $0.pageIndicatorTintColor = .gray
        $0.currentPageIndicatorTintColor = .zestGreen
        $0.numberOfPages = 3
        $0.currentPage = 0
        $0.backgroundColor = .none
        if #available(iOS 14.0, *) {
            $0.backgroundStyle = .minimal //위아래 줄어들고
            $0.allowsContinuousInteraction = false // 좌우 줄어들고
        }
    }
    
    let topicLabel = UILabel().then {
        $0.font = .boldSystemFont(ofSize: 18)
        $0.textColor = .black
        $0.text = "닉네임"
    }
    
    let desLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 16)
        $0.textColor = .darkGray
        $0.numberOfLines = 0
        $0.text = "\(LabelText().joindes1)"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initV()
        bindConstraints()
    }
    

}

extension GetUserInfoViewController {
    private func initV() {
        _ = [pageControl,topicLabel,desLabel].map {self.view.addSubview($0)}
    }
    private func bindConstraints() {
        pageControl.snp.makeConstraints {
            $0.top.equalToSuperview().offset(32)
            $0.leading.equalToSuperview().offset(16)
        }
        topicLabel.snp.makeConstraints {
            $0.leading.equalTo(pageControl)
            $0.top.equalTo(pageControl.snp.bottom).offset(16)
        }
        desLabel.snp.makeConstraints {
            $0.leading.equalTo(pageControl)
            $0.top.equalTo(topicLabel.snp.bottom).offset(16)
        }
    }
}
