//
//  MyInfoViewController.swift
//  Zeste
//
//  Created by miori Lee on 2021/10/04.
//

import UIKit

class MyInfoViewController: BaseViewController {

    let myCircleView = CircleView()
    
    let clearBtn = UIButton().then {
        //시스템 이미지 크고 두껍게 바꾸기
        let largeConfig = UIImage.SymbolConfiguration(pointSize: 22, weight: .regular, scale: .medium)
        let largeBoldDoc = UIImage(systemName: "clear", withConfiguration: largeConfig)
        $0.setImage(largeBoldDoc, for: .normal)
        $0.tintColor = .black
    }
    
    var radius : CGFloat = CGFloat()
    override func viewDidLayoutSubviews() {
        //2. layoutsubviews
        myCircleView.layer.cornerRadius = myCircleView.frame.height / 2
        radius = myCircleView.frame.height / 2
        moveDown()
        print(self.myCircleView.frame)
        print(self.clearBtn.frame)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //1. viewDidLoad
        initVC()
        bindConstraints()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.4) {
           //3번째 실행
            self.afterBindConstraints()
        }
        
        clearBtn.addTarget(self, action: #selector(clearTapped), for: .touchUpInside)
        
    }

}

extension MyInfoViewController {
    
    private func initVC() {
        //self.view.addSubview(myCircleView)
        _ = [myCircleView].map {self.view.addSubview($0)}
        _ = [clearBtn].map {self.myCircleView.addSubview($0)}
    }
    
    private func bindConstraints() {
        myCircleView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(self.view.snp.top).offset(deviceSize.height/4)
            $0.width.equalTo(self.view.snp.width).multipliedBy(1.57)
        }

    }
    
    private func moveDown() {
       
        UIView.animate(withDuration: 1.5, delay: 0.0, options:[], animations: {
            let screenSize = UIScreen.main.bounds.size
            self.myCircleView.transform = CGAffineTransform(translationX: 0, y: screenSize.height - self.myCircleView.frame.height/2)
        }, completion: nil)
    }
    
    private func afterBindConstraints() {
        clearBtn.snp.makeConstraints {
            $0.trailing.equalTo(self.view).offset(-15)
            $0.top.equalToSuperview()
        }
    }
    
 
}

extension MyInfoViewController {
    @objc func clearTapped() {
        self.dismiss(animated: false, completion: nil)
    }
}
