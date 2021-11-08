//
//  TabBarMain.swift
//  VKclient
//
//  Created by Dmitrii KRY on 19.10.2021.
//

import Foundation
import UIKit
import SnapKit

protocol TabBarMainDelegate {
    func configureTabBarVCs()
    func profileFlowIsChosen()
}

@objc protocol TabBarPresenterDelegate {
    @objc func middleButtonIsTapped()
}

class TabBarMain: UITabBarController {
    
    @objc func test() {
        tapDelegate?.middleButtonIsTapped()
    }
    
    var tapDelegate: TabBarPresenterDelegate?
    
    private let middleButtonDiameter: CGFloat = 50

     lazy var middleButton: UIButton = {
        let view = UIButton()
        view.layer.cornerRadius = middleButtonDiameter / 2
        view.backgroundColor = UIColor(named: "bloodyRedColor")
//        view.addTarget(tapDelegate, action: #selector(tapDelegate?.middleButtonIsTapped), for: .touchUpInside)
        view.addTarget(self, action: #selector(test), for: .touchUpInside)
        return view
    }()
    
    private let profileImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "person.fill")
        view.tintColor = .white
        return view
    }()
    
    lazy var setupConstraints = { [self] in
        
        middleButton.snp.makeConstraints { make in
            make.height.width.equalTo(middleButtonDiameter)
            make.top.equalTo(tabBar.snp.top).offset(-20)
            make.centerX.equalTo(tabBar.snp.centerX)
        }
        
        profileImageView.snp.makeConstraints { make in
            make.height.width.equalTo(30)
            make.centerX.centerY.equalTo(middleButton)
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setValue(CustomTabBar(frame: tabBar.frame), forKey: "tabBar")
        tabBar.addSubviews(middleButton)
        middleButton.addSubview(profileImageView)
        setupConstraints()
    }
}

class CustomTabBar: UITabBar {
    
    private var tabBarWidth: CGFloat { self.bounds.width }
    private var tabBarHeight: CGFloat { self.bounds.height }
    private var centerWidth: CGFloat { self.bounds.width / 2 }
    private let circleRadius: CGFloat = 35
    
    private var shapeLayer: CALayer?
    private var circleLayer: CALayer?
    
    private func shapePath() -> CGPath {
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: tabBarWidth, y: 0))
        path.addLine(to: CGPoint(x: tabBarWidth, y: tabBarHeight))
        path.addLine(to: CGPoint(x: 0, y: tabBarHeight))
        path.close()
        return path.cgPath
    }
    
    private func circlePath() -> CGPath {
        let path = UIBezierPath()
        path.addArc(withCenter: CGPoint(x: centerWidth, y: 5),
                    radius: circleRadius,
                    startAngle: 180 * .pi / 180,
                    endAngle: 0 * 180 / .pi,
                    clockwise: true)
        return path.cgPath
    }
    
    private func drawTabBar() {
       
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = shapePath()
        shapeLayer.strokeColor = UIColor.lightGray.cgColor
        shapeLayer.fillColor = UIColor.white.cgColor
        shapeLayer.lineWidth = 1.0

        let circleLayer = CAShapeLayer()
        circleLayer.path = circlePath()
        circleLayer.strokeColor = UIColor.lightGray.cgColor
        circleLayer.fillColor = UIColor.white.cgColor
        circleLayer.lineWidth = 1.0

        if let oldShapeLayer = self.shapeLayer {
            self.layer.replaceSublayer(oldShapeLayer, with: shapeLayer)
        } else {
            self.layer.insertSublayer(shapeLayer, at: 0)
        }

        if let oldCircleLayer = self.circleLayer {
            self.layer.replaceSublayer(oldCircleLayer, with: circleLayer)
        } else {
            self.layer.insertSublayer(circleLayer, at: 1)
        }

        self.shapeLayer = shapeLayer
        self.circleLayer = circleLayer
    }
    
    override func draw(_ rect: CGRect) {
        drawTabBar()
    }
    
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        let pointIsInside = super.point(inside: point, with: event)
        if pointIsInside == false {
            for subview in subviews {
                let pointInSubview = subview.convert(point, from: self)
                if subview.point(inside: pointInSubview, with: event) {
                    return true
                }
            }
        }
        return pointIsInside
    }
    
}

