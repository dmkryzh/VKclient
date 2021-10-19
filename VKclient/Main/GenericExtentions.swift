//
//  GenericExtentions.swift
//  VKclient
//
//  Created by Dmitrii KRY on 10.10.2021.
//


import Foundation
import UIKit

extension UIView {
    func addSubviews(_ subviews: UIView...) {
        subviews.forEach { addSubview($0) }
    }
}

extension UITextField {
    func addInternalPaddings(left: CGFloat, right: CGFloat) {
        self.leftView = UIView(frame: CGRect(x: self.frame.minX, y: self.frame.minY, width: left, height: self.frame.height))
        self.rightView = UIView(frame: CGRect(x: self.frame.minX, y: self.frame.minY, width: right, height: self.frame.height))
        self.leftViewMode = .always
        self.rightViewMode = .always
    }
}

extension UIImage {
    func alpha(_ value:CGFloat) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        draw(at: CGPoint.zero, blendMode: .normal, alpha: value)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
}

extension UIColor {
    static func createColor(lightMode: UIColor, darkMode: UIColor) -> UIColor {
        guard #available(iOS 13.0, *) else { return lightMode }
        return UIColor { (traitCollection) -> UIColor in
            return traitCollection.userInterfaceStyle == .light ? lightMode : darkMode
        }
        
    }
}

extension String {
    var fetchToken: String {
        let splitStrInHalf = self.components(separatedBy: "%253D")
        let separateStryngBy = splitStrInHalf[1].split(separator: "%").dropLast()
        return separateStryngBy.first?.description ?? ""
    }
}

extension UIButton {

    func alignImageAndTitleVertically(padding: CGFloat = 6.0) {
        let imageSize = self.imageView!.frame.size
        let titleSize = self.titleLabel!.frame.size
        let totalHeight = imageSize.height + titleSize.height + padding

        self.imageEdgeInsets = UIEdgeInsets(
            top: -(totalHeight - imageSize.height),
            left: 0,
            bottom: 0,
            right: -titleSize.width
        )

        self.titleEdgeInsets = UIEdgeInsets(
            top: 0,
            left: -imageSize.width,
            bottom: -(totalHeight - titleSize.height),
            right: 0
        )
    }

}

