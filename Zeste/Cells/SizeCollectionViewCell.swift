//
//  SizeCollectionViewCell.swift
//  Zeste
//
//  Created by miori Lee on 2021/12/03.
//

import UIKit

class SizeCollectionViewCell: UICollectionViewCell {
    
    static let registerID = "\(SizeCollectionViewCell.self)"
    
    let cafeName = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        $0.textColor = .black
        $0.text = "카페명"
    }
    
    let stackView = UIStackView().then {
        $0.axis = .horizontal
        $0.backgroundColor = .none
        $0.alignment = .fill
        $0.distribution = .equalSpacing
    }
    
//    let icedLabel = UILabel().then {
//        $0.font = UIFont.systemFont(ofSize: 14, weight: .bold)
//        $0.textColor = .blue
//        $0.text = "ICED"
//    }
    
    let icedLabel = UIImageView().then {
        $0.image = UIImage(named: "smallSize")
        $0.contentMode = .scaleAspectFit
    }
    
    let icedSize = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        $0.textColor = .black
        //$0.text = "ICED"
    }
    
//    let hotLabel = UILabel().then {
//        $0.font = UIFont.systemFont(ofSize: 14, weight: .bold)
//        $0.textColor = .red
//        $0.text = "HOT"
//    }
    
    let hotLabel = UIImageView().then {
        $0.image = UIImage(named: "bigSize")
    }
    
    let hotSize = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        $0.textColor = .black
        //$0.text = "ICED"
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .none
        initV()
        bindConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.backgroundColor = .none
        initV()
        bindConstraints()
    }
    
    private func initV() {
        self.layer.borderWidth = 1.0
        self.layer.cornerRadius = 10
        self.layer.borderColor = UIColor.zestGreen.cgColor
        self.backgroundColor = .white
        _ = [cafeName, stackView,icedSize,hotSize].map {self.addSubview($0)}
        _ = [icedLabel, hotLabel].map {self.stackView.addArrangedSubview($0)}
    }
    
    private func bindConstraints() {
        cafeName.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(13)
        }
        
        stackView.snp.makeConstraints {
            $0.top.equalTo(cafeName.snp.bottom).offset(10)
            $0.centerX.equalToSuperview()
            //$0.leadingMargin.equalTo(16)
            $0.width.equalToSuperview().multipliedBy(0.6)
        }
        icedSize.snp.makeConstraints {
            $0.centerX.equalTo(icedLabel)
            $0.top.equalTo(icedLabel.snp.bottom).offset(10)
        }
        hotSize.snp.makeConstraints {
            $0.centerX.equalTo(hotLabel)
            $0.top.equalTo(hotLabel.snp.bottom).offset(10)
        }
    }

}

