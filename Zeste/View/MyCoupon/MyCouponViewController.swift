//
//  MyCouponViewController.swift
//  Zeste
//
//  Created by miori Lee on 2021/12/03.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class MyCouponViewController: BaseViewController {

    var ref : DatabaseReference!
    var myStampCnt : Int = 0
    var userNick : String = ""
    
    var noticLabel = UILabel().then {
        $0.text = "아직 쿠폰이 없어요 😰"
        $0.font = .systemFont(ofSize: 16)
        $0.textColor = .darkGray
        $0.isHidden = true
    }
    
    let couponIV = UIImageView().then {
        $0.image = UIImage(named: "myCoupon")
        $0.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        ref = Database.database().reference()
        initV()
        bindConstraints()
        
        getMyStamp("miori")
        //couponIV.isHidden = true
        
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
        self.userNick = nick
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
    
    func resetStamp(_ nick : String) {
        let userID = Auth.auth().currentUser?.uid ?? ""
        self.ref.child("users").observeSingleEvent(of: .value, with: { (snapshot) in
            for child in snapshot.children {
                let snap = child as! DataSnapshot
                //print(snap)
                let value = snap.value as? NSDictionary
                if value?["nick"] as! String == nick {
                    var tmpStamp = value?["points"] as? Int ?? 0
                    tmpStamp = 0
                    self.ref.child("users").child(userID).updateChildValues(["points":tmpStamp])
                }
                //print(self.myStampCnt)
                //self.navigationController?.popViewController(animated: false)
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
            Constant.isFull = true
            self.presentAlert(title: "쿠폰이 발급 되었어요 👏") {
                [self] action in
                self.myStampCnt = 0
                resetStamp(userNick)
                
            }
            noticLabel.isHidden = true
            couponIV.isHidden = false
        }
    }
}
