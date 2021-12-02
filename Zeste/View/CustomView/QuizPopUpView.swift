//
//  QuizPopUpView.swift
//  Zeste
//
//  Created by miori Lee on 2021/12/03.
//

import UIKit

class QuizPopUpView: UIView {

    let logoIV = UIImageView().then {
        $0.image = UIImage(named: "zeste")
        $0.contentMode = .scaleAspectFit
        $0.layer.masksToBounds = true
       // $0.layer.borderColor = UIColor.mainYellow.cgColor
       // $0.layer.borderWidth = 1.0
        $0.backgroundColor = .none
    }
    
    let label1 = UILabel().then {
        $0.textColor = .black
        //$0.font = UIFont.Pretendard(.bold, size: 16)
        $0.font = UIFont.boldSystemFont(ofSize: 16)
    }
    let label2 = UILabel().then {
        $0.textColor = .black
        $0.numberOfLines = 0
        $0.textAlignment = .center
        //$0.font = UIFont.Pretendard(.regular, size: 14)
        $0.font = UIFont.systemFont(ofSize: 14)
    }
    let checkBtn = UIButton().then {
        $0.setTitle("확인했습니다", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        //$0.titleLabel?.font = UIFont.Pretendard(.bold, size: 14)
        $0.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        $0.backgroundColor = .zestGreen
        $0.layer.cornerRadius = 8
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
    
    override func layoutSubviews() {
        super.layoutSubviews()
        print(logoIV.frame.height)
        logoIV.layer.cornerRadius = (logoIV.frame.height) / 2
    }
    
    private func initView() {
        self.backgroundColor = .white
        self.layer.borderWidth = 1.0
        self.layer.borderColor = UIColor.white.cgColor
        self.layer.cornerRadius = 12
        self.layer.masksToBounds = false
    }
    
    private func initV() {
        _ = [logoIV, label1, label2, checkBtn].map {self.addSubview($0)}

    }
    
    private func bindConstraints() {
        logoIV.snp.makeConstraints {
            $0.top.equalToSuperview().offset(40)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(60)
        }
     
        label1.snp.makeConstraints {
            $0.top.equalTo(logoIV.snp.bottom).offset(21)
            $0.centerX.equalToSuperview()
        }
        label2.snp.makeConstraints {
            $0.top.equalTo(label1.snp.bottom).offset(13)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(checkBtn).multipliedBy(0.766)
        }
        checkBtn.snp.makeConstraints {
            $0.top.equalTo(label2.snp.bottom).offset(21.5)
            $0.bottom.equalToSuperview().offset(-21.5)
            $0.centerX.equalToSuperview()
            //$0.width.equalToSuperview().multipliedBy(0.8)
            $0.leadingMargin.equalTo(24.5)
            $0.height.equalTo(checkBtn.snp.width).multipliedBy(0.265)
        }
    }
    
}

