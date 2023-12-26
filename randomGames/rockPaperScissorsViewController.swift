//
//  rockPaperScissorsViewController.swift
//  randomGames
//
//  Created by Howe on 2023/12/5.
//

import UIKit
import QuartzCore
import SwiftyGif

// 定義一個名為 rockPaperScissorsViewController 的類別，繼承自 UIViewController。
class rockPaperScissorsViewController: UIViewController {
    
    // 定義兩個 UIImageView，用於顯示玩家的選擇。
    var player01ImageView = UIImageView()
    var player02ImageView = UIImageView()
    
    // 定義一個 UIButton 陣列，用於儲存玩家的操作按鈕。
    var player01ElementButtons = [UIButton]()
    
    // 定義一個 UIImageView 用於顯示玩家的頭像或相關圖像。
    let player02HeadImageView = UIImageView()
    
    // 定義一個 UILabel，用於顯示遊戲狀態（如“開始”、“玩家勝利”等）。
    var statusLabel = UILabel()
    var status = GameState.start.status
    
    // 定義一個 UIButton，用於「再玩一次」的功能。
    var playAgainButton = UIButton()
    
    // 定義一個 UIView，用於製作圓形視覺效果或作為容器。
    let circleView = UIView()
    
    // 定義兩個 UIView，用作界面的上下容器。
    let topContainerView = UIView()
    let bottomContainerView = UIView()
    
    // 定義一個 UIStackView，用於底部按鈕的水平排列。
    let bottomStackView = UIStackView()
    
    // viewDidLoad 方法，當視圖控制器的視圖加載到記憶體後調用。
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 設置 circleView 的背景色為透明並關閉自動布局約束。
        circleView.backgroundColor = .clear
        circleView.translatesAutoresizingMaskIntoConstraints = false
        
        // 為 topContainerView 設置背景色、邊框顏色和寬度，並關閉自動布局約束。
        topContainerView.backgroundColor = .systemRed
        topContainerView.layer.borderColor = UIColor.black.cgColor
        topContainerView.layer.borderWidth = 10
        topContainerView.translatesAutoresizingMaskIntoConstraints = false
        
        // 為 bottomContainerView 設置背景色、邊框顏色和寬度，並關閉自動布局約束。
        bottomContainerView.backgroundColor = .white
        bottomContainerView.layer.borderColor = UIColor.black.cgColor
        bottomContainerView.layer.borderWidth = 10
        bottomContainerView.translatesAutoresizingMaskIntoConstraints = false
        
        // 設置 bottomStackView 的軸向、間隔、對齊方式、分配方式和自動布局約束。
        bottomStackView.axis = .horizontal
        bottomStackView.spacing = 10
        bottomStackView.alignment = .center
        bottomStackView.distribution = .equalCentering
        bottomStackView.translatesAutoresizingMaskIntoConstraints = false
        
        // 關閉 player01ImageView、player02ImageView 和 player02HeadImageView 的自動布局約束。
        player01ImageView.translatesAutoresizingMaskIntoConstraints = false
        player02ImageView.translatesAutoresizingMaskIntoConstraints = false
        player02HeadImageView.translatesAutoresizingMaskIntoConstraints = false
        
        // 循環創建三個元素按鈕（火、草、水）並添加到陣列中。
        for i in 0...2 {
            let button = makeElementButton(number: i)
            player01ElementButtons.append(button)
        }
        
        // 設置狀態標籤的文字對齊方式、顏色和自動布局約束。
        statusLabel.textAlignment = .center
        statusLabel.textColor = .black
        statusLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // 設置“再玩一次”按鈕的標題、顏色、背景色、字體、圓角、顯示狀態和自動布局約束。
        // 並添加觸摸事件的處理方法。
        playAgainButton.setTitle("  Play Again  ", for: .normal)
        playAgainButton.setTitleColor(.black, for: .normal)
        playAgainButton.backgroundColor = .systemRed
        playAgainButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        playAgainButton.layer.cornerRadius = 10
        playAgainButton.isHidden = true
        playAgainButton.isEnabled = false
        playAgainButton.addTarget(self, action: #selector(playAgainButtonTouched(_:)), for: .touchDown)
        playAgainButton.addTarget(self, action: #selector(playAgainButtonReleased(_:)), for: [.touchUpInside, .touchUpOutside, .touchCancel])
        playAgainButton.translatesAutoresizingMaskIntoConstraints = false
        
        // 將所有視圖元素添加到主視圖中。
        view.addSubview(topContainerView)
        view.addSubview(bottomContainerView)
        view.addSubview(circleView)
        view.addSubview(statusLabel)
        view.addSubview(player02HeadImageView)
        view.addSubview(bottomStackView)
        view.addSubview(playAgainButton)
        view.addSubview(player01ImageView)
        view.addSubview(player02ImageView)
        
        // 啟用自動布局約束以設置所有視圖元素的位置和大小。
        NSLayoutConstraint.activate([
            
            circleView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            circleView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            circleView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            circleView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            topContainerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            topContainerView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            topContainerView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            topContainerView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            topContainerView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.5),
            
            bottomContainerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            bottomContainerView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            bottomContainerView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            bottomContainerView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            bottomContainerView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.5),
            
            bottomStackView.centerXAnchor.constraint(equalTo: bottomContainerView.centerXAnchor),
            bottomStackView.leadingAnchor.constraint(equalTo: bottomContainerView.leadingAnchor, constant: 20),
            bottomStackView.trailingAnchor.constraint(equalTo: bottomContainerView.trailingAnchor, constant: -20),
            bottomStackView.topAnchor.constraint(equalTo: bottomContainerView.topAnchor, constant: 140),
            bottomStackView.bottomAnchor.constraint(equalTo: bottomContainerView.bottomAnchor, constant: -140),
            
            player01ImageView.leadingAnchor.constraint(equalTo: bottomContainerView.leadingAnchor, constant: 40),
            player01ImageView.centerYAnchor.constraint(equalTo: bottomContainerView.centerYAnchor),
            player01ImageView.widthAnchor.constraint(equalTo: bottomContainerView.widthAnchor, multiplier: 0.5),
            player01ImageView.heightAnchor.constraint(equalTo: bottomContainerView.heightAnchor, multiplier: 0.5),
            
            player02ImageView.trailingAnchor.constraint(equalTo: topContainerView.trailingAnchor, constant: -50),
            player02ImageView.centerYAnchor.constraint(equalTo: topContainerView.centerYAnchor),
            player02ImageView.widthAnchor.constraint(equalTo: topContainerView.widthAnchor, multiplier: 0.52),
            player02ImageView.heightAnchor.constraint(equalTo: topContainerView.heightAnchor, multiplier: 0.52),
            
            player02HeadImageView.centerXAnchor.constraint(equalTo: topContainerView.centerXAnchor),
            player02HeadImageView.centerYAnchor.constraint(equalTo: topContainerView.centerYAnchor),
            player02HeadImageView.widthAnchor.constraint(equalTo: topContainerView.widthAnchor, multiplier: 0.5),
            player02HeadImageView.heightAnchor.constraint(equalTo: topContainerView.heightAnchor, multiplier: 0.5),
            
            statusLabel.centerXAnchor.constraint(equalTo: circleView.centerXAnchor),
            statusLabel.centerYAnchor.constraint(equalTo: circleView.centerYAnchor),
            
            playAgainButton.centerXAnchor.constraint(equalTo: bottomContainerView.centerXAnchor),
            playAgainButton.bottomAnchor.constraint(equalTo: bottomContainerView.bottomAnchor, constant: -30),
            
        ])
        // 根據遊戲的初始狀態更新用戶界面。
        updateUI(forState: .start)
    }
    
    // 當視圖完全出現在螢幕上後，調用此方法。
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // 呼叫自訂方法來創建圓形視覺效果。
        makeCircle()
    }
    
    
    
    // MARK: - Function
    
    
    
    // 自定義方法，用於創建圓形視覺效果。
    func makeCircle() {
        // 計算圓心位置。
        let centerPoint = CGPoint(x: circleView.bounds.midX, y: circleView.bounds.midY)
        let aDegree = Double.pi / 180
        // 創建一個圓形的 UIBezierPath。
        let circlePath1 = UIBezierPath()
        circlePath1.addArc(withCenter: centerPoint, radius: view.bounds.height / 15, startAngle: aDegree * 0, endAngle: aDegree * 360, clockwise: true)
        
        // 創建一個 CAShapeLayer 來展示這個圓形路徑。
        let circleLayer1 = CAShapeLayer()
        circleLayer1.path = circlePath1.cgPath
        circleLayer1.fillColor = UIColor.white.cgColor
        circleLayer1.strokeColor = UIColor.black.cgColor
        circleLayer1.lineWidth = 15
        
        // 將圓形 layer 添加到 circleView 上。
        circleView.layer.addSublayer(circleLayer1)
    }
    
    
    
    // 根據遊戲狀態更新界面。
    func updateUI(forState state: GameState) {
        // 設置狀態標籤的文本。
        statusLabel.text = state.status
        
        // 初始化某些視覺元素的狀態。
        self.statusLabel.alpha = 0
        self.statusLabel.font = UIFont.boldSystemFont(ofSize: 6.5)
        self.player02HeadImageView.center.x = -110
        
        // 使用動畫來平滑過渡視覺元素的改變。
        UIView.animate(withDuration: 1) {
            self.statusLabel.alpha = 1
            self.statusLabel.transform = CGAffineTransform(scaleX: 2, y: 2)
            self.bottomStackView.transform = CGAffineTransform(scaleX: 0.65, y: 0.65)
            self.bottomStackView.transform = CGAffineTransform(scaleX: 1, y: 1)
            self.player02HeadImageView.center.x = self.topContainerView.center.x
        }
        
        // 根據不同的遊戲狀態，更新界面元素。
        switch state {
            // 遊戲開始時的界面設定。
        case .start:
            for button in player01ElementButtons {
                button.isHidden = false
                button.isEnabled = true
            }
            
            player02HeadImageView.image = UIImage(named: "player02")
            
            player02ImageView.isHidden = true
            player01ImageView.isHidden = true
            
            playAgainButton.isHidden = true
            playAgainButton.isEnabled = false
            
        case .win:
            print("win")
            
        case .lose:
            print("lose")
            
        case .draw:
            print("draw")
        }
        
    }
    
    
    
    // 自定義方法，用於創建元素按鈕。
    func makeElementButton(number: Int) -> UIButton {
        let button = UIButton()
        // 根據傳入的數字設置按鈕的圖片和標籤。
        
        switch number {
            // 設置按鈕的圖片和標籤。
        case 0 :
            button.setImage(UIImage(named: "fire"), for: .normal)
            button.tag = 0
        case 1 :
            button.setImage(UIImage(named: "grass"), for: .normal)
            button.tag = 1
        case 2 :
            button.setImage(UIImage(named: "water"), for: .normal)
            button.tag = 2
        default :
            break
        }
        // 添加事件處理和配置按鈕布局。
        button.addTarget(self, action: #selector(elementButtonTouched(_:)), for: .touchDown)
        button.addTarget(self, action: #selector(elementButtonReleased(_:)), for: [.touchUpInside, .touchUpOutside, .touchCancel])
        
        // 把按鈕添加到底部的 stack view 中。
        bottomStackView.addArrangedSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalTo: button.widthAnchor).isActive = true
        return button
    }
    
    
    
    // 定義一個戰鬥方法，用於處理遊戲的戰鬥邏輯。
    func fight(userElement: Element) {
        // 更新界面元素以反映戰鬥的開始。
        for button in player01ElementButtons {
            button.isHidden = true
            button.isEnabled = false
        }
        
        player02ImageView.isHidden = false
        player01ImageView.isHidden = false
        
        player02HeadImageView.image = nil
        
        playAgainButton.isHidden = false
        playAgainButton.isEnabled = true
        
        // 隨機產生對手的元素，並根據遊戲規則判斷勝負。
        let player02RandomElement = randomElement()
        
        let gameState = userElement.gameState(against: player02RandomElement)
        updateUI(forState: gameState)
        
        // 設置玩家和對手的 GIF 圖片。
        player01ImageView.setGifImage(userElement.player01)
        player02ImageView.setGifImage(player02RandomElement.player02)
        
    }
    
    
    
    // MARK: - @objc function
    
    
    
    // 當元素按鈕被觸摸時執行的方法。
    @objc func elementButtonTouched(_ sender: UIButton) {
        // 使用動畫來縮小按鈕，為用戶提供視覺反饋。
        UIView.animate(withDuration: 0.1) {
            sender.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        }
    }
    
    // 當元素按鈕觸摸結束時執行的方法。
    @objc func elementButtonReleased(_ sender: UIButton) {
        // 使用動畫將按鈕恢復到原始大小。
        UIView.animate(withDuration: 0.1) {
            sender.transform = CGAffineTransform.identity
        }
        
        // 根據按鈕的標籤來決定玩家選擇的元素，並進行戰鬥。
        switch sender.tag {
        case 0:
            fight(userElement: .fire)
        case 1:
            fight(userElement: .grass)
        case 2:
            fight(userElement: .water)
        default:
            break
        }
    }
    
    // 當“再玩一次”按鈕被觸摸時執行的方法。
    @objc func playAgainButtonTouched(_ sender: UIButton) {
        // 使用動畫來縮小按鈕，為用戶提供視覺反饋。
        UIView.animate(withDuration: 0.1) {
            sender.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        }
    }
    
    // 當“再玩一次”按鈕觸摸結束時執行的方法。
    @objc func playAgainButtonReleased(_ sender: UIButton) {
        // 使用動畫將按鈕恢復到原始大小。
        UIView.animate(withDuration: 0.1) {
            sender.transform = CGAffineTransform.identity
        }
        
        // 重置遊戲狀態為開始。
        updateUI(forState: .start)
    }
    
    
    
}
