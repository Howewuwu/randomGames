//
//  ticTacToeViewController.swift
//  randomGames
//
//  Created by Howe on 2023/12/5.

// MARK: - enum setting



// 玩家類型的枚舉，有人類和電腦兩種選項
enum Player {
    case human
    case computer
}



// 標記類型的枚舉，用於表示井字遊戲中的棋盤格狀態，包括無標記、圓圈、叉叉
enum MarkType {
    case none
    case circle
    case cross
}



// 引入UIKit框架，這是開發iOS應用程序的基礎框架
import UIKit

// 定義一個繼承自UIViewController的新類別，用於實現井字遊戲的視圖控制器
class ticTacToeViewController: UIViewController {
    
    // 創建一個容器stack view，用於安排遊戲中的各個元素
    var containerStackView = UIStackView()
    // 創建三個水平stack view，分別代表井字遊戲的三行
    var oneRowStackView = UIStackView()
    var twoRowStackView = UIStackView()
    var threeRowStackView = UIStackView()
    
    // 定義一個變量來追踪當前的玩家，初始設為人類玩家
    var currentPlayer: Player = .human
    
    // 定義一個陣列來追踪遊戲的狀態，共九個格子，初始為未標記
    var gameState: [MarkType] = [.none, .none, .none, .none, .none, .none, .none, .none, .none]
    
    // 定義一個陣列用於存儲九個遊戲按鈕
    var OXButtons = [UIButton]()
    
    // 創建一個重新開始遊戲的按鈕
    var playAgainButton = UIButton()
    
    // 創建一個用於顯示遊戲結果的標籤
    var resultLabel = UILabel()
    
    
    
    // 覆寫UIViewController的viewDidLoad方法，這是視圖控制器加載其視圖時呼叫的方法
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // 設定主視圖的背景顏色為黑色
        view.backgroundColor = .black
        
        
        // 設定容器Stack View的屬性，包括背景顏色、邊框、對齊方式等
        containerStackView.backgroundColor = .white
        containerStackView.layer.borderColor = UIColor.white.cgColor
        containerStackView.layer.borderWidth = 3
        containerStackView.axis = .vertical
        containerStackView.spacing = 5
        containerStackView.alignment = .fill
        containerStackView.distribution = .fillEqually
        containerStackView.translatesAutoresizingMaskIntoConstraints = false
        
        
        // 為每一行的Stack View設定屬性，包括背景顏色、軸向、間距等
        // 這些設定對於一行、二行和三行Stack View都相同
        oneRowStackView.backgroundColor = .clear
        oneRowStackView.axis = .horizontal
        oneRowStackView.spacing = 5
        oneRowStackView.alignment = .fill
        oneRowStackView.distribution = .fillEqually
        oneRowStackView.translatesAutoresizingMaskIntoConstraints = false
        
        twoRowStackView.backgroundColor = .clear
        twoRowStackView.axis = .horizontal
        twoRowStackView.spacing = 5
        twoRowStackView.alignment = .fill
        twoRowStackView.distribution = .fillEqually
        twoRowStackView.translatesAutoresizingMaskIntoConstraints = false
        
        threeRowStackView.backgroundColor = .clear
        threeRowStackView.axis = .horizontal
        threeRowStackView.spacing = 5
        threeRowStackView.alignment = .fill
        threeRowStackView.distribution = .fillEqually
        threeRowStackView.translatesAutoresizingMaskIntoConstraints = false
        
        
        // 為重新開始遊戲的按鈕設定屬性，包括標題、顏色、字體、邊角半徑等
        // 並將其設為初始隱藏和禁用狀態
        playAgainButton.setTitle("   PLAY AGAIN!   ", for: .normal)
        playAgainButton.setTitleColor(.black, for: .normal)
        playAgainButton.backgroundColor = .white
        playAgainButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        playAgainButton.layer.cornerRadius = 12
        playAgainButton.isHidden = true
        playAgainButton.isEnabled = false
        playAgainButton.addTarget(self, action: #selector(playAgainButtonTouched(_:)), for: .touchDown)
        playAgainButton.addTarget(self, action: #selector(playAgainButtonReleased(_:)), for: [.touchUpInside, .touchUpOutside, .touchCancel])
        playAgainButton.translatesAutoresizingMaskIntoConstraints = false
        
        
        // 為結果標籤設定屬性，包括文字、字體、背景顏色、文字顏色等
        // 並將其設為初始隱藏狀態
        resultLabel.text = ""
        resultLabel.font = UIFont.boldSystemFont(ofSize: 80)
        resultLabel.backgroundColor = .clear
        resultLabel.textColor = .white
        resultLabel.isHidden = true
        resultLabel.translatesAutoresizingMaskIntoConstraints = false
        
        
        // 將容器Stack View和其他元素添加到主視圖中
        // 並為它們設定Auto Layout約束
        view.addSubview(containerStackView)
        containerStackView.addArrangedSubview(oneRowStackView)
        containerStackView.addArrangedSubview(twoRowStackView)
        containerStackView.addArrangedSubview(threeRowStackView)
        view.addSubview(playAgainButton)
        view.addSubview(resultLabel)
        
        
        
        NSLayoutConstraint.activate([
            // 設定容器Stack View的約束
            containerStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            containerStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            containerStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            containerStackView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.5),
            
            // 設定重新開始遊戲按鈕的約束
            playAgainButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            playAgainButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30),
            
            // 設定結果標籤的約束
            resultLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            resultLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -140)
            
        ])
        
        
        
        // 遍歷數字1到9，為井字遊戲的每個格子創建一個按鈕
        for number in 1...9 {
            // 調用createButton函數創建一個新的按鈕，並將數字作為參數傳遞
            // 這個數字用於標識按鈕，並將其用於遊戲邏輯中
            let button: UIButton = createButton(number: number)
            // 將創建的按鈕添加到OXButtons陣列中
            // OXButtons陣列用於存儲遊戲中的所有按鈕，以便於後續訪問和操作
            OXButtons.append(button)
        }
        
        
    }
    
    
    
    // MARK: - Function
    
    
    
    // 定義一個函數用於創建遊戲中的按鈕
    func createButton(number: Int) -> UIButton {
        
        // 使用UIButton的Configuration來定制按鈕的外觀和行為
        var config = UIButton.Configuration.tinted()
        config.background.backgroundColor = .black
        config.background.imageContentMode = .scaleAspectFit
        
        // 使用配置創建一個UIButton
        let button = UIButton(configuration: config)
        
        // 設置按鈕的標籤，這將用於識別按鈕和處理遊戲邏輯
        button.tag = number
        button.tintColor = .white
        
        // 為按鈕添加觸摸事件，當按鈕被按下和釋放時觸發相應的方法
        button.addTarget(self, action: #selector(ButtonTouched(_:)), for: .touchDown)
        button.addTarget(self, action: #selector(ButtonReleased(_:)), for: [.touchUpInside, .touchUpOutside, .touchCancel])
        
        // 根據按鈕的編號將它們添加到對應的行Stack View中
        switch number {
        case 1, 2, 3:
            oneRowStackView.addArrangedSubview(button)
        case 4, 5, 6:
            twoRowStackView.addArrangedSubview(button)
        case 7, 8, 9:
            threeRowStackView.addArrangedSubview(button)
        default:
            break
        }
        button.translatesAutoresizingMaskIntoConstraints = false
        
        // 返回創建的按鈕
        return button
    }
    
    
    
    // 定義一個函數用於更改按鈕的背景圖片
    func switchBackgroundImage(type: MarkType, at index: Int) {
        
        // 再次使用UIButton的Configuration來定制按鈕的外觀
        var config = UIButton.Configuration.tinted()
        config.background.backgroundColor = .black
        config.background.imageContentMode = .scaleAspectFit
        
        // 根據傳入的標記類型，為按鈕設定不同的背景圖片
        switch type {
        case .none:
            config.background.image = UIImage(systemName: "")
            OXButtons[index].configuration = config
        case .circle:
            config.background.image = UIImage(systemName: "circlebadge")
            OXButtons[index].configuration = config
        case .cross:
            config.background.image = UIImage(systemName: "xmark")
            OXButtons[index].configuration = config
        }
        
    }
    
    
    
    // 定義一個函數用於檢查勝利條件
    func checkForVictory(_ markType: MarkType) -> Bool {
        // 定義贏得遊戲的所有可能模式：三橫、三豎和兩斜
        let winPatterns: [[Int]] = [
            [0, 1, 2], [3, 4, 5], [6, 7, 8], // 橫排
            [0, 3, 6], [1, 4, 7], [2, 5, 8], // 豎排
            [0, 4, 8], [2, 4, 6]            // 斜排
        ]
        
        // 遍歷每種勝利模式，檢查是否有滿足當前markType的模式
        for pattern in winPatterns {
            if pattern.allSatisfy({ gameState[$0] == markType }) {
                return true // 如果找到一種勝利模式，則返回true
            }
        }
        return false // 如果沒有找到勝利模式，則返回false
    }
    
    
    
    // 定義一個函數用於電腦玩家的動作
    func computerMove() {
        // 創建一個陣列來存儲所有空的格子
        var availableSpaces = [Int]()
        for (index, mark) in gameState.enumerated() {
            if mark == .none {
                availableSpaces.append(index) // 將空格子的索引添加到陣列中
            }
        }
        
        // 從可用的空格子中隨機選擇一個
        if let randomSpace = availableSpaces.randomElement() {
            // 在選中的位置放置電腦玩家的標記（叉叉）
            gameState[randomSpace] = .cross
            switchBackgroundImage(type: .cross, at: randomSpace)
        }
        
        currentPlayer = .human
        
    }
    
    
    
    
    // 定義一個函數用於重設遊戲到初始狀態
    func resetGame() {
        // 重設遊戲狀態陣列，將所有格子設為未標記狀態
        gameState = [.none, .none, .none, .none, .none, .none, .none, .none, .none]
        
        // 將當前玩家設為人類玩家
        currentPlayer = .human
        
        // 遍歷遊戲中的每個按鈕
        for i in 0...8 {
            // 啟用按鈕，讓它們可以被點擊
            OXButtons[i].isEnabled = true
            // 將每個按鈕的背景圖片重設為無
            switchBackgroundImage(type: .none, at: i)
        }
        
        // 將重新開始遊戲的按鈕設為隱藏並禁用
        playAgainButton.isHidden = true
        playAgainButton.isEnabled = false
        
        // 將結果標籤設為隱藏
        resultLabel.isHidden = true
    }
    
    
    
    // MARK: - @objc Function
    
    
    
    // 定義一個Objective-C方法來處理按鈕被觸摸的事件
    @objc func ButtonTouched(_ sender: UIButton) {
        // 使用UIView的animate方法來創建一個短暫的動畫
        // 此動畫會讓按鈕稍微縮小，給用戶一種按下按鈕的視覺反饋
        UIView.animate(withDuration: 0.1) {
            sender.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        }
    }
    
    // 定義一個Objective-C方法來處理按鈕觸摸事件結束的情況
    @objc func ButtonReleased(_ sender: UIButton) {
        // 恢復按鈕的原始大小，取消縮放效果
        UIView.animate(withDuration: 0.1) {
            sender.transform = CGAffineTransform.identity
        }
        
        // 檢查當前被觸摸的按鈕對應的遊戲狀態是否為空
        if gameState[sender.tag - 1] == .none {
            // 根據當前玩家更新遊戲狀態和按鈕的背景圖片
            gameState[sender.tag - 1] = (currentPlayer == .human) ? .circle : .cross
            switchBackgroundImage(type: (currentPlayer == .human) ? .circle : .cross, at: sender.tag - 1)
            
            // 檢查是否有玩家贏得了遊戲
            if checkForVictory(currentPlayer == .human ? .circle : .cross) {
                // 如果有玩家贏了，更新UI元件的狀態
                playAgainButton.isHidden = false
                playAgainButton.isEnabled = true
                for button in OXButtons {
                    button.isEnabled = false
                }
                resultLabel.isHidden = false
                resultLabel.text = " \(MarkType.circle) won! "
            } else {
                // 如果沒有玩家贏，切換到另一個玩家
                currentPlayer = (currentPlayer == .human) ? .computer : .human
                // 如果換到電腦玩家，則執行電腦的行動
                if currentPlayer == .computer {
                    computerMove()
                    if checkForVictory(.cross) {
                        playAgainButton.isHidden = false
                        playAgainButton.isEnabled = true
                        for button in OXButtons {
                            button.isEnabled = false
                        }
                        resultLabel.isHidden = false
                        resultLabel.text = " \(MarkType.cross) won! "
                    }
                }
                
                // 檢查是否遊戲結果為平局
                let isTie = gameState.allSatisfy { $0 != .none }
                if isTie {
                    // 如果是平局，更新UI元件的狀態
                    playAgainButton.isHidden = false
                    playAgainButton.isEnabled = true
                    for button in OXButtons {
                        button.isEnabled = false
                    }
                    resultLabel.isHidden = false
                    resultLabel.text = " TIE "
                }
            }
        }
    }
    
    
    
    // 定義一個Objective-C方法來處理重新開始按鈕被觸摸的事件
    @objc func playAgainButtonTouched(_ sender: UIButton) {
        // 使用UIView的animate方法創建一個動畫，使按鈕在被觸摸時縮小，提供視覺反饋
        UIView.animate(withDuration: 0.1) {
            sender.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        }
    }
    
    
    
    // 定義一個Objective-C方法來處理重新開始按鈕觸摸結束的事件
    @objc func playAgainButtonReleased(_ sender: UIButton) {
        // 恢復按鈕的原始大小，取消縮放效果
        UIView.animate(withDuration: 0.1) {
            sender.transform = CGAffineTransform.identity
        }
        // 呼叫resetGame函數重設遊戲狀態
        resetGame()
    }
    
    
    
}
