//
//  BaseViewController.swift
//  Zeste
//
//  Created by miori Lee on 2021/10/04.
//

import UIKit

class BaseViewController: UIViewController {

    let deviceSize = UIScreen.main.bounds
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        // Background Color
        self.view.backgroundColor = .white
        initNavi()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension BaseViewController {
    private func initNavi() {
        
        // 네비바 색 입히고 글자색 바꾸기
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.barTintColor = .zestGreen
        self.navigationController?.navigationBar.tintColor = .black
        
        // 네비바 아래 실선 1Px 짜리 없애기
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
    }
    
}
