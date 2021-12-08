//
//  CoffeeSizeViewController.swift
//  Zeste
//
//  Created by miori Lee on 2021/12/03.
//

import UIKit

class CoffeeSizeViewController: BaseViewController {

    lazy var myCV = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()).then {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 10
        $0.backgroundColor = .none
        $0.contentInset = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
        $0.showsHorizontalScrollIndicator = false
        $0.collectionViewLayout = layout
        $0.isPagingEnabled = true
        $0.register(SizeCollectionViewCell.self, forCellWithReuseIdentifier: SizeCollectionViewCell.registerID)
        
    }
    
    var sizeList : [CafeData] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "음료용량"
        // Do any additional setup after loading the view.
        initVC()
        bindConstraints()
        setCV()
        
        CoffeeSizeDataManager().getSizeList(viewController: self)
    }
}

extension CoffeeSizeViewController {
    private func initVC(){
        _ = [myCV].map {self.view.addSubview($0)}
    }
    private func bindConstraints() {
        myCV.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.leadingMargin.equalTo(10)
            $0.top.equalToSuperview().offset(20)
            $0.bottom.equalToSuperview()
        }
    }
    private func setCV() {
        myCV.delegate = self
        myCV.dataSource = self
    }
}

extension CoffeeSizeViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sizeList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = UICollectionViewCell()
        guard let detailCell = collectionView.dequeueReusableCell(withReuseIdentifier: SizeCollectionViewCell.registerID, for: indexPath) as? SizeCollectionViewCell else {
            return UICollectionViewCell()
        }
        detailCell.cafeName.text = sizeList[indexPath.row].caffee
        detailCell.hotSize.text = "\(sizeList[indexPath.row].hot) oz"
        detailCell.icedSize.text = "\(sizeList[indexPath.row].iced) oz"
        cell = detailCell
        return cell
    }
}

extension CoffeeSizeViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var size = CGSize()
      
        let c_width = collectionView.frame.width / 2 - 10
        let c_height = c_width * 0.55
        let c_size = CGSize(width: c_width, height: c_height)
            size = c_size
        return size
        
    }
}

extension CoffeeSizeViewController {
    func didSuccess(result : CoffeeSizeModel) {
        print(result.results)
        myCV.reloadData()
        sizeList = result.results
    }
    func failedToRequest(message : String) {
        self.presentAlert(title: message)
    }
}
