//
//  UIView+Animation.swift
//  CurrencyConverter
//
//  Created by Ice on 14.12.2024.
//

import UIKit

public extension UIView {
    func fadeTransition(_ duration: CFTimeInterval = 0.3) {
        let animation = CATransition()
        animation.timingFunction = CAMediaTimingFunction(name:
                                                            CAMediaTimingFunctionName.easeInEaseOut)
        animation.type = CATransitionType.fade
        animation.duration = duration
        layer.add(animation, forKey: CATransitionType.fade.rawValue)
    }
    
    func buttonScaleAnimation() {
        self.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
        
        UIView.animate(withDuration: 0.1, delay: 0, usingSpringWithDamping: 0.1, initialSpringVelocity: 3) {
            self.transform = CGAffineTransform.identity
        }
        
        UIImpactFeedbackGenerator(style: .light).impactOccurred()
    }
    
    func addShowEffect() {
        let flakeEmitterCell = CAEmitterCell()
        flakeEmitterCell.contents = UIImage(namedInCore: "Snowflake Blue")?.cgImage
        flakeEmitterCell.scale = 0.06
        flakeEmitterCell.scaleRange = 0.3
        flakeEmitterCell.emissionRange = .pi
        flakeEmitterCell.lifetime = 20.0
        flakeEmitterCell.birthRate = 40
        flakeEmitterCell.velocity = -30
        flakeEmitterCell.velocityRange = -20
        flakeEmitterCell.yAcceleration = 30
        flakeEmitterCell.xAcceleration = 5
        flakeEmitterCell.spin = -0.5
        flakeEmitterCell.spinRange = 1.0
        
        let snowEmitterLayer = CAEmitterLayer()
        snowEmitterLayer.emitterPosition = CGPoint(x: self.bounds.width / 2.0, y: -50)
        snowEmitterLayer.emitterSize = CGSize(width: self.bounds.width, height: 0)
        snowEmitterLayer.emitterShape = CAEmitterLayerEmitterShape.line
        snowEmitterLayer.beginTime = CACurrentMediaTime()
        snowEmitterLayer.timeOffset = 10
        snowEmitterLayer.emitterCells = [flakeEmitterCell]
        self.layer.addSublayer(snowEmitterLayer)
    }
}
