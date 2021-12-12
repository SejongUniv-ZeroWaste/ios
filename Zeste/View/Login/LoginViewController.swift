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
    
    let logoIV = UIImageView().then {
        $0.image = UIImage(named: "zeste")
    }
    let emailTF = UITextField().then {
        $0.placeholder = "이메일을 입력해주세요"
        $0.borderStyle = .roundedRect
        $0.keyboardType = .emailAddress
        $0.autocorrectionType = .no
        $0.textContentType = .emailAddress
        $0.autocapitalizationType = .none
        $0.font = UIFont.systemFont(ofSize: 13)
    }
    
    let pwTF = UITextField().then {
        $0.placeholder = "비밀번호를 입력해주세요"
        $0.borderStyle = .roundedRect
        $0.keyboardType = .asciiCapable
        $0.autocorrectionType = .no
        $0.textContentType = .password
        $0.isSecureTextEntry = true
        $0.font = UIFont.systemFont(ofSize: 13)
    }
    
    let loginBtn = UIButton().then {
        $0.setTitle("로그인", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.backgroundColor = .zestGreen
        $0.layer.cornerRadius = 8
        $0.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
    }
    
    let joinBtn = UIButton().then {
        $0.setTitle("회원가입", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.backgroundColor = .none
        $0.layer.cornerRadius = 8
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 15)
    }
    
    let autoLoginBtn = UIButton().then {
        $0.setImage(UIImage(systemName: "checkmark.circle"), for: .normal)
        $0.setTitle("", for: .normal)
        $0.tintColor = .zestGreen
    }
    
    let autoLoginLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 14)
        $0.textColor = .black
        $0.numberOfLines = 0
        $0.text = "로그인 상태 유지하기"
    }
    // real db
    var ref : DatabaseReference!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        initV()
        bindConstraints()
        
        loginBtn.addTarget(self, action: #selector(loginTapped(_:)), for: .touchUpInside)
        joinBtn.addTarget(self, action: #selector(joinTapped(_:)), for: .touchUpInside)
        self.dismissKeyboardWhenTappedAround()
        
        // firebase reference 초기화
        ref = Database.database().reference()
        
        autoLoginBtn.addTarget(self, action: #selector(maintainLogin(_:)), for: .touchUpInside)
        
        //_ = [emailTF,pwTF].map {$0.delegate = self}
    }
    override func viewWillAppear(_ animated: Bool) {
        setNavi()
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
}

extension LoginViewController {
    private func setNavi() {
        let navigationBar = navigationController?.navigationBar
        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.backgroundColor = .white
        navigationBarAppearance.shadowColor = .clear
        navigationBar?.scrollEdgeAppearance = navigationBarAppearance
    }
    fileprivate func initV(){
        _ = [logoIV,emailTF,pwTF,loginBtn,joinBtn,autoLoginBtn, autoLoginLabel].map {self.view.addSubview($0)}
    }
    fileprivate func bindConstraints(){
        logoIV.snp.makeConstraints {
            $0.bottom.equalTo(emailTF.snp.top).offset(-16)
            $0.centerX.equalToSuperview()
            $0.height.equalToSuperview().multipliedBy(0.3)
            $0.width.equalTo(logoIV.snp.height).multipliedBy(0.9164)
        }
        emailTF.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.leftMargin.equalTo(16)
            $0.centerY.equalToSuperview().offset(-25)
        }
        pwTF.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.leftMargin.equalTo(16)
            $0.centerY.equalToSuperview().offset(25)
        }
        loginBtn.snp.makeConstraints {
            $0.leading.trailing.equalTo(pwTF)
            $0.bottom.equalTo(joinBtn.snp.top).offset(-10)
            $0.height.equalTo(joinBtn)
        }
        joinBtn.snp.makeConstraints {
            $0.leading.trailing.equalTo(pwTF)
            $0.bottom.equalToSuperview().offset(-30)
            $0.height.equalTo(loginBtn.snp.width).multipliedBy(0.12)
        }
        autoLoginBtn.snp.makeConstraints {
            $0.leading.equalTo(emailTF)
            $0.top.equalTo(pwTF.snp.bottom).offset(12)
        }
        autoLoginLabel.snp.makeConstraints {
            $0.centerY.equalTo(autoLoginBtn)
            $0.leading.equalTo(autoLoginBtn.snp.trailing).offset(9)
        }
    }
}

extension LoginViewController {
    @objc func joinTapped(_ sender : UIButton) {
        self.navigationController?.pushViewController(GetUserInfoViewController(), animated: false)
        //let in_email = emailTF.text ?? ""
        //let in_pw = pwTF.text ?? ""
        
        // 신규사용자 생성
        // 새로가입
//        Auth.auth().createUser(withEmail: in_email, password: in_pw) { [weak self] authResult, error in
//            guard let self = self else {return}
//
//            //error handling
//            if let error = error {
//                let code = (error as NSError).code
//                switch code {
//                case 17007:
//                    // 이미 계정이 있는 경우, 로그인 필요
//                    self.presentAlert(title: "⚠️ 이미 등록된 계정이 있어요")
//                    // 기기에 uid 저장
//                default:
//                    self.presentAlert(title: error.localizedDescription )
//
//                }
//            } else {
//                // error 없는 경우
//                //self.changeRootViewController(BaseTabBarController())
//                self.navigationController?.pushViewController(GetUserInfoViewController(), animated: false)
//                let userID : String = Auth.auth().currentUser?.uid ?? ""
//                let in_data : UserInfo = UserInfo(nick: "miori", phone: "010-0000-0000", points: 0)
//                //self.ref.child("users").child(userID).setValue(["points":0])
//                self.ref.child("users").child(userID).setValue(in_data.toDict)
//            }
//
//        }
    }
    @objc func loginTapped(_ sender : UIButton) {
        let in_email = emailTF.text ?? ""
        let in_pw = pwTF.text ?? ""
        
        self.loginUser(withEmail: in_email, password: in_pw)
    }
    
    private func loginUser(withEmail email : String, password : String) {
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] _ , error in
            guard let self = self else { return }
            if let error = error {
                self.presentAlert(title: error.localizedDescription)
            } else {
                self.changeRootViewController(BaseTabBarController())
                let userID = Auth.auth().currentUser?.uid ?? ""
                //self.ref.child("users").child(userID).setValue(["points":0])
            }
        }
    }
}

extension LoginViewController {
    @objc func keyboardWillShow(_ sender: Notification) {
        
        let userInfo: NSDictionary = sender.userInfo! as NSDictionary
        let keyboardFrame: NSValue = userInfo.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as! NSValue
        let keyboardRectangle = keyboardFrame.cgRectValue
        
        _ = [emailTF, pwTF].map {if $0.isEditing == true {
            //print("edit")
            keyboardAnimate(keyboardRectangle: keyboardRectangle, textField: $0)
        }}
        
        
    }
    @objc func keyboardWillHide(_ sender: Notification) {
        //self.view.frame.origin.y = topbarHeight
        self.view.transform = .identity
        
    }
    
    @objc func maintainLogin(_ sender : UIButton) {
        sender.setImage(UIImage(systemName: "checkmark.circle.fill"), for: .normal)
        sender.tintColor = .zestGreen
    }
    
    
}
