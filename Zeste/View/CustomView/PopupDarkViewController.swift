//
//  PopupDarkViewController.swift
//  Zeste
//
//  Created by miori Lee on 2021/12/03.
//

import UIKit

class PopupDarkViewController: UIViewController {

    lazy var popupView = UIView()
    var canTouch : Bool = true

    override func viewDidLoad() {
        super.viewDidLoad()
        //그냥 알파넣으면 다 투명해짐
        self.view.backgroundColor = .black.withAlphaComponent(0.8)
        
        
        initVC()
        
        bindConstraints()

        
        if canTouch {
            let gesture = UITapGestureRecognizer(target: self, action: #selector(self.viewTapped(_:)))
            self.view.addGestureRecognizer(gesture)
        }
    }
    
    
}

extension PopupDarkViewController {
    private func initVC(){
        self.view.addSubview(popupView)
    }
    private func bindConstraints(){

        popupView.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(0.653)
        }
       
    }
    @objc func viewTapped(_ sender:UITapGestureRecognizer) {
        self.dismiss(animated: false, completion: nil)
    }
}
