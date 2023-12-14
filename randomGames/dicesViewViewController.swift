//
//  dicesViewViewController.swift
//  randomGames
//
//  Created by Howe on 2023/12/5.
//

import UIKit

class dicesViewViewController: UIViewController {
    
    // UI元件宣告區
    var topContainerView: UIView! // 頂部容器視圖，用於容納上半部分的其他UI元件
    var topStackView: UIStackView! // 一個垂直堆疊視圖，用於在頂部容器中組織元件
    
    var topUpLabel: UILabel! // 標籤，顯示在頂部堆疊視圖的最上方，用於顯示遊戲狀態或指示
    var topMiddleView: UIView! // 一個中間視圖，用於容納骰子和擲骰按鈕
    
    var cupImageView: UIImageView! // 用於顯示骰子杯的圖片視圖
    var rollButton: UIButton! // 用於觸發擲骰動作的按鈕
    
    let randomDicesStackView = UIStackView() // 用於顯示骰子圖像的水平堆疊視圖
    var randomDices = [UIImageView]() // 存儲骰子圖像的陣列
    var randomDice1 = UIImageView() // 第一個骰子圖像
    var randomDice2 = UIImageView() // 第二個骰子圖像
    var randomDice3 = UIImageView() // 第三個骰子圖像
    
    var randomNumerArray = [Int]() // 存儲隨機骰子數字的陣列
    var thirdSameDices = false // 標記是否擲出了三個相同的骰子
    var totalNumber = 0 // 骰子數字總和
    
    var bottomContainerView: UIView! // 底部容器視圖，用於容納下半部分的其他UI元件
    var bottomStackView: UIStackView! // 一個水平堆疊視圖，用於在底部容器中組織元件
    
    var biggerNumberButton = UIButton() // “大”按鈕，用於下注骰子點數和
    var smallerNumberButton = UIButton() // “小”按鈕，用於下注骰子點數和
    var numberThirdDiceButtons = [UIButton]() // 存儲用豹子按鈕的陣列
    
    var oneThreeFiveStackView: UIStackView! // 用於組織1、3、5數字按鈕的垂直堆疊視圖
    var oneThirdDicesButton = UIButton() // “豹子1”數字按鈕
    var threeThirdDicesButton = UIButton() // “豹子3”數字按鈕
    var fiveThirdDicesButton = UIButton() // “豹子5”數字按鈕
    
    var twoFourSixStackView: UIStackView! // 用於組織2、4、6數字按鈕的垂直堆疊視圖
    var twoThirdDicesButton = UIButton() // “豹子2”數字按鈕
    var fourThirdDicesButton = UIButton() // “豹子4”數字按鈕
    var sixThirdDicesButton = UIButton() // “豹子6”數字按鈕
    
    var time = Timer() // 用於控制動畫或遊戲邏輯的計時器
    var played = false // 標記是否已進行過遊戲
    var rolled = false // 標記是否已經擲過骰子
    
    
    
    // MARK: - viewDidLoad
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 設定視圖控制器的背景顏色為黑色
        view.backgroundColor = .black
        
        
        
        // 初始化頂部容器視圖
        topContainerView = UIView()
        topContainerView.translatesAutoresizingMaskIntoConstraints = false // 關閉自動佈局約束，以便手動設置約束
        topContainerView.layer.borderWidth = 1.5 // 為視圖設置邊框寬度
        topContainerView.layer.borderColor = UIColor.white.cgColor // 設置邊框顏色為白色
        view.addSubview(topContainerView) // 將頂部容器視圖添加到主視圖
        
        // 設置頂部容器視圖的約束
        NSLayoutConstraint.activate([
            topContainerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor), // 頂部與安全區頂部對齊
            topContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor), // 左側與主視圖左側對齊
            topContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor), // 右側與主視圖右側對齊
            topContainerView.centerXAnchor.constraint(equalTo: view.centerXAnchor), // 水平中心與主視圖中心對齊
            topContainerView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.4) // 高度為安全區高度的40%
        ])
        
        // 初始化頂部堆疊視圖
        topStackView = UIStackView()
        topStackView.axis = .vertical // 設置堆疊軸為垂直
        topStackView.spacing = 5 // 設置堆疊視圖中元件的間距
        topStackView.alignment = .fill // 元件填滿整個堆疊視圖
        topStackView.distribution = .equalSpacing // 元件之間的間距均等
        topStackView.translatesAutoresizingMaskIntoConstraints = false // 關閉自動佈局約束
        topContainerView.addSubview(topStackView) // 將堆疊視圖添加到頂部容器視圖
        
        // 設置頂部堆疊視圖的約束
        NSLayoutConstraint.activate([
            topStackView.topAnchor.constraint(equalTo: topContainerView.topAnchor, constant: 5), // 頂部與容器頂部對齊，並設定5點的間距
            topStackView.bottomAnchor.constraint(equalTo: topContainerView.bottomAnchor), // 底部與容器底部對齊
            topStackView.leadingAnchor.constraint(equalTo: topContainerView.leadingAnchor), // 左側與容器左側對齊
            topStackView.trailingAnchor.constraint(equalTo: topContainerView.trailingAnchor) // 右側與容器右側對齊
        ])
        
        
        
        
        // 初始化並設定顯示在頂部堆疊視圖上方的標籤
        topUpLabel = UILabel()
        topUpLabel.text = "來擲骰" // 設置標籤的文字
        topUpLabel.font = .boldSystemFont(ofSize: 30) // 設置字體為粗體，大小為30
        topUpLabel.textAlignment = .center // 文字置中對齊
        topUpLabel.numberOfLines = 0 // 允許多行顯示
        topUpLabel.textColor = .white // 文字顏色設為白色
        topUpLabel.translatesAutoresizingMaskIntoConstraints = false // 關閉自動佈局約束
        topStackView.addArrangedSubview(topUpLabel) // 將標籤加入頂部堆疊視圖
        
        // 初始化並設定頂部中間的視圖
        topMiddleView = UIView()
        topMiddleView.backgroundColor = .white // 設置背景顏色為白色
        topMiddleView.translatesAutoresizingMaskIntoConstraints = false // 關閉自動佈局約束
        topStackView.addArrangedSubview(topMiddleView) // 將中間視圖加入頂部堆疊視圖
        
        // 初始化並設定用於顯示骰子杯的圖片視圖
        cupImageView = UIImageView(image: UIImage(named: "cup")) // 加載名為"cup"的圖片
        cupImageView.translatesAutoresizingMaskIntoConstraints = false // 關閉自動佈局約束
        
        // 初始化並設定擲骰按鈕
        rollButton = UIButton()
        rollButton.setTitle("擲骰", for: .normal) // 設置按鈕文字
        rollButton.backgroundColor = .black // 背景顏色設為黑色
        rollButton.setTitleColor(.white, for: .normal) // 文字顏色為白色
        rollButton.setTitleColor(.lightGray, for: .highlighted) // 高亮狀態下文字顏色為淺灰色
        rollButton.translatesAutoresizingMaskIntoConstraints = false // 關閉自動佈局約束
        rollButton.addTarget(self, action: #selector(rollButtonReleased(_:)), for: [.touchUpInside, .touchUpOutside, .touchCancel]) // 設定按鈕觸發的動作
        
        // 初始化並設定用於顯示骰子的圖片視圖陣列
        randomDices = [randomDice1, randomDice2, randomDice3] // 將三個骰子圖片視圖存入陣列
        // 分別設定每個骰子的顏色和佈局約束
        randomDice1.tintColor = .black
        randomDice2.tintColor = .black
        randomDice3.tintColor = .black
        randomDice1.translatesAutoresizingMaskIntoConstraints = false
        randomDice2.translatesAutoresizingMaskIntoConstraints = false
        randomDice3.translatesAutoresizingMaskIntoConstraints = false
        
        
        
        // 設定用於顯示骰子的堆疊視圖
        randomDicesStackView.axis = .horizontal // 設定為水平軸向
        randomDicesStackView.distribution = .fillEqually // 元件均等填充
        randomDicesStackView.alignment = .center // 中心對齊
        randomDicesStackView.spacing = 1 // 元件間的間距設為1
        randomDicesStackView.translatesAutoresizingMaskIntoConstraints = false // 關閉自動佈局約束
        // 將骰子圖片視圖添加到堆疊視圖中
        randomDicesStackView.addArrangedSubview(randomDice1)
        randomDicesStackView.addArrangedSubview(randomDice2)
        randomDicesStackView.addArrangedSubview(randomDice3)
        
        // 將骰子堆疊視圖、骰子杯圖片視圖和擲骰按鈕添加到中間視圖中
        topMiddleView.addSubview(randomDicesStackView)
        topMiddleView.addSubview(cupImageView)
        topMiddleView.addSubview(rollButton)
        
        // 設定骰子杯圖片視圖和擲骰按鈕的佈局約束
        NSLayoutConstraint.activate([
            cupImageView.centerXAnchor.constraint(equalTo: topMiddleView.centerXAnchor),
            cupImageView.bottomAnchor.constraint(equalTo: topMiddleView.bottomAnchor, constant: -45),
            cupImageView.heightAnchor.constraint(equalTo: topMiddleView.heightAnchor, multiplier: 0.6),
            cupImageView.widthAnchor.constraint(equalTo: topMiddleView.widthAnchor, multiplier: 0.5),
            
            rollButton.centerXAnchor.constraint(equalTo: topMiddleView.centerXAnchor),
            rollButton.widthAnchor.constraint(equalTo: cupImageView.widthAnchor, multiplier: 0.5),
            rollButton.bottomAnchor.constraint(equalTo: topMiddleView.bottomAnchor, constant: -10),
            
            randomDicesStackView.centerXAnchor.constraint(equalTo: topMiddleView.centerXAnchor),
            randomDicesStackView.bottomAnchor.constraint(equalTo: topMiddleView.bottomAnchor, constant: -75)
        ])
        
        // 初始化底部容器視圖
        bottomContainerView = UIView()
        bottomContainerView.translatesAutoresizingMaskIntoConstraints = false // 關閉自動佈局約束
        bottomContainerView.layer.borderWidth = 2.5 // 設置邊框寬度
        view.addSubview(bottomContainerView) // 將底部容器視圖添加到主視圖
        
        // 設定底部容器視圖的佈局約束
        NSLayoutConstraint.activate([
            bottomContainerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            bottomContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bottomContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bottomContainerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            bottomContainerView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.6)
        ])
        
        // 初始化底部堆疊視圖
        bottomStackView = UIStackView()
        bottomStackView.axis = .horizontal // 設定為水平軸向
        bottomStackView.spacing = 1 // 元件間的間距設為1
        bottomStackView.alignment = .fill // 元件填滿整個堆疊視圖
        bottomStackView.distribution = .fillEqually // 元件均等分配
        bottomStackView.translatesAutoresizingMaskIntoConstraints = false // 關閉自動佈局約束
        bottomContainerView.addSubview(bottomStackView) // 將底部堆疊視圖添加到底部容器視圖
        
        // 設定底部堆疊視圖的佈局約束
        NSLayoutConstraint.activate([
            bottomStackView.topAnchor.constraint(equalTo: bottomContainerView.topAnchor),
            bottomStackView.bottomAnchor.constraint(equalTo: bottomContainerView.bottomAnchor),
            bottomStackView.leadingAnchor.constraint(equalTo: bottomContainerView.leadingAnchor),
            bottomStackView.trailingAnchor.constraint(equalTo: bottomContainerView.trailingAnchor)
        ])
        
        
        
        // 初始化並設定兩個垂直堆疊視圖，分別用於放置不同數字的按鈕
        // 1、3、5號按鈕的堆疊視圖
        oneThreeFiveStackView = UIStackView()
        oneThreeFiveStackView.axis = .vertical // 垂直方向
        oneThreeFiveStackView.spacing = 1 // 元件間距為1
        oneThreeFiveStackView.alignment = .fill // 填滿整個堆疊視圖
        oneThreeFiveStackView.distribution = .fillEqually // 等分分配空間
        oneThreeFiveStackView.translatesAutoresizingMaskIntoConstraints = false // 關閉自動佈局約束
        
        // 2、4、6號按鈕的堆疊視圖
        twoFourSixStackView = UIStackView()
        twoFourSixStackView.axis = .vertical // 垂直方向
        twoFourSixStackView.spacing = 1 // 元件間距為1
        twoFourSixStackView.alignment = .fill // 填滿整個堆疊視圖
        twoFourSixStackView.distribution = .fillEqually // 等分分配空間
        twoFourSixStackView.translatesAutoresizingMaskIntoConstraints = false // 關閉自動佈局約束
        
        // 初始化並設定“大”按鈕的屬性
        biggerNumberButton.setTitle("大", for: .normal) // 設定按鈕文字
        biggerNumberButton.backgroundColor = .white // 背景顏色為白色
        biggerNumberButton.setTitleColor(.black, for: .normal) // 正常狀態下文字顏色為黑色
        biggerNumberButton.setTitleColor(.lightGray, for: .highlighted) // 高亮狀態下文字顏色為淺灰色
        biggerNumberButton.setTitleColor(.lightGray, for: .disabled) // 禁用狀態下文字顏色為淺灰色
        biggerNumberButton.addTarget(self, action: #selector(dicesButtonTouched(_:)), for: .touchDown)
        biggerNumberButton.addTarget(self, action: #selector(dicesButtonReleased(_:)), for: [.touchUpInside, .touchUpOutside, .touchCancel])
        biggerNumberButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 50) // 字體大小和樣式
        biggerNumberButton.tag = 7 // 設定標籤為7，用於識別
        
        // 初始化數字按鈕陣列，並為每個按鈕賦予特定的數字
        numberThirdDiceButtons = [oneThirdDicesButton, twoThirdDicesButton, threeThirdDicesButton, fourThirdDicesButton, fiveThirdDicesButton, sixThirdDicesButton]
        for n in 1...6 {
            numberThirdDiceButtons[n - 1] = createThirdDice(number: n)
        }
        
        // 初始化並設定“小”按鈕的屬性
        smallerNumberButton.setTitle("小", for: .normal) // 設定按鈕文字
        smallerNumberButton.backgroundColor = .white // 背景顏色為白色
        smallerNumberButton.setTitleColor(.black, for: .normal) // 正常狀態下文字顏色為黑色
        smallerNumberButton.setTitleColor(.lightGray, for: .highlighted) // 高亮狀態下文字顏色為淺灰色
        smallerNumberButton.setTitleColor(.lightGray, for: .disabled) // 禁用狀態下文字顏色為淺灰色
        smallerNumberButton.addTarget(self, action: #selector(dicesButtonTouched(_:)), for: .touchDown)
        smallerNumberButton.addTarget(self, action: #selector(dicesButtonReleased(_:)), for: [.touchUpInside, .touchUpOutside, .touchCancel])
        smallerNumberButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 50) // 字體大小和樣式
        smallerNumberButton.tag = 0 // 設定標籤為0，用於識別
        
        // 將“大”按鈕、1、3、5號按鈕堆疊視圖、2、4、6號按鈕堆疊視圖和“小”按鈕添加到底部堆疊視圖
        bottomStackView.addArrangedSubview(biggerNumberButton)
        bottomStackView.addArrangedSubview(oneThreeFiveStackView)
        bottomStackView.addArrangedSubview(twoFourSixStackView)
        bottomStackView.addArrangedSubview(smallerNumberButton)
        
        
        // 在視圖加載時關閉所有按鈕
        turnOffAllButtons()
        
    }
    
    
    
    // MARK: - function
    
    
    
    // 函數 `createDiceImage`: 用於創建並返回一個包含三個骰子圖像的UIImage物件
    func createDiceImage(systerName: String) -> UIImage? {
        // 創建一個圖形渲染器，設定圖像大小為寬90點，高30點
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 90, height: 30))
        // 使用渲染器生成圖像
        let image = renderer.image { ctx in
            // 根據提供的系統名稱，加載對應的骰子圖像（可能是SF符號）
            let diceImage = UIImage(systemName: systerName)
            // 設定單個骰子圖像的大小為寬30點，高30點
            let diceSize = CGSize(width: 30, height: 30)
            
            // 繪製三個骰子圖像，水平排列
            for i in 0..<3 {
                diceImage?.draw(in: CGRect(x: CGFloat(i * 30), y: 0, width: diceSize.width, height: diceSize.height))
            }
        }
        // 將生成的圖像設定為模板渲染模式，這允許它在不同狀態下適應顏色變化
        return image.withRenderingMode(.alwaysTemplate) // 設置圖像渲染模式為alwaysTemplate
        
        /*
         有時候，按鈕的圖像可能不會響應tintColor的變化，這可能是因為圖像的渲染模式設置不正確。你需要確保圖像的渲染模式設為.alwaysTemplate。
         在createDiceImage函數中，在返回圖像之前，嘗試將圖像的渲染模式設置為.alwaysTemplate。
         */
    }
    
    
    
    // 函數 `createThirdDice`: 創建並返回一個帶有骰子圖像的按鈕
    func createThirdDice(number: Int) -> UIButton {
        let button = UIButton() // 創建一個新的按鈕
        button.backgroundColor = .white // 設置按鈕背景顏色為白色
        // 使用前面定義的`createDiceImage`函數來生成骰子圖像，並將其設置為按鈕的圖像
        if let diceImage = createDiceImage(systerName: "die.face.\(number).fill") {
            button.setImage(diceImage, for: .normal)
        }
        button.tag = number // 設置按鈕的標籤，用於識別
        button.tintColor = .black // 設置圖像的著色為黑色
        // 為按鈕添加觸摸事件的處理
        button.addTarget(self, action: #selector(dicesButtonTouched(_:)), for: .touchDown)
        button.addTarget(self, action: #selector(dicesButtonReleased(_:)), for: [.touchUpInside, .touchUpOutside, .touchCancel])
        // 根據數字的奇偶性，將按鈕添加到不同的堆疊視圖中
        if number % 2 == 0 {
            twoFourSixStackView.addArrangedSubview(button)
        } else {
            oneThreeFiveStackView.addArrangedSubview(button)
        }
        return button // 返回創建的按鈕
    }
    
    
    
    // 函數 `turnOffAllButtons`: 禁用所有按鈕
    func turnOffAllButtons() {
        for button in numberThirdDiceButtons {
            button.isEnabled = false // 將每個數字按鈕設為不可用
        }
        // 將“大”和“小”按鈕設為不可用
        biggerNumberButton.isEnabled = false
        smallerNumberButton.isEnabled = false
    }
    
    
    
    // 函數 `turnOnAllButtons`: 啟用所有按鈕
    func turnOnAllButtons() {
        for button in numberThirdDiceButtons {
            button.isEnabled = true // 將每個數字按鈕設為可用
        }
        // 將“大”和“小”按鈕設為可用
        biggerNumberButton.isEnabled = true
        smallerNumberButton.isEnabled = true
    }
    
    
    
    // 函數 `scaleRandomDices`: 對骰子圖像進行縮放動畫
    func scaleRandomDices (number: CGFloat) {
        let scale: CGFloat = number // 縮放的大小
        // 使用動畫改變骰子堆疊視圖的縮放比例
        UIView.animate(withDuration: 2, animations: {
            self.randomDicesStackView.transform = CGAffineTransform(scaleX: scale, y: scale)
        })
    }
    
    
    
    // MARK: - @objc function
    
    
    
    // 函數 `calculateAndPrintTotalNumber`: 計算並打印骰子數字的總和
    @objc func calculateAndPrintTotalNumber() {
        // 使用reduce函數計算randomNumerArray中所有數字的總和
        totalNumber = randomNumerArray.reduce(0, { $0 + $1 })
        print("total Number is: \(totalNumber)") // 打印總和
    }
    
    
    
    // 函數 `checkThirdDices`: 檢查三個骰子是否全部相同
    @objc func checkThirdDices() {
        if let firstNumber = randomNumerArray.first {
            // 使用allSatisfy函數檢查數組中所有元素是否與第一個元素相同
            let allSame = randomNumerArray.allSatisfy{ $0 == firstNumber }
            /*
             要檢查一個整數陣列中的所有元素是否相同，我們可以使用 allSatisfy 函數。
             allSatisfy 會檢查集合中的所有元素是否都滿足某個條件。如果所有元素都滿足給定的條件，則該函數返回 true；否則返回 false。
             */
            thirdSameDices = allSame // 根據結果更新thirdSameDices變量
            print("thirdSameDices = \(thirdSameDices)")
        }
    }
    
    
    
    // 函數 `shakeDiceCup`: 實現骰子杯的搖動動畫
    @objc func shakeDiceCup() {
        let animation = CABasicAnimation(keyPath: "transform.rotation") // 創建旋轉動畫
        animation.duration = 0.1 // 持續時間
        animation.repeatCount = 5 // 重複次數
        animation.autoreverses = true // 動畫執行完畢後自動反向執行
        animation.fromValue = NSNumber(value: Double.pi / 15) // 起始角度
        animation.toValue = NSNumber(value: -Double.pi / 15) // 終止角度
        cupImageView.layer.add(animation, forKey: "shakeAnimation") // 將動畫添加到骰子杯圖層
    }
    
    
    
    // 函數 `moveCupUpwards`: 向上移動骰子杯
    @objc func moveCupUpwards() {
        let upwardMovement: CGFloat = 60 // 向上移動的距離
        // 使用動畫改變骰子杯的位置
        UIView.animate(withDuration: 0.5, animations: {
            self.cupImageView.center.y -= upwardMovement
        })
    }
    
    
    
    // 函數 `moveCupDownwards`: 向下移動骰子杯
    @objc func moveCupDownwards() {
        let downwardMovement: CGFloat = 60 // 向下移動的距離
        // 使用動畫改變骰子杯的位置
        UIView.animate(withDuration: 0.5, animations: {
            self.cupImageView.center.y += downwardMovement
        })
    }
    
    
    
    // 函數 `createRandomDicePoint`: 隨機生成骰子點數
    @objc func createRandomDicePoint() {
        randomNumerArray.removeAll() // 清空之前的骰子點數
        for n in 0...2 {
            let randomNumber = Int.random(in: 1...6) // 隨機生成一個1到6的數字
            randomDices[n].image = UIImage(systemName: "die.face.\(randomNumber).fill") // 更新骰子圖像
            randomNumerArray.append(randomNumber) // 將隨機數字添加到陣列中
        }
        print("randice number is: \(randomNumerArray)")
    }
    
    
    
    // 函數 `resetButton`: 重置遊戲界面上所有按鈕的狀態
    @objc func resetButton() {
        var number = 1 // 設置一個計數器，用於更新骰子圖像
        for button in numberThirdDiceButtons {
            button.isEnabled = true // 啟用按鈕
            button.backgroundColor = .darkGray // 初始背景色設為深灰色
            button.alpha = 0.5 // 初始透明度設為0.5，表示半透明
            // 使用動畫過渡到完全不透明和白色背景
            UIView.animate(withDuration: 1) {
                button.alpha = 1 // 設置為完全不透明
                button.backgroundColor = .white // 背景色改為白色
            }
            // 使用先前定義的函數創建新的骰子圖像並設置給按鈕
            if let diceImage = createDiceImage(systerName: "die.face.\(number).fill") {
                button.setImage(diceImage, for: .normal)
                button.setTitle(nil, for: .normal) // 移除任何現有的標題
            }
            number += 1 // 增加計數器
        }
        
        // 更新“大”按鈕的狀態和樣式
        biggerNumberButton.isEnabled = true
        biggerNumberButton.backgroundColor = .darkGray
        biggerNumberButton.alpha = 0.5
        UIView.animate(withDuration: 1) { [self] in
            biggerNumberButton.alpha = 1
            biggerNumberButton.backgroundColor = .white
        }
        biggerNumberButton.setTitle("大", for: .normal)
        biggerNumberButton.setTitleColor(.black, for: .normal)
        biggerNumberButton.setTitleColor(.white, for: .highlighted)
        biggerNumberButton.setTitleColor(.gray, for: .disabled)
        
        // 更新“小”按鈕的狀態和樣式
        smallerNumberButton.isEnabled = true
        smallerNumberButton.backgroundColor = .darkGray
        smallerNumberButton.alpha = 0.5
        UIView.animate(withDuration: 1) { [self] in
            smallerNumberButton.alpha = 1
            smallerNumberButton.backgroundColor = .white
        }
        smallerNumberButton.setTitle("小", for: .normal)
        smallerNumberButton.setTitleColor(.black, for: .normal)
        smallerNumberButton.setTitleColor(.white, for: .highlighted)
        smallerNumberButton.setTitleColor(.gray, for: .disabled)
    }
    
    
    
    //MARK: - @objc func BUTTON TOUCH
    
    
    
    // 函數 `dicesButtonTouched`: 當按鈕被按下時觸發
    @objc func dicesButtonTouched(_ sender: UIButton) {
        sender.tintColor = .white // 將按鈕圖標的顏色設為白色
        sender.backgroundColor = .black // 將按鈕背景設為黑色
    }
    
    // 函數 `dicesButtonReleased`: 當按鈕釋放時觸發
    @objc func dicesButtonReleased(_ sender: UIButton) {
        sender.tintColor = .black // 恢復按鈕圖標顏色為黑色
        sender.backgroundColor = .white // 恢復按鈕背景為白色
        
        // 產生物理觸覺反饋
        let feedbackGenerator = UIImpactFeedbackGenerator(style: .medium)
        feedbackGenerator.impactOccurred()
        
        // 透過動畫使按鈕逐漸顯示
        sender.alpha = 0
        UIView.animate(withDuration: 0.5) {
            sender.alpha = 1
        }
        
        rollButton.isEnabled = true // 啟用擲骰按鈕
        
        // 根據遊戲狀態和按鈕標籤處理遊戲邏輯
        if thirdSameDices {
            if randomNumerArray.first == sender.tag {
                turnOffAllButtons()
                sender.updateButtonState(title: "中", color: .systemRed)
                topUpLabel.text = "豹子！"
                
            } else {
                turnOffAllButtons()
                sender.updateButtonState(title: "失", color: .systemGreen)
                topUpLabel.text = "答錯！"
            }
        } else {
            if totalNumber <= 9 {
                if sender.tag == 0 {
                    turnOffAllButtons()
                    sender.updateButtonState(title: "中", color: .systemRed)
                    topUpLabel.text = "答對！"
                } else {
                    turnOffAllButtons()
                    sender.updateButtonState(title: "失", color: .systemGreen)
                    topUpLabel.text = "答錯！"
                }
            } else {
                if sender.tag == 7 {
                    turnOffAllButtons()
                    sender.updateButtonState(title: "中", color: .systemRed)
                    topUpLabel.text = "答對！"
                } else {
                    turnOffAllButtons()
                    sender.updateButtonState(title: "失", color: .systemGreen)
                    topUpLabel.text = "答錯！"
                }
            }
        }
        
        sender.setTitleColor(.white, for: .disabled)
        time = Timer.scheduledTimer(timeInterval: 0.7, target: self, selector: #selector(moveCupUpwards), userInfo: nil, repeats: false)
        scaleRandomDices(number: 2)
        played = true
    }
    
    
    
    // 函數 `rollButtonReleased`: 當擲骰按鈕釋放時觸發
    @objc func rollButtonReleased(_ sender: UIButton) {
        // 使用物理觸覺反饋生成器產生反饋
        let feedbackGenerator = UIImpactFeedbackGenerator(style: .medium)
        feedbackGenerator.impactOccurred()
        
        topUpLabel.text = "下好離手" // 更新標籤文本
        totalNumber = 0 // 重置總數字
        
        if played {
            // 如果已經玩過，則執行一系列動畫和計時器
            moveCupDownwards() // 移動骰子杯向下
            
            // 設置計時器來執行不同的動作
            Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(shakeDiceCup), userInfo: nil, repeats: false)
            Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(createRandomDicePoint), userInfo: nil, repeats: false)
            Timer.scheduledTimer(timeInterval: 2.1, target: self, selector: #selector(calculateAndPrintTotalNumber), userInfo: nil, repeats: false)
            Timer.scheduledTimer(timeInterval: 2.2, target: self, selector: #selector(checkThirdDices), userInfo: nil, repeats: false)
            Timer.scheduledTimer(timeInterval: 2.2, target: self, selector: #selector(resetButton), userInfo: nil, repeats: false)
            
            scaleRandomDices(number: 0.5) // 縮放骰子圖像
        } else {
            // 如果是第一次玩，則直接執行動作
            shakeDiceCup() // 搖動骰子杯
            createRandomDicePoint() // 創建隨機骰子點數
            calculateAndPrintTotalNumber() // 計算並打印總數字
            checkThirdDices() // 檢查三個骰子是否相同
            resetButton() // 重置按鈕狀態
        }
        
        rollButton.isEnabled = false // 禁用擲骰按鈕，避免重複點擊
    }
}

// 輔助函數：更新按鈕狀態並改變上方標籤文字
extension UIButton {
    func updateButtonState(title: String, color: UIColor) {
        setImage(nil, for: .normal)
        setTitle(title, for: .normal)
        backgroundColor = color
        setTitleColor(.white, for: .normal)
        titleLabel?.font = .boldSystemFont(ofSize: 50)
        
    }
}
