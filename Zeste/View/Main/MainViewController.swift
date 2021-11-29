//
//  MainViewController.swift
//  Zeste
//
//  Created by miori Lee on 2021/10/03.
//

import UIKit
import SnapKit
import Then
import FirebaseDatabase

class MainViewController: BaseViewController {
    
    lazy var mainCircleView = CircleView()

    let stampWholeView = StampRoundView()
    
    let stampStack = StampStackView()
    
    let innerStampView1 = InnerStampStack()
    
    let innerStampView2 = InnerStampStack()
    
    var myStampCnt : Int = 7

    var ref : DatabaseReference!
    
    override func viewDidLayoutSubviews() {
        mainCircleView.layer.cornerRadius = mainCircleView.frame.height / 2
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        initVC()
        bindConstraints()
        setBarButton()
        
        // firebase reference 초기화
        ref = Database.database().reference()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        ref.child("users").observeSingleEvent(of: .value, with: { (snapshot) in
            for child in snapshot.children {
                let snap = child as! DataSnapshot
                print(snap)
                let value = snap.value as? NSDictionary
                self.myStampCnt = value?["points"] as? Int ?? 2
                //self.presentAlert(title: "\(self.myStampCnt)")
                self.getMyStamp()
            }
        }) { (error) in
            print(error.localizedDescription)
        }
        
    }
    
}

extension MainViewController {

    private func setBarButton() {

        self.navigationItem.rightBarButtonItem = UIBarButtonItem(
            //.viewfinder
            image: UIImage(systemName: "qrcode"),
            style: .plain,
            target: self,
            action: #selector(qrTapped)
        )
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "person.crop.circle"),
            style: .plain,
            target: self,
            action: #selector(personTapped)
        )
    }
    
    private func initVC() {
        _ = [mainCircleView,stampWholeView].map {self.view.addSubview($0)}
        _ = [stampStack].map {self.stampWholeView.addSubview($0)}
        _ = [innerStampView1].map {self.stampStack.stampRound1.addSubview($0)}
        _ = [innerStampView2].map {self.stampStack.stampRound2.addSubview($0)}
    }
    
    private func bindConstraints() {
        mainCircleView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(self.view.snp.top).offset(deviceSize.height/4)
            $0.width.equalTo(self.view.snp.width).multipliedBy(1.57)
        }
        stampWholeView.snp.makeConstraints {
            $0.top.equalTo(mainCircleView.snp.bottom).offset(28)
            $0.centerX.equalToSuperview()
            $0.leadingMargin.equalTo(10)
            $0.height.equalTo(stampWholeView.snp.width).multipliedBy(0.5)
        }
        stampStack.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
            $0.leadingMargin.equalToSuperview().offset(6)
            $0.topMargin.equalToSuperview().offset(6)
        }
        innerStampView1.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        innerStampView2.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
}

extension MainViewController {
    @objc func qrTapped() {
        print("qrTapped")
        self.navigationController?.pushViewController(QRCodeViewController(), animated: false)
    }
    @objc func personTapped(){
        print("infoTapped")
        self.dismiss(animated: false, completion: nil)
        //moveDown()
        let nextVC = MyInfoViewController()
        nextVC.modalPresentationStyle = .fullScreen
        self.present(nextVC, animated: false, completion: nil)
    }

}

//MARK: - Stamp 적립 관련 함수
extension MainViewController {
    func getMyStamp() {
        // 한줄 다 채워야하는 경우
        if myStampCnt > 5 && myStampCnt < 11 {
            for i in 1...5 {
                innerStampView1.circleArr[i].image =  UIImage(named: "stampOn")
            }
            let secontCnt = myStampCnt - 5
            for i in 1...secontCnt {
                innerStampView2.circleArr[i].image =  UIImage(named: "stampOn")
            }
        } else {
            for i in 0...myStampCnt {
                innerStampView1.circleArr[i].image =  UIImage(named: "stampOn")
            }
        }
    }
}

