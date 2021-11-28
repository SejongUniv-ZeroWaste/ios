//
//  LoginViewController.swift
//  Zeste
//
//  Created by miori Lee on 2021/11/09.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class LoginViewController: BaseViewController {
    
    let emailTF = UITextField().then {
        $0.placeholder = "이메일을 입력해주세요"
        $0.borderStyle = .roundedRect
    }
    
    let pwTF = UITextField().then {
        $0.placeholder = "비밀번호를 입력해주세요"
        $0.borderStyle = .roundedRect
    }
    
    let loginBtn = UIButton().then {
        $0.setTitle("로그인", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 13)
    }
    
    // real db
    var ref : DatabaseReference!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initV()
        bindConstraints()
        
        loginBtn.addTarget(self, action: #selector(loginTapped(_:)), for: .touchUpInside)
        self.dismissKeyboardWhenTappedAround()
        
        // firebase reference 초기화
        ref = Database.database().reference()
        
    }

}

extension LoginViewController {
    fileprivate func initV(){
        _ = [emailTF,pwTF,loginBtn].map {self.view.addSubview($0)}
    }
    fileprivate func bindConstraints(){
        emailTF.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.leftMargin.equalTo(30)
            $0.centerY.equalToSuperview().offset(-25)
        }
        pwTF.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.leftMargin.equalTo(30)
            $0.centerY.equalToSuperview().offset(25)
        }
        loginBtn.snp.makeConstraints {
            $0.leading.trailing.equalTo(pwTF)
            $0.bottom.equalToSuperview().offset(-30)
        }
    }
}

extension LoginViewController {
    @objc func loginTapped(_ sender : UIButton) {
        
        let in_email = emailTF.text ?? ""
        let in_pw = pwTF.text ?? ""
        
        // 신규사용자 생성
        // 새로가입
        Auth.auth().createUser(withEmail: in_email, password: in_pw) { [weak self] authResult, error in
            guard let self = self else {return}
        
            //error handling
            if let error = error {
                let code = (error as NSError).code
                switch code {
                case 17007:
                // 이미 계정이 있는 경우, 로그인 필요
                    self.loginUser(withEmail: in_email, password: in_pw)
                default:
                    self.presentAlert(title: error.localizedDescription )
                    
                }
            } else {
                // error 없는 경우
                self.changeRootViewController(BaseTabBarController())
                let userID = Auth.auth().currentUser?.uid ?? ""
                self.ref.child("users").child(userID).setValue(["points":0])
            }

        }
    }
    
    private func loginUser(withEmail email : String, password : String) {
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] _ , error in
            guard let self = self else { return }
            if let error = error {
                self.presentAlert(title: error.localizedDescription)
            } else {
                self.changeRootViewController(BaseTabBarController())
                let userID = Auth.auth().currentUser?.uid ?? ""
                self.ref.child("users").child(userID).setValue(["points":0])
            }
        }
    }
}
