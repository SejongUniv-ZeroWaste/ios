//
//  HowToWashViewController.swift
//  Zeste
//
//  Created by miori Lee on 2021/10/25.
//

import UIKit

class HowToWashViewController: BaseViewController {
    
    lazy var mycv = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()).then {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        $0.backgroundColor = .none
        $0.contentInset = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
        $0.showsHorizontalScrollIndicator = false
        $0.collectionViewLayout = layout
        $0.isPagingEnabled = true
        $0.register(WashCollectionViewCell.self, forCellWithReuseIdentifier: WashCollectionViewCell.registerID)
        
    }
    
    lazy var myPageControl = UIPageControl().then {
        $0.numberOfPages = 5
        $0.currentPage = 0
        $0.currentPageIndicatorTintColor = .zestGreen
        $0.pageIndicatorTintColor = .darkGray
        $0.backgroundColor = .none
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        
        initVC()
        bindConstraints()
        
        mycv.delegate = self
        mycv.dataSource = self

    }
    
}

extension HowToWashViewController {

    private func initVC() {
        _ = [mycv, myPageControl].map {self.view.addSubview($0)}
    }
    private func bindConstraints() {
        mycv.snp.makeConstraints {
            $0.centerY.centerX.equalToSuperview()
            $0.leadingMargin.equalToSuperview().offset(20)
            $0.height.equalToSuperview().multipliedBy(0.7)
        }
        
        myPageControl.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-20)
        }
    }
}

extension HowToWashViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = UICollectionViewCell()
        guard let detailCell = collectionView.dequeueReusableCell(withReuseIdentifier: WashCollectionViewCell.registerID, for: indexPath) as? WashCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        detailCell.myLabel.text = "텀블러 세척법 \(indexPath.row + 1)"
        detailCell.imgView.image = UIImage(named: "tree\(indexPath.row + 1)")
        
        detailCell.desLabel.text = WashSeq().desText[indexPath.row]
        cell = detailCell
        return cell
    }
    
    
    // MARK: - collection view 와 page control 연결
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offSet = scrollView.contentOffset.x
        let width = scrollView.frame.width
        let horizontalCenter = width / 2
        
        myPageControl.currentPage = Int(offSet + horizontalCenter) / Int(width)
    }
}

extension HowToWashViewController : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var size = CGSize()
      
        let c_width = collectionView.frame.width
        let c_height = collectionView.frame.height
        let c_size = CGSize(width: c_width, height: c_height)
            size = c_size
        return size
        
    }
}
