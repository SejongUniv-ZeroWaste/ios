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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        ref = Database.database().reference()
        initV()
        bindConstraints()
        
        getMyStamp("admin")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }

}

extension MyCouponViewController {
    private func initV() {
        _ = [noticLabel].map {self.view.addSubview($0)}
    }
    private func bindConstraints(){
        noticLabel.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
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
        } else {
            noticLabel.isHidden = false
            noticLabel.text = "쿠폰 획득띠"
        }
    }
}
