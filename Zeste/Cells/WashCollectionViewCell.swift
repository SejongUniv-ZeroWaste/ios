//
//  WashCollectionViewCell.swift
//  Zeste
//
//  Created by miori Lee on 2021/10/25.
//

import UIKit

class WashCollectionViewCell: UICollectionViewCell {
    
    static let registerID = "\(WashCollectionViewCell.self)"
    
    let imgView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
    }
    
    let myLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        $0.textColor = .black
    }
    
    let desLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        $0.numberOfLines = 0
        $0.textColor = .black
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .none
        _ = [imgView,myLabel,desLabel].map {self.addSubview($0)}
        bindConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.backgroundColor = .none
        _ = [imgView,myLabel,desLabel].map {self.addSubview($0)}
        bindConstraints()
    }
    
    private func bindConstraints() {
        
        imgView.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(0.7)
            
        }
        
        myLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview().offset(10)
        }
        
        desLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(imgView.snp.bottom).offset(10)
            $0.width.equalToSuperview()
        }
    }

}
