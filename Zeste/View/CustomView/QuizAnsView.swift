//
//  QuizAnsView.swift
//  Zeste
//
//  Created by miori Lee on 2021/12/03.
//

import UIKit

import UIKit

class QuizAnsView: UIView {
    
    let ansLabel = UILabel().then {
        //$0.font = UIFont.Pretendard(.semiBold, size: 14)
        $0.font = UIFont.systemFont(ofSize: 14)
        $0.numberOfLines = 0
        $0.textColor = .black
    }
    
    let checkImgView = UIImageView().then {
        $0.image = UIImage(named: "solve_check")
    }
    
    override init(frame : CGRect) {
        super.init(frame: frame)
        initView()
        initV()
        bindConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        initView()
        initV()
        bindConstraints()
    }
    
    private func initView() {
        self.backgroundColor = .quizAnsBG
        self.layer.borderWidth = 1.0
        self.layer.borderColor = UIColor.quizAnsBG.cgColor
        self.layer.cornerRadius = 10
    }
    
    private func initV(){
        _ = [ansLabel, checkImgView].map {self.addSubview($0)}
        checkImgView.isHidden = true
    }
    
    private func bindConstraints(){
        ansLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-70)
        }
        
        checkImgView.snp.makeConstraints {
            $0.centerY.equalTo(ansLabel)
            $0.trailing.equalToSuperview().offset(-20)
        }
    }
}

