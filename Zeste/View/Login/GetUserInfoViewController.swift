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
    
    let inTF = UITextField().then {
        $0.placeholder = "닉네임을 입력해주세요"
        $0.borderStyle = .roundedRect
        $0.keyboardType = .default
        $0.autocorrectionType = .no
        $0.textContentType = .name
        $0.autocapitalizationType = .none
        $0.font = UIFont.systemFont(ofSize: 15)
    }
    
    let nextBtn = UIButton().then {
        $0.setTitle("다음으로", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.backgroundColor = .zestGreen
        $0.layer.cornerRadius = 8
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 15)
    }
    
    var cnt : Int = 0
    var userNick : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        dismissKeyboardWhenTappedAround()
        // Do any additional setup after loading the view.
        initV()
        bindConstraints()
        
        nextBtn.addTarget(self, action: #selector(nextTapped(_:)), for: .touchUpInside)
    }
    

}

extension GetUserInfoViewController {
    private func initV() {
        _ = [pageControl,topicLabel,desLabel,inTF,nextBtn].map {self.view.addSubview($0)}
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
        inTF.snp.makeConstraints {
            $0.top.equalTo(desLabel.snp.bottom).offset(16)
            $0.leading.equalTo(pageControl)
            $0.trailing.equalToSuperview().offset(-16)
        }
        nextBtn.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.leadingMargin.equalTo(16)
            $0.bottom.equalToSuperview().offset(-30)
            $0.height.equalTo(nextBtn.snp.width).multipliedBy(0.1399)
        }
    }
}

extension GetUserInfoViewController {
    @objc func nextTapped(_ sender : UIButton) {
        if self.cnt == 0 {
            finishNick()
        } else if self.cnt == 1 {
            finishPhone()
        } else if self.cnt == 2 {
            self.changeRootViewController(BaseTabBarController())
            cnt = 0
        }
    }
    
    private func finishNick() {
        userNick = inTF.text!
        pageControl.currentPage = 1
        topicLabel.text = "휴대폰 번호"
        desLabel.text = "\(LabelText().joindes2)"
        inTF.text = ""
        inTF.placeholder = "휴대폰 번호를 입력해주세요 (010-0000-0000)"
        inTF.textContentType = .telephoneNumber
        inTF.keyboardType = .numberPad
        cnt += 1
    }
    
    private func finishPhone() {
        pageControl.currentPage = 2
        topicLabel.text = "🎉 환영합니다"
        desLabel.text = "\(userNick)님,\n\(LabelText().welcomeT)"
        inTF.isHidden = true
        cnt += 1
    }
}
