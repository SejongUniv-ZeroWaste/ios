//
//  Color.swift
//  Zeste
//
//  Created by miori Lee on 2021/10/03.
//

import UIKit

extension UIColor {
    // MARK: hex code를 이용하여 정의
    // ex. UIColor(hex: 0xF5663F)
    convenience init(hex: UInt, alpha: CGFloat = 1.0) {
        self.init(
            red: CGFloat((hex & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((hex & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(hex & 0x0000FF) / 255.0,
            alpha: CGFloat(alpha)
        )
    }
    
    // MARK: 메인 테마 색 또는 자주 쓰는 색을 정의
    // ex. label.textColor = .mainOrange
    class var mainOrange: UIColor { UIColor(hex: 0xF5663F) }
    class var zestGreen : UIColor { UIColor(hex: 0x91C788) }
    class var quizAnsBG : UIColor { UIColor(hex: 0xF0F1F2)}
    class var ansPick : UIColor { UIColor(hex: 0x4ADB5A)}
    class var ansWrong : UIColor { UIColor(hex: 0xF14F31)}
    class var doneBtn : UIColor { UIColor(hex: 0xDADCE5)}
}
