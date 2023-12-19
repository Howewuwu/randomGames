//
//  rockPaperScissorsViewController.swift
//  randomGames
//
//  Created by Howe on 2023/12/5.
//

import UIKit
import QuartzCore

class rockPaperScissorsViewController: UIViewController {
    
    class RouletteWheel: UIView {
        
        private let segments: Int
            private var isSpinning: Bool = false

            init(frame: CGRect, segments: Int) {
                self.segments = segments
                super.init(frame: frame)
                self.isOpaque = false
            }
            
            required init?(coder: NSCoder) {
                fatalError("init(coder:) has not been implemented")
            }

            override func draw(_ rect: CGRect) {
                guard let ctx = UIGraphicsGetCurrentContext() else { return }
                let radius = min(rect.width, rect.height) / 2
                let center = CGPoint(x: rect.midX, y: rect.midY)

                for i in 0..<segments {
                    ctx.beginPath()
                    ctx.move(to: center)
                    ctx.addArc(center: center, radius: radius, startAngle: CGFloat(i) * 2 * .pi / CGFloat(segments), endAngle: CGFloat(i+1) * 2 * .pi / CGFloat(segments), clockwise: false)
                    ctx.closePath()

                    ctx.setFillColor(i % 2 == 0 ? UIColor.red.cgColor : UIColor.black.cgColor)
                    ctx.fillPath()
                }
            }
            
            func startSpinning() {
                guard !isSpinning else { return }
                isSpinning = true

                let rotation = CABasicAnimation(keyPath: "transform.rotation")
                rotation.fromValue = 0
                rotation.toValue = CGFloat.pi * 2
                rotation.duration = 1
                rotation.repeatCount = Float.infinity
                self.layer.add(rotation, forKey: "spin")
            }
            
            func stopSpinning(atSegment segment: Int, completion: (() -> Void)? = nil) {
                guard isSpinning else { return }
                isSpinning = false
                
                self.layer.removeAnimation(forKey: "spin")
                let desiredAngle = CGFloat(segment) * 2 * .pi / CGFloat(segments)
                UIView.animate(withDuration: 1.0, animations: {
                    self.transform = CGAffineTransform(rotationAngle: desiredAngle)
                }, completion: { _ in
                    completion?()
                })
            }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let rouletteWheel = RouletteWheel(frame: CGRect(x: view.frame.maxX / 3, y: view.frame.height / 3, width: 300, height: 300), segments: 10)
        view.addSubview(rouletteWheel)
    }
    
    
    
    
    // MARK: - Function
    
    
    
    
}
