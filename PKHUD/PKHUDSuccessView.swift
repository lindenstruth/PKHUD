//
//  PKHUDCheckmarkView.swift
//  PKHUD
//
//  Created by Philip Kluz on 9/27/15.
//  Copyright (c) 2016 NSExceptional. All rights reserved.
//  Licensed under the MIT license.
//

import UIKit

/// PKHUDCheckmarkView provides an animated success (checkmark) view.
open class PKHUDSuccessView: PKHUDSquareBaseView, PKHUDAnimating {

    var checkmarkShapeLayer: CAShapeLayer = {
        let checkmarkPath = UIBezierPath()
        checkmarkPath.move(to: CGPoint(x: 4.0, y: 27.0))
        checkmarkPath.addLine(to: CGPoint(x: 34.0, y: 56.0))
        checkmarkPath.addLine(to: CGPoint(x: 88.0, y: 0.0))

        let layer = CAShapeLayer()
        layer.frame = CGRect(x: 3.0, y: 3.0, width: 88.0, height: 56.0)
        layer.path = checkmarkPath.cgPath

        #if swift(>=4.2)
        layer.fillMode    = .forwards
        layer.lineCap     = .round
        layer.lineJoin    = .round
        #else
        layer.fillMode    = kCAFillModeForwards
        layer.lineCap     = kCALineCapRound
        layer.lineJoin    = kCALineJoinRound
        #endif

        layer.fillColor   = nil
        if !PKHUD.sharedHUD.disableDarkMode, #available(iOS 13.0, *) {
            layer.strokeColor = UIColor.tertiaryLabel.cgColor
        } else {
            layer.strokeColor = UIColor(red: 0.15, green: 0.15, blue: 0.15, alpha: 1.0).cgColor
        }
        layer.lineWidth   = 6.0
        return layer
    }()
    
    open override func draw(_ rect: CGRect) {
        super.draw(rect)
        if self.layer.sublayers?.contains(checkmarkShapeLayer) == true {
            if !PKHUD.sharedHUD.disableDarkMode, #available(iOS 13.0, *) {
                checkmarkShapeLayer.strokeColor = UIColor.tertiaryLabel.cgColor
            } else {
                checkmarkShapeLayer.strokeColor = UIColor(red: 0.15, green: 0.15, blue: 0.15, alpha: 1.0).cgColor
            }
        }
    }
    
    public init(title: String? = nil, subtitle: String? = nil) {
        super.init(title: title, subtitle: subtitle)
        layer.addSublayer(checkmarkShapeLayer)
        checkmarkShapeLayer.position = layer.position
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        layer.addSublayer(checkmarkShapeLayer)
        checkmarkShapeLayer.position = layer.position
    }

    open func startAnimation() {
        let checkmarkStrokeAnimation = CAKeyframeAnimation(keyPath: "strokeEnd")
        checkmarkStrokeAnimation.values = [0, 1]
        checkmarkStrokeAnimation.keyTimes = [0, 1]
        checkmarkStrokeAnimation.duration = 0.35

        checkmarkShapeLayer.add(checkmarkStrokeAnimation, forKey: "checkmarkStrokeAnim")
    }

    open func stopAnimation() {
        checkmarkShapeLayer.removeAnimation(forKey: "checkmarkStrokeAnimation")
    }
}
