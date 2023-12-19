//
//  wheelViewController.swift
//  randomGames
//
//  Created by Howe on 2023/12/5.
//

import UIKit

class wheelViewController: UIViewController {
    
    // 基本參數定義
    let aDegree = Double.pi / 180 // 將一度轉換為弧度的常數
    let lineWidth = 1 // 線條寬度
    let radius = 170 // 轉盤半徑
    var startDegree = 270 // 轉盤開始的角度
    
    // 初始化界面元件
    let arrowImageView = UIImageView() // 箭頭指示器的圖片視圖
    let slider = UISlider() // 滑動條控件
    var sliderValue = 2 // 滑動條的初始值
    let wheelContainerView = UIView() // 轉盤容器視圖
    var timer = Timer() // 計時器
    let startRollButton = UIButton() // 開始按鈕
    var circleLayers: [CAShapeLayer] = [] // 用於儲存轉盤上的圓形圖層
    var numberLabels: [UILabel] = [] // 用於儲存轉盤上的數字標籤
    var rotationCurrentValue: Double = 0 // 當前轉盤的旋轉值
    var eachSectorDegree: Double = 0 // 每個扇形(圓形分段)的角度
    var rotatedNumbelLabel = UILabel() // 顯示旋轉數字的標籤
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 設置界面元件屬性
        view.backgroundColor = .black // 設置背景顏色
        
        // 設置箭頭指示器
        arrowImageView.image = UIImage(systemName: "arrowtriangle.down.fill")
        arrowImageView.tintColor = .systemRed
        arrowImageView.backgroundColor = .clear
        arrowImageView.translatesAutoresizingMaskIntoConstraints = false
        
        // 設置滑動條
        slider.value = 2
        slider.minimumValue = 2
        slider.maximumValue = 36
        slider.minimumTrackTintColor = .white
        slider.maximumTrackTintColor = .white
        slider.thumbTintColor = .white
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.addTarget(self, action: #selector(sliderValueChange), for: .valueChanged)
        
        // 設置開始按鈕
        startRollButton.setTitle("  START ROLL  ", for: .normal)
        startRollButton.setTitleColor(.black, for: .normal)
        startRollButton.setTitleColor(.lightGray, for: .highlighted)
        startRollButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 10)
        startRollButton.backgroundColor = .white
        startRollButton.translatesAutoresizingMaskIntoConstraints = false
        startRollButton.addTarget(self, action: #selector(startRouletteAnimation), for: .touchUpInside)
        
        // 設置旋轉數字標籤
        rotatedNumbelLabel.text = ""
        rotatedNumbelLabel.font = .boldSystemFont(ofSize: 80)
        rotatedNumbelLabel.textColor = .white
        rotatedNumbelLabel.textAlignment = .center
        rotatedNumbelLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // 設置轉盤容器視圖
        wheelContainerView.backgroundColor = .clear
        wheelContainerView.translatesAutoresizingMaskIntoConstraints = false
        
        // 添加元件到視圖
        view.addSubview(wheelContainerView)
        view.addSubview(arrowImageView)
        view.addSubview(startRollButton)
        view.addSubview(slider)
        view.addSubview(rotatedNumbelLabel)
        
        // 使用Auto Layout設置元件的位置和大小
        NSLayoutConstraint.activate([
            // 設置轉盤容器視圖的約束
            wheelContainerView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            wheelContainerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            wheelContainerView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            wheelContainerView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            wheelContainerView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.5),
            
            // 設置箭頭指示器的約束
            arrowImageView.centerXAnchor.constraint(equalTo: wheelContainerView.centerXAnchor),
            arrowImageView.topAnchor.constraint(equalTo: wheelContainerView.topAnchor),
            
            // 設置開始按鈕的約束
            startRollButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            startRollButton.topAnchor.constraint(equalTo: wheelContainerView.bottomAnchor, constant: 30),
            
            // 設置滑動條的約束
            slider.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            slider.topAnchor.constraint(equalTo: startRollButton.bottomAnchor, constant: 50),
            slider.widthAnchor.constraint(equalTo: wheelContainerView.widthAnchor, multiplier: 0.8),
            
            // 設置旋轉數字標籤的約束
            rotatedNumbelLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            rotatedNumbelLabel.widthAnchor.constraint(equalTo: slider.widthAnchor, multiplier: 1),
            rotatedNumbelLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -90)
        ])
        
        // 創建轉盤的圓形圖層和數字標籤
        // Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(makeCircle), userInfo: nil, repeats: false)
    }
    
    
    
    // 視圖控制器的視圖完全出現後執行的方法
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // 呼叫 makeCircle 方法來初始化轉盤
        // 這個方法可能包含了創建轉盤的圖層、配置圖層的屬性等邏輯
        makeCircle()
    }
    
    
    
    // MARK: - Function & @objc Function
    
    
    
    // 這個方法用於生成轉盤的圓形分段及其對應的數字標籤
    @objc func makeCircle() {
        
        // 移除已有的圓形圖層和數字標籤
        for layer in circleLayers {
            layer.removeFromSuperlayer()
        }
        for label in numberLabels {
            label.removeFromSuperview()
        }
        circleLayers.removeAll()
        numberLabels.removeAll()
        
        
        // 計算轉盤中心點
        let wheelCenter = CGPoint(x: wheelContainerView.bounds.midX, y: wheelContainerView.bounds.midY)
        
        // 根據滑動條的值，生成相應數量的圓形分段
        for circlePart in 1...sliderValue {
            // 計算每個分段的起始和結束角度
            var endDegree = startDegree + 360 / sliderValue
            
            
            // 檢查是否正在處理轉盤的最後一個分段
            if circlePart == sliderValue {
                // 如果是最後一個分段，則將該分段的結束角度設置為 270 度
                // 這是為了確保轉盤的最後一個分段始終結束在相同的位置（270度）
                // 不論滑動條設定的分段數量如何變化，這樣可以使轉盤的起始和結束位置保持一致
                endDegree = 270
            }
            
            
            // 創建並配置 UIBezierPath 來繪製每個圓形分段
            let circlePath = UIBezierPath()
            circlePath.move(to: wheelCenter)
            circlePath.addArc(withCenter: wheelCenter, radius: CGFloat(radius), startAngle: aDegree * Double(startDegree), endAngle: aDegree * Double(endDegree), clockwise: true)
            
            // 創建並配置每個分段的 CAShapeLayer
            let circleLayer = CAShapeLayer()
            circleLayer.path = circlePath.cgPath
            
            // 設置扇形圖層的填充顏色
            // 使用三元運算符來決定顏色：如果圓形分段數（circlePart）是偶數，則填充顏色為黑色；否則為白色
            circleLayer.fillColor = (circlePart % 2 == 0) ? UIColor.black.cgColor : UIColor.white.cgColor

            circleLayer.strokeColor = UIColor.systemGray.cgColor
            circleLayer.lineWidth = CGFloat(lineWidth)
            
            // 將創建的 CAShapeLayer 添加到轉盤容器視圖的圖層中
            wheelContainerView.layer.addSublayer(circleLayer)
            circleLayers.append(circleLayer)
            
            // 為每個分段添加數字標籤
            addNumberLabel(circlePart: circlePart, startDegree: startDegree, endDegree: endDegree)
            
            // 更新起始角度為當前分段的結束角度
            startDegree = endDegree
        }
    }
    
    
    
    // 此函數用於向轉盤的每個分段添加數字標籤
    func addNumberLabel(circlePart: Int, startDegree: Int, endDegree: Int) {
        
        // 計算標籤應該放置的角度，即分段的中間點
        var labelDegree = (startDegree + endDegree) / 2
        
        // 如果這是轉盤的最後一個分段，則調整標籤的角度，以確保標籤正確顯示
        if endDegree == 270 {
            labelDegree += 180
        }
        
        // 創建一個 UIBezierPath，用於確定數字標籤的準確位置
        let labelPath = UIBezierPath(arcCenter: CGPoint(x: wheelContainerView.bounds.midX, y: wheelContainerView.bounds.midY), radius: CGFloat(radius) - 20, startAngle: aDegree * Double(labelDegree), endAngle: aDegree * Double(labelDegree), clockwise: true)
        
        // 初始化 UILabel 用作數字標籤，設定其大小、背景色、字體和顏色
        let numberLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        numberLabel.backgroundColor = .clear
        numberLabel.font = UIFont.systemFont(ofSize: 10)
        numberLabel.textColor = (circlePart % 2 == 0) ? .white : .black // 交替顏色以提高可讀性
        numberLabel.text = "\(circlePart)" // 設定標籤文本為分段數
        numberLabel.textAlignment = .center
        // 轉動標籤以匹配其對應分段的角度
        numberLabel.transform = CGAffineTransform(rotationAngle: CGFloat(labelDegree - 270) * aDegree)
        // 設定標籤的中心點為 UIBezierPath 的當前點
        numberLabel.center = labelPath.currentPoint
        
        // 將標籤添加到轉盤容器視圖中
        wheelContainerView.addSubview(numberLabel)
        
        // 將創建的標籤添加到 numberLabels 數組中，以便未來管理
        numberLabels.append(numberLabel)
    }
    
    
    
    // 這個方法用於啟動轉盤的旋轉動畫
    @objc func startRouletteAnimation() {
        
        // 定義局部變量
        let randomPi = Double.random(in: 0..<2 * Double.pi) // 生成隨機角度
        
        eachSectorDegree = Double(360 / sliderValue) // 計算每個標籤代表的角度
        print("eachSectorDegree: \(eachSectorDegree)")
        
        // 初始化旋轉動畫
        let rotation = CABasicAnimation(keyPath: "transform.rotation")
        CATransaction.begin()
        
        rotation.fromValue = rotationCurrentValue // 設置動畫起始值
        rotationCurrentValue = rotationCurrentValue + 10 * Double.pi + randomPi // 更新旋轉目標值
        
        // 計算旋轉後的實際值
        // 算出最後一圈時從 0 度開始這個圓轉了幾(弧)度
        let rotatedValue = rotationCurrentValue.truncatingRemainder(dividingBy: Double.pi * 2)
        print("rotatedValue: \(rotatedValue)")
        let degree = rotatedValue * 180 / Double.pi // 轉換為角度
        print("degree: \(degree)")
        
        // 計算轉盤停止後指向的扇形索引
        // 'degree' 是轉盤停止後的角度
        // 'eachSectorDegree' 是每個扇形代表的角度
        // 計算方法是將 360 度減去 'degree' 得到轉盤目前處於箭頭處它原本的角度，然後再用這個原本的 “角度數字” 除以每個扇形的角度
        // 最後加 1 是因為扇形索引是從 1 開始計數的（而不是從 0 開始）
        let answer = (360 - degree) / eachSectorDegree + 1 // 計算結果
        
        // 設置動畫其它屬性
        rotation.toValue = rotationCurrentValue // 設置動畫結束值
        rotation.duration = 5 // 設置動畫時長
        rotation.isCumulative = true
        rotation.isRemovedOnCompletion = false
        rotation.fillMode = .forwards
        rotation.repeatCount = 1 // 設置重復次數
        
        rotation.timingFunction = CAMediaTimingFunction(controlPoints: 0, 0.9, 0.4, 1.0) // 設置動畫時間函數
        
        print("\(answer)")
        
        // 將動畫添加到轉盤視圖的圖層
        wheelContainerView.layer.add(rotation, forKey: "rotationAnimation")
        
        // 設置動畫完成後的處理
        CATransaction.setCompletionBlock {
            DispatchQueue.main.asyncAfter(deadline: .now() + 5) { [self] in
                rotatedNumbelLabel.text = "\(Int(answer))" // 更新顯示結果的標籤
            }
        }
        
        CATransaction.commit() // 提交動畫事務
    }
    
    
    
    // 滑動條值改變時調用的方法
    @objc func sliderValueChange() {
        // 更新 sliderValue 為滑動條當前的值
        // 這個值決定了轉盤將被分成多少個部分
        sliderValue = Int(slider.value)
        
        // 調用 makeCircle 方法來重新繪製轉盤
        // 這個操作會根據新的 sliderValue 創建相應數量的分段和數字標籤
        makeCircle()
    }
    
    
    
}
