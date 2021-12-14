//
//  GetUserInfoViewController.swift
//  Zeste
//
//  Created by miori Lee on 2021/11/30.
//

import UIKit
import FirebaseDatabase

class GetUserInfoViewController: BaseViewController {

    let pageControl = UIPageControl().then {
        $0.pageIndicatorTintColor = .gray
        $0.currentPageIndicatorTintColor = .zestGreen
        $0.numberOfPages = 4
        $0.currentPage = 0
        $0.backgroundColor = .none
        if #available(iOS 14.0, *) {
            $0.backgroundStyle = .minimal //위아래 줄어들고
            $0.allowsContinuousInteraction = false // 좌우 줄어들고
        }
    }
    
    let topicLabel = UILabel().then {
        $0.font = .boldSystemFont(ofSize: 18)
        $0.textColor = .black
        $0.text = "이메일과 비밀번호"
    }
    
    let desLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 16)
        $0.textColor = .darkGray
        $0.numberOfLines = 0
        $0.text = "\(LabelText().joindes0)"
    }
    
    let inTF = UITextField().then {
        $0.placeholder = "닉네임을 입력해주세요"
        $0.borderStyle = .roundedRect
        $0.keyboardType = .default
        $0.autocorrectionType = .no
        $0.textContentType = .name
        $0.autocapitalizationType = .none
        $0.font = UIFont.systemFont(ofSize: 13)
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
    
    let nextBtn = UIButton().then {
        $0.setTitle("다음으로", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.backgroundColor = .zestGreen
        $0.layer.cornerRadius = 8
        $0.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
    }
    
    
    
    var cnt : Int = 0
    var userNick : String = ""
    
    var ref = Database.database().reference()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        dismissKeyboardWhenTappedAround()
        // Do any additional setup after loading the view.
        initV()
        bindConstraints()
        
        nextBtn.addTarget(self, action: #selector(nextTapped(_:)), for: .touchUpInside)
        
        inTF.delegate = self
        inTF.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if #available(iOS 15, *) {
            let appearance = UINavigationBarAppearance()
            let navigationBar = UINavigationBar()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = .white
            appearance.shadowColor = nil
            //UINavigationBar.appearance().standardAppearance = appearance;
            //UINavigationBar.appearance().scrollEdgeAppearance = appearance
            self.navigationController?.navigationBar.compactAppearance = appearance
            self.navigationController?.navigationBar.standardAppearance = appearance
            self.navigationController?.navigationBar.scrollEdgeAppearance = appearance
        }
    }
    

}

extension GetUserInfoViewController {
    private func initV() {
        _ = [pageControl,topicLabel,desLabel,inTF,nextBtn,emailTF,pwTF].map {self.view.addSubview($0)}
    }
    private func bindConstraints() {
        pageControl.snp.makeConstraints {
            $0.top.equalToSuperview().offset(32)
            $0.leading.equalToSuperview().offset(16)
        }
        topicLabel.snp.makeConstraints {
            $0.leading.equalTo(pageControl)
            $0.top.equalTo(pageControl.snp.bottom).offset(16)
        }
        desLabel.snp.makeConstraints {
            $0.leading.equalTo(pageControl)
            $0.top.equalTo(topicLabel.snp.bottom).offset(16)
        }
        inTF.snp.makeConstraints {
            $0.top.equalTo(desLabel.snp.bottom).offset(16)
            $0.leading.equalTo(pageControl)
            $0.trailing.equalToSuperview().offset(-16)
        }
        emailTF.snp.makeConstraints {
            $0.top.equalTo(desLabel.snp.bottom).offset(16)
            $0.leading.equalTo(pageControl)
            $0.trailing.equalToSuperview().offset(-16)
        }
        pwTF.snp.makeConstraints {
            $0.top.equalTo(emailTF.snp.bottom).offset(16)
            $0.leading.equalTo(inTF)
            $0.trailing.equalTo(inTF)
        }
        nextBtn.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.leadingMargin.equalTo(16)
            $0.bottom.equalToSuperview().offset(-30)
            $0.height.equalTo(nextBtn.snp.width).multipliedBy(0.1399)
        }
    }
}

extension GetUserInfoViewController {
    @objc func nextTapped(_ sender : UIButton) {
        print(cnt)
        if self.cnt == 0 {
            _ = [emailTF,pwTF].map {$0.isHidden = true}
            inTF.isHidden = false
            topicLabel.text = "닉네임"
            desLabel.text = "\(LabelText().joindes1)"
            pageControl.currentPage = 1
            cnt += 1
        } else if self.cnt == 1 {
            //finishNick()
            let in_nick = inTF.text!
            print(in_nick)
            checkNick(in_nick)
        } else if self.cnt == 2 {
            finishPhone()
        } else if self.cnt == 3 {
            //self.changeRootViewController(BaseTabBarController())
            self.changeRootViewController(UINavigationController(rootViewController: LoginViewController()))
            cnt = 0
        }
    }
    
    private func finishNick() {
        userNick = inTF.text!
        pageControl.currentPage = 2
        topicLabel.text = "휴대폰 번호"
        desLabel.text = "\(LabelText().joindes2)"
        inTF.text = ""
        inTF.tag = 1
        inTF.placeholder = "휴대폰 번호를 입력해주세요 (010-0000-0000)"
        inTF.textContentType = .telephoneNumber
        inTF.keyboardType = .numberPad
        cnt += 1
    }
    
    private func finishPhone() {
        pageControl.currentPage = 3
        topicLabel.text = "🎉 환영합니다"
        desLabel.text = "\(userNick)님,\n\(LabelText().welcomeT)"
        nextBtn.setTitle("로그인 하러가기", for: .normal)
        inTF.isHidden = true
        cnt += 1
    }
}

extension GetUserInfoViewController {
    private func checkNick(_ nick : String) {
        ref.child("users").queryOrdered(byChild: "nick").queryEqual(toValue: nick).observeSingleEvent(of: .value) { (snapshot) in
            print(snapshot.value as? String)
            if snapshot.value as? String == nil {
                //self.presentAlert(title: "없음")
                self.finishNick()
            } else {
                self.presentAlert(title: "⚠️ 닉네임 중복", message: "이미 있는 닉네임 이예요.")
                self.inTF.text = ""
            }
        }

    }
}


extension GetUserInfoViewController : UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if textField.tag == 1 {
            let text = (textField.text! as NSString).replacingCharacters(in: range, with: string)
            let count = text.count
            //print(count)
            
            if string != "" {
                if count == 4 {
                    inTF.text?.insert("-", at: String.Index.init(encodedOffset: count - 1))
                } else if count == 9{
                    inTF.text?.insert("-", at: String.Index.init(encodedOffset: count - 1))
                } else if count > 13{
                    return false
                }
                return true
            }
        }
        return true
    }
    
}
