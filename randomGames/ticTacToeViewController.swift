//
//  ticTacToeViewController.swift
//  randomGames
//
//  Created by Howe on 2023/12/5.

// MARK: - enum setting



enum Player {
    
    case human
    case computer
    
}


enum MarkType {
    
    case none
    case circle
    case cross
    
}



import UIKit

class ticTacToeViewController: UIViewController {
    
    var containerStackView = UIStackView()
    var oneRowStackView = UIStackView()
    var twoRowStackView = UIStackView()
    var threeRowStackView = UIStackView()
    
    var currentPlayer: Player = .human
    
    var gameState: [MarkType] = [.none, .none, .none, .none, .none, .none, .none, .none, .none]
    
    var OXButtons = [UIButton]()
    
    var playAgainButton = UIButton()
    
    var resultLabel = UILabel()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        
        containerStackView.backgroundColor = .white
        containerStackView.layer.borderColor = UIColor.white.cgColor
        containerStackView.layer.borderWidth = 3
        containerStackView.axis = .vertical
        containerStackView.spacing = 5
        containerStackView.alignment = .fill
        containerStackView.distribution = .fillEqually
        containerStackView.translatesAutoresizingMaskIntoConstraints = false
        
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
        
        resultLabel.text = ""
        resultLabel.font = UIFont.boldSystemFont(ofSize: 80)
        resultLabel.backgroundColor = .clear
        resultLabel.textColor = .white
        resultLabel.isHidden = true
        resultLabel.translatesAutoresizingMaskIntoConstraints = false
        
        
        view.addSubview(containerStackView)
        containerStackView.addArrangedSubview(oneRowStackView)
        containerStackView.addArrangedSubview(twoRowStackView)
        containerStackView.addArrangedSubview(threeRowStackView)
        view.addSubview(playAgainButton)
        view.addSubview(resultLabel)
        
        
        NSLayoutConstraint.activate([
            
            containerStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            containerStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            containerStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            containerStackView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.5),
            
            playAgainButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            playAgainButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30),
            
            resultLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            resultLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -140)
            
        ])
        
        
        
        for number in 1...9 {
            let button: UIButton =  createButton(number: number)
            OXButtons.append(button)
        }
        
        
        
    }
    
    
    
    // MARK: - Function
    
    
    
    func createButton(number: Int) -> UIButton {
        
        var config = UIButton.Configuration.tinted()
        config.background.backgroundColor = .black
        config.background.imageContentMode = .scaleAspectFit
        
        let button = UIButton(configuration: config)
        
        button.tag = number
        button.tintColor = .white
        
        button.addTarget(self, action: #selector(ButtonTouched(_:)), for: .touchDown)
        button.addTarget(self, action: #selector(ButtonReleased(_:)), for: [.touchUpInside, .touchUpOutside, .touchCancel])
        
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
        
        return button
    }
    
    
    
    func switchBackgroundImage(type: MarkType, at index: Int) {
        
        var config = UIButton.Configuration.tinted()
        config.background.backgroundColor = .black
        config.background.imageContentMode = .scaleAspectFit
        
        
        switch type {
        case .none:
            config.background.image = UIImage(systemName: "")
            OXButtons[index].configuration = config
        case.circle:
            config.background.image = UIImage(systemName: "circlebadge")
            OXButtons[index].configuration = config
        case .cross:
            config.background.image = UIImage(systemName: "xmark")
            OXButtons[index].configuration = config
        }
        
    }
    
    
    
    func checkForVictory(_ markType: MarkType) -> Bool {
        let winPatterns: [[Int]] = 
        [
            [0, 1, 2], [3, 4, 5], [6, 7, 8],  // 橫排
            [0, 3, 6], [1, 4, 7], [2, 5, 8],  // 豎排
            [0, 4, 8], [2, 4, 6]  // 斜排
        ]
        
        for pattern in winPatterns {
            if pattern.allSatisfy({ gameState[$0] == markType }) {
                return true
            }
        }
        return false
    }
    
    
    
    func computerMove() {
        var availableSpaces = [Int]()
        for (index, mark) in gameState.enumerated() {
            if mark == .none {
                availableSpaces.append(index)
            }
        }
        
        if let randomSpace = availableSpaces.randomElement() {
            
            gameState[randomSpace] = .cross
            switchBackgroundImage(type: .cross, at: randomSpace)
            
            if checkForVictory(.cross) {
                
                
                playAgainButton.isHidden = false
                playAgainButton.isEnabled = true
                
                for button in OXButtons {
                    button.isEnabled = false
                }
                
                resultLabel.isHidden = false
                resultLabel.text = " \(MarkType.cross) won! "
                
            } else {
                currentPlayer = .human
            }
        }
    }
    
    
    
    func resetGame() {
        gameState = [.none, .none, .none, .none, .none, .none, .none, .none, .none]
        
        currentPlayer = .human
        
        for i in 0...8 {
            OXButtons[i].isEnabled = true
            switchBackgroundImage(type: .none, at: i)
        }
        
        playAgainButton.isHidden = true
        playAgainButton.isEnabled = false
        
        resultLabel.isHidden = true
    }
    
    
    
    // MARK: - @objc Function
    
    
    
    @objc func ButtonTouched (_ sender: UIButton) {
        
        UIView.animate(withDuration: 0.1) {
            sender.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        }
        
    }
    
    
    
    @objc func ButtonReleased (_ sender: UIButton) {
        
        UIView.animate(withDuration: 0.1) {
            sender.transform = CGAffineTransform.identity
        }
        
        
        
        if gameState[sender.tag - 1] == .none {
            gameState[sender.tag - 1] = currentPlayer == .human ? .circle : .cross
            switchBackgroundImage(type: currentPlayer == .human ? .circle : .cross, at: sender.tag - 1)
            
            if checkForVictory(currentPlayer == .human ? .circle : .cross) {
                
                playAgainButton.isHidden = false
                playAgainButton.isEnabled = true
                
                for button in OXButtons {
                    button.isEnabled = false
                }
                
                resultLabel.isHidden = false
                resultLabel.text = " \(MarkType.circle) won! "
                
            } else {
                currentPlayer = currentPlayer == .human ? .computer : .human
                if currentPlayer == .computer {
                    computerMove()
                }
                
                let isTie =  gameState.allSatisfy { $0 != .none }
                if isTie {
                    
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
    
    
    
    @objc func playAgainButtonTouched(_ sender: UIButton) {
        
        UIView.animate(withDuration: 0.1) {
            sender.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        }
    }
    
    
    
    @objc func playAgainButtonReleased(_ sender: UIButton) {
        
        UIView.animate(withDuration: 0.1) {
            sender.transform = CGAffineTransform.identity
        }
        resetGame()
    }
    
    
    
}
