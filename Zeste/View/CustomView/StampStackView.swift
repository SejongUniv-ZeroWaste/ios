//
//  StampStackView.swift
//  Zeste
//
//  Created by miori Lee on 2021/10/04.
//

import UIKit

class StampStackView: UIStackView {
    
    let stampRound1 = StampRoundView().then {
        $0.backgroundColor = .zestGreen
    }
    let stampRound2 = StampRoundView().then {
        $0.backgroundColor = .zestGreen
    }
    
    override init(frame : CGRect) {
        super.init(frame: frame)
        initV()
        addSubView()
    }
    
    @available(*, unavailable)
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        initV()
        addSubView()
    }
    
    private func initV() {
        self.axis = .vertical
        self.distribution = .fillEqually
        self.alignment = .fill
        self.spacing = 6
    }
    
    private func addSubView() {
        self.addArrangedSubview(stampRound1)
        self.addArrangedSubview(stampRound2)
    }
 
}
