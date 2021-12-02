//
//  QuizViewController.swift
//  Zeste
//
//  Created by miori Lee on 2021/12/03.
//

import UIKit

class QuizViewController: BaseViewController {
    
    let defaults = UserDefaults.standard
    
    var ans : Int = Int()
    var ansView : QuizAnsView = QuizAnsView()
    var selectedView : QuizAnsView = QuizAnsView()
    
    var solved : Bool = false
    
    let imgView = UIImageView().then {
        $0.image = UIImage(named: "newsExample")
        $0.contentMode = .scaleAspectFill
    }
    
    let questionLabel = UILabel().then {
        $0.numberOfLines  = 0
       //$0.font = UIFont.Pretendard(.bold, size: 18)
        $0.font = UIFont.boldSystemFont(ofSize: 18)
    }
    
    let ansStackView = UIStackView().then {
        $0.axis = .vertical
        $0.backgroundColor = .none
        $0.alignment = .fill
        $0.spacing = 16
        $0.distribution = .fillProportionally
    }
    
    
    let ans1 = QuizAnsView().then {
        $0.tag = 0
    }
    let ans2 = QuizAnsView().then {
        $0.tag = 1
    }
    let ans3 = QuizAnsView().then {
        $0.tag = 2
    }
    let ans4 = QuizAnsView().then {
        $0.tag = 3
    }
    
    let quizBtn = UIButton().then {
        $0.setTitle("정답을 맞춰보세요", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        //$0.titleLabel?.font = UIFont.Pretendard(.bold, size: 14)
        $0.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        $0.backgroundColor = .zestGreen
        $0.layer.cornerRadius = 21
        
        // 그림자 생성
        $0.layer.shadowColor = UIColor.black.cgColor
        $0.layer.shadowOpacity = 0.2
        $0.layer.shadowOffset = CGSize(width: 0, height: 3)
        $0.layer.shadowRadius = 4
    }

    var quizlist: [ArrData] = []
    //var solvedArr : [Bool] = [false]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationItem.title = "퀴즈 풀어보기"
        initV()
        bindConstraints()
        

        _ = [ans1,ans2,ans3,ans4].map {setupTap(selectedview : $0)}
        // save U.D arr
        //defaults.set(solvedArr, forKey: "SolvedArr")
        
        QuizListDataManager().getQuizList(viewController: self)

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //solvedArr = defaults.array(forKey: "SolvedArr")  as? [Bool] ?? [Bool]()
        
//        if solvedArr[0] {
//            // true
//            quizBtn.backgroundColor = .doneBtn
//            quizBtn.setTitle("이미 푼 퀴즈입니다", for: .normal)
//        }
    }

}

extension QuizViewController {
    
    private func initV() {
        _ = [imgView, questionLabel, ansStackView,quizBtn].map {self.view.addSubview($0)}
        _ = [ans1, ans2, ans3, ans4].map {self.ansStackView.addArrangedSubview($0)}
    }
    private func bindConstraints() {
        imgView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalToSuperview().multipliedBy(0.302)
        }
        
        questionLabel.snp.makeConstraints {
            $0.top.equalTo(imgView.snp.bottom).offset(32)
            $0.centerX.equalToSuperview()
            $0.leadingMargin.equalTo(16)
        }
        
        ansStackView.snp.makeConstraints {
            $0.top.equalTo(questionLabel.snp.bottom).offset(40)
            $0.centerX.equalToSuperview()
            $0.leading.equalTo(questionLabel)
            $0.bottom.equalTo(quizBtn.snp.top).offset(-27)
        }
        quizBtn.snp.makeConstraints {
            $0.bottom.equalToSuperview().offset(-50)
            $0.centerX.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(0.408)
            $0.height.equalTo(quizBtn.snp.width).multipliedBy(0.274)
        }
    }
}

extension QuizViewController {
    
    func setupTap(selectedview : UIView) {
            let touchDown = UITapGestureRecognizer(target:self, action: #selector(didTouchDown))
            selectedview.addGestureRecognizer(touchDown)
    }
    
    @objc func didTouchDown(gesture : UITapGestureRecognizer){
        let tag = gesture.view?.tag
       
        if tag == 0 {
            selectedView = ans1
            ans1.backgroundColor  = .ansPick
            ans1.ansLabel.textColor = .white
            ans1.checkImgView.isHidden = false
            _ = [ans2,ans3,ans4].map {$0.backgroundColor = .quizAnsBG; $0.ansLabel.textColor = .black; $0.checkImgView.isHidden = true}
        } else if tag == 1 {
            selectedView = ans2
            ans2.backgroundColor  = .ansPick
            ans2.ansLabel.textColor = .white
            ans2.checkImgView.isHidden = false
            _ = [ans1,ans3,ans4].map {$0.backgroundColor = .quizAnsBG; $0.ansLabel.textColor = .black; $0.checkImgView.isHidden = true}
        } else if tag == 2 {
            selectedView = ans3
            ans3.backgroundColor  = .ansPick
            ans3.ansLabel.textColor = .white
            ans3.checkImgView.isHidden = false
            _ = [ans2,ans1,ans4].map {$0.backgroundColor = .quizAnsBG; $0.ansLabel.textColor = .black; $0.checkImgView.isHidden = true}
        } else {
            selectedView = ans4
            ans4.backgroundColor  = .ansPick
            ans4.ansLabel.textColor = .white
            ans4.checkImgView.isHidden = false
            _ = [ans2,ans3,ans1].map {$0.backgroundColor = .quizAnsBG; $0.ansLabel.textColor = .black; $0.checkImgView.isHidden = true}
        }
        // 정답
        switch ans {
        case 0:
            ansView = ans1
        case 1:
            ansView = ans2
        case 2:
            ansView = ans3
        case 3:
            ansView = ans4
        default:
            print("default")
            
        }
        if tag == ans {
            changeSolvedStatus(idx: 0)
            let correctView = PopupDarkViewController()
            correctView.modalPresentationStyle = .overFullScreen
            let correctPopUP = QuizPopUpView()
            correctPopUP.label1.text = "축하합니다"
            correctPopUP.label2.text = "정답을 맞춰 스탬프 +1 해드릴게요 :)"
            correctPopUP.checkBtn.tag = 0
            correctPopUP.checkBtn.addTarget(self, action: #selector(okTapped), for: .touchUpInside)
            correctView.popupView = correctPopUP
            correctView.canTouch = false
            self.present(correctView,animated: false,completion: nil)
        } else {
            changeSolvedStatus(idx: 0)
            let wrongView = PopupDarkViewController()
            wrongView.modalPresentationStyle = .overFullScreen
            let wrongPopup = QuizPopUpView()
            wrongPopup.logoIV.image = UIImage(named: "cry")
            wrongPopup.logoIV.backgroundColor = .none
            wrongPopup.logoIV.layer.borderWidth = 0.0
            wrongPopup.label1.text = "아쉬워요"
            wrongPopup.label2.text = "다음 퀴즈는 꼭 맞춰봐요!"
            wrongPopup.checkBtn.tag = 1
            wrongPopup.checkBtn.addTarget(self, action: #selector(okTapped), for: .touchUpInside)
            wrongView.popupView = wrongPopup
            wrongView.canTouch = false
            self.present(wrongView,animated: false,completion: nil)
        }
        
    }
}

extension QuizViewController {
    @objc func okTapped(_ sender : UIButton) {
        // 이동하는 경우
//        let homeVC = BaseTabBarController()
//        homeVC.hidesBottomBarWhenPushed = false
//        self.changeRootViewController(homeVC)
        self.dismiss(animated: false, completion: nil)
        quizBtn.backgroundColor = .doneBtn
        quizBtn.setTitle("이미 푼 퀴즈입니다", for: .normal)
        quizBtn.setTitleColor(.white, for: .normal)
        if sender.tag == 0 {
            ansView.backgroundColor = .white
            ansView.layer.borderWidth = 1.0
            ansView.layer.borderColor = UIColor.ansPick.cgColor
            ansView.ansLabel.textColor = .ansPick
            ansView.checkImgView.isHidden = false
            ansView.checkImgView.image = UIImage(named: "alredyDone")
            _ = [ans1,ans2,ans3,ans4].map {$0.isUserInteractionEnabled = false}
        } else {
            ansView.backgroundColor = .white
            ansView.layer.borderWidth = 1.0
            ansView.layer.borderColor = UIColor.ansPick.cgColor
            ansView.ansLabel.textColor = .ansPick
            ansView.checkImgView.isHidden = false
            ansView.checkImgView.image = UIImage(named: "alredyDone")
            
            selectedView.backgroundColor = .ansWrong
            selectedView.layer.borderWidth = 1.0
            selectedView.layer.borderColor = UIColor.ansWrong.cgColor
            selectedView.ansLabel.textColor = .white
            selectedView.checkImgView.isHidden = false
            selectedView.checkImgView.image = UIImage(named: "wrong")
            _ = [ans1,ans2,ans3,ans4].map {$0.isUserInteractionEnabled = false}
        }
    }
}

extension QuizViewController {
    func didSuccess(result : QuizModel) {
        //print(result.results)
        quizlist = result.results
        setQuizData()
    }
    func failedToRequest(message : String) {
        self.presentAlert(title: message)
    }
    
    func setQuizData() {
        questionLabel.text = quizlist[0].title
        ans1.ansLabel.text = quizlist[0].a1
        ans2.ansLabel.text = quizlist[0].a2
        ans3.ansLabel.text = quizlist[0].a3
        ans4.ansLabel.text = quizlist[0].a4
        ans = quizlist[0].ans - 1
    }
    
    func changeSolvedStatus(idx : Int) {
//        solvedArr[idx] = true
//        defaults.set(solvedArr, forKey: "SolvedArr")
    }
}
