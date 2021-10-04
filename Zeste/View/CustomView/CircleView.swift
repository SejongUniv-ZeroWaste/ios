//
//  CircleView.swift
//  Zeste
//
//  Created by miori Lee on 2021/10/03.
//

import UIKit
import SnapKit
import Then

class CircleView: UIView {

    override init(frame : CGRect) {
        super.init(frame: frame)
        initV()
        setSize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        initV()
        setSize()
    }
    
    private func initV() {
        self.backgroundColor = .zestGreen
        self.layer.borderWidth = 1.0
        self.layer.borderColor = UIColor.zestGreen.cgColor
        self.layer.cornerRadius = self.frame.size.height / 2
        // 뷰의 경계에 맞춰준다
        self.clipsToBounds = true
        self.layer.masksToBounds = false
    }
    
    private func setSize() {
        self.snp.makeConstraints {
            $0.width.equalTo(self.snp.height)
        }
    }
    
}
