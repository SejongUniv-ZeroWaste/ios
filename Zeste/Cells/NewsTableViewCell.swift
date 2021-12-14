//
//  NewsTableViewCell.swift
//  Zeste
//
//  Created by miori Lee on 2021/11/11.
//

import UIKit

class NewsTableViewCell: UITableViewCell {

    static let registerID = "\(NewsTableViewCell.self)"
    
    let newsImg = UIImageView().then {
        $0.image = UIImage(named: "newsExample")
    }
    
    let newsLabel = UILabel().then {
        $0.numberOfLines = 0
        $0.font = UIFont.boldSystemFont(ofSize: 16)
        $0.textColor = .black
    }
    let tagLabel = UILabel().then {
        $0.numberOfLines = 0
        $0.font = UIFont.systemFont(ofSize: 13)
        $0.textColor = .black
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    //MARK: - required init, override init 있어야 테이블뷰에 표시됨
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.backgroundColor = .white
      
        _ = [newsImg, newsLabel,tagLabel].map {self.addSubview($0)}
  
        bindConstraints()
        
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .white
        
        _ = [newsImg, newsLabel,tagLabel].map {self.addSubview($0)}

        bindConstraints()
    }

    private func bindConstraints() {
        newsImg.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(8)
            $0.centerY.equalToSuperview()
            $0.top.equalToSuperview().offset(10)
            $0.bottom.equalToSuperview().offset(-10)
            $0.width.equalToSuperview().multipliedBy(0.3)
            $0.height.equalTo(newsImg.snp.width).multipliedBy(0.9)
        }
        newsLabel.snp.makeConstraints {
            $0.top.equalTo(newsImg).offset(5)
            $0.trailing.equalToSuperview().offset(-20)
            $0.leading.equalTo(newsImg.snp.trailing).offset(15)
        }
        tagLabel.snp.makeConstraints {
            $0.bottom.equalTo(newsImg).offset(-5)
            $0.trailing.equalToSuperview().offset(-30)
            $0.leading.equalTo(newsLabel)
        }
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}


