//
//  StampRoundView.swift
//  Zeste
//
//  Created by miori Lee on 2021/10/04.
//

import UIKit


class StampRoundView: UIView {
    
    override init(frame : CGRect) {
        super.init(frame: frame)
        initV()

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        initV()
 
    }
    
    private func initV() {
        self.backgroundColor = .white
        self.layer.borderWidth = 3.0
        self.layer.borderColor = UIColor.zestGreen.cgColor
        self.layer.cornerRadius = 20
        // 뷰의 경계에 맞춰준다
        self.clipsToBounds = true
        self.layer.masksToBounds = false
    }
    
 

}
