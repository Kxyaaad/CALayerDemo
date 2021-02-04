//
//  ViewController.swift
//  CALayerDemo
//
//  Created by Mac on 2021/2/3.
//

import UIKit
import QuartzCore

class ViewController: UIViewController {
    
    var containerView : EmojiView?
    
    let maxContainerSize = CGSize(width: 300, height: 510)
    
    var currentContainerExpansion: Double = 0 {
        didSet {
            containerView?.layer.timeOffset = currentContainerExpansion //直接调整运行时间进度
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        
        let containerFrame = CGRect(origin: CGPoint(x: view.bounds.midX - maxContainerSize.width / 2, y: view.bounds.midY - maxContainerSize.height / 2), size: maxContainerSize)
        let containerView = EmojiView(frame: containerFrame)
        view.addSubview(containerView)
        self.containerView = containerView
        setupAnimations()
        
        let rec = UIPanGestureRecognizer(target: self, action: #selector(handlePan))
        view.addGestureRecognizer(rec)
    }
    
    @objc func handlePan(_ recognizer: UIPanGestureRecognizer) {
        let draDistanceY = recognizer.translation(in: view).y
        let scaledDragAmount = Double(draDistanceY / maxContainerSize.height)
        currentContainerExpansion = min(max(currentContainerExpansion + scaledDragAmount, 0), 1)
        print(draDistanceY)
        recognizer.setTranslation(.zero, in: view)
    }
    
    func setupAnimations() {
        if let containerLayer = containerView?.layer, let emojiLayers = containerView?.emojiLayers {
            containerLayer.speed = 0
            let animation = CABasicAnimation(keyPath: "bounds.size.height")
            animation.fromValue = 80
            animation.toValue = maxContainerSize.height
            animation.duration = 1
            animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
            
            let widthAnimation = CABasicAnimation(keyPath: "bounds.size.width")
            widthAnimation.fromValue = 80
            widthAnimation.toValue = maxContainerSize.width
            widthAnimation.duration = 0.2
            widthAnimation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
            
            containerLayer.add(animation, forKey: nil)
            containerLayer.add(widthAnimation, forKey: nil)
            
            let baseStartTime = containerLayer.convertTime(CACurrentMediaTime(), from: nil)
            for i in emojiLayers.indices {
                let layer = emojiLayers[i]
                let animation = CABasicAnimation(keyPath: "transform.scale.xy")
                animation.fromValue = 0.01
                animation.toValue = 1
                animation.duration = 0.1
                animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
                animation.beginTime = baseStartTime + 0.028 * Double(i)
                animation.fillMode = .backwards
                layer.add(animation, forKey: nil)
            }
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        self.containerView?.backgroundColor = .white
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

