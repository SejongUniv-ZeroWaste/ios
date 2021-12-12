//
//  MyCouponViewController.swift
//  Zeste
//
//  Created by miori Lee on 2021/12/03.
//

import UIKit
import FirebaseDatabase

class MyCouponViewController: BaseViewController {

    var ref : DatabaseReference!
    var myStampCnt : Int = 0
    
    var noticLabel = UILabel().then {
        $0.text = "아직 쿠폰이 없어요 😰"
        $0.font = .systemFont(ofSize: 16)
        $0.textColor = .darkGray
        $0.isHidden = true
    }
    
    let couponIV = UIImageView().then {
        $0.image = UIImage(named: "myCoupon")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        ref = Database.database().reference()
        initV()
        bindConstraints()
        
        getMyStamp("miori")
        couponIV.isHidden = true
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }

}

extension MyCouponViewController {
    private func initV() {
        _ = [noticLabel,couponIV].map {self.view.addSubview($0)}
    }
    private func bindConstraints(){
        noticLabel.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
        }
        couponIV.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(10)
            $0.leadingMargin.equalTo(10)
            $0.height.equalTo(couponIV.snp.width).multipliedBy(0.5833)
        }
    }
}

extension MyCouponViewController {
    func getMyStamp(_ nick : String) {
        ref.child("users").observeSingleEvent(of: .value, with: { (snapshot) in
            for child in snapshot.children {
                let snap = child as! DataSnapshot
                print(snap)
                //let value = snap.value as? NSDictionary
                let value = snap.value as? NSDictionary
                if value?["nick"] as! String == nick {
                self.myStampCnt = value?["points"] as? Int ?? 0
                self.checkMyStamp(self.myStampCnt)
                }
            }
        }) { (error) in
            print(error.localizedDescription)
        }
        
    }
    func checkMyStamp(_ stampCnt : Int) {
        if stampCnt != 10 {
            noticLabel.isHidden = false
            couponIV.isHidden = true
        } else {
            noticLabel.isHidden = true
            couponIV.isHidden = false
        }
    }
}
