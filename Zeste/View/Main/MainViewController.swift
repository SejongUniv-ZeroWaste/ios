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
    
    let logoIV = UIImageView().then {
        $0.image = UIImage(named: "zeste")
    }
    
    let notiLabel = UILabel().then {
        $0.font = UIFont.boldSystemFont(ofSize: 20)
        $0.numberOfLines = 0
        $0.text = "\"플라스틱 제발 그만 써..\n나 무서워 😱🥶\n이러다 다 죽어 ㅜㅜ\""
    }
    
    let btnView = UIView().then {
        $0.backgroundColor = .none
    }
    let couponBtn = UIButton().then {
        $0.setImage(UIImage(named: "coupon"), for: .normal)
        $0.tag = 0
    }
    
    let newLabel = UILabel().then {
        $0.text = "🎁"
        $0.font = UIFont.boldSystemFont(ofSize: 15)
        $0.isHidden = true
    }
    
    let sizeBtn = UIButton().then {
        $0.setImage(UIImage(named: "oz"), for: .normal)
        $0.tag = 1
    }
    
    var myStampCnt : Int = 0

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
        
        _ = [couponBtn,sizeBtn].map {$0.addTarget(self, action: #selector(btnTapped), for: .touchUpInside)}
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if !Constant.isFull {
        ref.child("users").observeSingleEvent(of: .value, with: { (snapshot) in
            for child in snapshot.children {
                let snap = child as! DataSnapshot
                print(snap)
                //let value = snap.value as? NSDictionary
                let value = snap.value as? NSDictionary
                if value?["nick"] as! String == "miori" {
                self.myStampCnt = value?["points"] as? Int ?? 2
                //self.presentAlert(title: "\(self.myStampCnt)")
                self.getMyStamp()
                }
            }
        }) { (error) in
            print(error.localizedDescription)
        }
        
        } else {
            newLabel.isHidden = false
            self.myStampCnt = 0
            for i in 1...5 {
                innerStampView1.circleArr[i].image =  UIImage(named: "stampOff")
                innerStampView2.circleArr[i].image =  UIImage(named: "stampOff")
            }
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
        _ = [mainCircleView,stampWholeView,btnView,newLabel].map {self.view.addSubview($0)}
        _ = [logoIV,notiLabel].map {self.mainCircleView.addSubview($0)}
        _ = [couponBtn,sizeBtn].map {self.btnView.addSubview($0)}
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
        logoIV.snp.makeConstraints {
            $0.centerX.equalToSuperview().offset(-self.view.frame.width/3)
            $0.top.equalTo(self.view.snp.top).offset(15)
            $0.height.equalToSuperview().multipliedBy(0.25)
            $0.width.equalTo(logoIV.snp.height).multipliedBy(0.9164)
        }
        notiLabel.snp.makeConstraints {
            $0.centerY.equalTo(logoIV)
            $0.leading.equalTo(logoIV.snp.trailing).offset(20)
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
        btnView.snp.makeConstraints {
            $0.top.equalTo(stampWholeView.snp.bottom).offset(20)
            $0.centerX.equalToSuperview()
            $0.leadingMargin.equalTo(10)
            $0.bottom.equalToSuperview().offset(-20)
        }
        couponBtn.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.centerX.equalToSuperview().offset(-self.view.frame.width/4)
        }
        sizeBtn.snp.makeConstraints  {
            $0.centerY.equalToSuperview()
            $0.centerX.equalToSuperview().offset(self.view.frame.width/4)
        }
        newLabel.snp.makeConstraints {
            $0.bottom.equalTo(couponBtn.snp.top).offset(20)
            $0.leading.equalTo(couponBtn.snp.trailing).offset(-8)
        }
    }
    
}

extension MainViewController {
    @objc func qrTapped() {
        print("qrTapped")
        let nextVC = QRCodeViewController()
        //self.navigationController?.pushViewController(QRCodeViewController(), animated: false)
        nextVC.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(nextVC, animated: false)
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


extension MainViewController {
    @objc func btnTapped(_ sender : UIButton) {
        if sender.tag == 0 {
            let nextVC = MyCouponViewController()
            nextVC.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(nextVC, animated: false)
        } else if sender.tag == 1 {
            let nextVC = CoffeeSizeViewController()
            nextVC.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(nextVC, animated: false)
        }
    }
}
