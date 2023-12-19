//
//  wheelViewController.swift
//  randomGames
//
//  Created by Howe on 2023/12/5.
//

import UIKit

class wheelViewController: UIViewController {
    
    let aDegree = Double.pi / 180
    let lineWidth = 1
    let radius = 170
    var startDegree = 270
    
    let arrowImageView = UIImageView()
    
    let slider = UISlider()
    var sliderValue = 2
    
    let wheelContainerView = UIView()
    var timer = Timer()
    
    let startRollButton = UIButton()
    
    var circleLayers: [CAShapeLayer] = []
    var numberLabels: [UILabel] = []
    
    var rotationCurrentValue: Double = 0
    var eachRouDegree: Double = 0
    
    var rotatedNumbelLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        
        arrowImageView.image = UIImage(systemName: "arrowtriangle.down.fill")
        arrowImageView.tintColor = .systemRed
        arrowImageView.backgroundColor = .clear
        arrowImageView.translatesAutoresizingMaskIntoConstraints = false
        
        slider.value = 2
        slider.minimumValue = 2
        slider.maximumValue = 36
        slider.minimumTrackTintColor = .white
        slider.maximumTrackTintColor = .white
        slider.thumbTintColor = .white
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.addTarget(self, action: #selector(sliderValueChange), for: .valueChanged)
        
        startRollButton.setTitle("  START ROLL  ", for: .normal)
        startRollButton.setTitleColor(.black, for: .normal)
        startRollButton.setTitleColor(.lightGray, for: .highlighted)
        startRollButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 10)
        startRollButton.backgroundColor = .white
        startRollButton.translatesAutoresizingMaskIntoConstraints = false
        startRollButton.addTarget(self, action: #selector(startRouletteAnimation), for: .touchUpInside)
        
        rotatedNumbelLabel.text = ""
        rotatedNumbelLabel.font = .boldSystemFont(ofSize: 80)
        rotatedNumbelLabel.textColor = .white
        rotatedNumbelLabel.textAlignment = .center
        rotatedNumbelLabel.translatesAutoresizingMaskIntoConstraints = false
        
        
        wheelContainerView.backgroundColor = .clear
        wheelContainerView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(wheelContainerView)
        view.addSubview(arrowImageView)
        view.addSubview(startRollButton)
        view.addSubview(slider)
        view.addSubview(rotatedNumbelLabel)
        
        NSLayoutConstraint.activate([
            wheelContainerView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            wheelContainerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            wheelContainerView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            wheelContainerView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            wheelContainerView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.5),
            
            arrowImageView.centerXAnchor.constraint(equalTo: wheelContainerView.centerXAnchor),
            arrowImageView.topAnchor.constraint(equalTo: wheelContainerView.topAnchor),
            
            startRollButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            startRollButton.topAnchor.constraint(equalTo: wheelContainerView.bottomAnchor, constant: 30),
            
            slider.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            slider.topAnchor.constraint(equalTo: startRollButton.bottomAnchor, constant: 50),
            slider.widthAnchor.constraint(equalTo: wheelContainerView.widthAnchor, multiplier: 0.8),
            
            rotatedNumbelLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            rotatedNumbelLabel.widthAnchor.constraint(equalTo: slider.widthAnchor, multiplier: 1),
            rotatedNumbelLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -90)
        ])
        
        //Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(makeCircle), userInfo: nil, repeats: false)
        
    }
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        makeCircle()
    }
    
    
    
    // MARK: - Function
    
    
    
    @objc func makeCircle() {
        
        for layer in circleLayers {
            layer.removeFromSuperlayer()
        }
        
        for label in numberLabels {
            label.removeFromSuperview()
        }
        circleLayers.removeAll()
        numberLabels.removeAll()
        
        
        let wheelCenter = CGPoint(x: wheelContainerView.bounds.midX, y: wheelContainerView.bounds.midY)
        
        
        for circlePart in 1...sliderValue {
            
            var endDegree = startDegree + 360 / sliderValue
            
            if circlePart == sliderValue {
                endDegree = 270
            }
            
            let circlePath = UIBezierPath()
            
            circlePath.move(to: wheelCenter)
            circlePath.addArc(withCenter: wheelCenter, radius: CGFloat(radius), startAngle: aDegree * Double(startDegree), endAngle: aDegree * Double(endDegree), clockwise: true)
            
            
            let circleLayer = CAShapeLayer()
            
            circleLayer.path = circlePath.cgPath
            circleLayer.fillColor = (circlePart % 2 == 0) ? UIColor.black.cgColor : UIColor.white.cgColor
            circleLayer.strokeColor = UIColor.systemGray.cgColor
            circleLayer.lineWidth = CGFloat(lineWidth)
            
            
            wheelContainerView.layer.addSublayer(circleLayer)
            
            circleLayers.append(circleLayer)
            
            addNumberLabel(circlePart: circlePart, startDegree: startDegree, endDegree: endDegree)
            
            startDegree = endDegree
            
        }
        
    }
    
    
    
    func addNumberLabel(circlePart: Int, startDegree: Int, endDegree: Int) {
        
        var labelDegree = (startDegree + endDegree) / 2
        
        if endDegree == 270 {
            labelDegree += 180
        }
        
        
        let labelPath = UIBezierPath(arcCenter: CGPoint(x: wheelContainerView.bounds.midX, y: wheelContainerView.bounds.midY), radius: CGFloat(radius) - 20, startAngle: aDegree * Double(labelDegree), endAngle: aDegree * Double(labelDegree), clockwise: true)
        
        
        let numberLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        numberLabel.backgroundColor = .clear
        numberLabel.font = UIFont.systemFont(ofSize: 10)
        numberLabel.textColor = (circlePart % 2 == 0) ? .white : .black
        numberLabel.text = "\(circlePart)"
        numberLabel.textAlignment = .center
        numberLabel.transform = CGAffineTransform(rotationAngle: CGFloat(labelDegree - 270) * aDegree)
        numberLabel.center = labelPath.currentPoint
        
        wheelContainerView.addSubview(numberLabel)
        
        numberLabels.append(numberLabel)
        
    }
    
    
    
    @objc func startRouletteAnimation() {
        
        let labelCount: Int
        let randomPi = Double.random(in: 0..<2 * Double.pi)
        
        labelCount = numberLabels.count
        print("labelCount: \(labelCount)")
        
        eachRouDegree = Double(360 / labelCount)
        print("rouDegree: \(eachRouDegree)")
        
        let rotation = CABasicAnimation(keyPath: "transform.rotation")
        CATransaction.begin()
        
        
        rotation.fromValue = rotationCurrentValue
        rotationCurrentValue = rotationCurrentValue + 10 * Double.pi + randomPi
        
        let rotatedValue = rotationCurrentValue.truncatingRemainder(dividingBy: Double.pi * 2)
        print("rotatedValue: \(rotatedValue)")
        let degree = rotatedValue * 180 / Double.pi
        print("degree: \(degree)")
        let answer = (360 - degree) / eachRouDegree + 1
        
        rotation.toValue = rotationCurrentValue
        rotation.duration = 5
        rotation.isCumulative = true
        rotation.isRemovedOnCompletion = false
        rotation.fillMode = .forwards
        rotation.repeatCount = 1
        
        rotation.timingFunction = CAMediaTimingFunction(controlPoints: 0, 0.9, 0.4, 1.0)
        
        print("\(answer)")
        
        wheelContainerView.layer.add(rotation, forKey: "rotationAnimation")
        
        CATransaction.setCompletionBlock {
            DispatchQueue.main.asyncAfter(deadline: .now() + 5) { [self] in
                rotatedNumbelLabel.text = "\(Int(answer))"
            }
            
        }
        
        CATransaction.commit()
        
    }
    
    
    
    @objc func sliderValueChange() {
        sliderValue = Int(slider.value)
        makeCircle()
    }
    
    
    
}
