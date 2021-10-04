//
//  InnerStampStack.swift
//  Zeste
//
//  Created by miori Lee on 2021/10/04.
//

import UIKit

class InnerStampStack: UIStackView {
    
    let circle1 = UIImageView().then {
        $0.image = UIImage(named: "stampOff")
        $0.contentMode = .scaleAspectFit
    }
    let circle2 = UIImageView().then {
        $0.image = UIImage(named: "stampOff")
        $0.contentMode = .scaleAspectFit
    }
    let circle3 = UIImageView().then {
        $0.image = UIImage(named: "stampOff")
        $0.contentMode = .scaleAspectFit
    }
    let circle4 = UIImageView().then {
        $0.image = UIImage(named: "stampOff")
        $0.contentMode = .scaleAspectFit
    }
    let circle5 = UIImageView().then {
        $0.image = UIImage(named: "stampOff")
        $0.contentMode = .scaleAspectFit
    }
    
    var circleArr = [UIImageView()]

    override init(frame : CGRect) {
        super.init(frame: frame)
        initV()
        addSubView()
        //setImgSize()
        _ = [circle1,circle2,circle3,circle4,circle5].map {circleArr.append($0)}
    }
    
    @available(*, unavailable)
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        initV()
        addSubView()
        //setImgSize()
        _ = [circle1,circle2,circle3,circle4,circle5].map {circleArr.append($0)}
    }
    
    private func initV() {
        self.backgroundColor = .none
        self.axis = .horizontal
        self.distribution = .fillEqually
        self.alignment = .fill
        self.spacing = 10
        self.isLayoutMarginsRelativeArrangement = true
        self.layoutMargins = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    }
    
    private func addSubView() {
        _ = [circle1, circle2, circle3, circle4, circle5].map {self.addArrangedSubview($0)}
    }
    
    private func setImgSize() {
        _ = [circle1,circle2,circle3,circle4,circle5].map {
            $0.snp.makeConstraints {
                $0.height.equalTo(self.circle1.snp.width)
            }
        }
    }

}
