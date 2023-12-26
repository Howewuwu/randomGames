//
//  Sign.swift
//  randomGames
//
//  Created by Howe on 2023/12/21.
//

import UIKit
import SwiftyGif

// 枚舉 Element，代表遊戲中的元素：火、水、草。
enum Element {
    case fire
    case water
    case grass
    
    // 根據元素獲得對應的玩家1的圖像（GIF）。
    var player01: UIImage {
        do {
            switch self {
            case .fire:
                let gif = try UIImage(gifName: "player01-charizard")
                return gif
            case .grass:
                let gif = try UIImage(gifName: "player01-venusaur")
                return gif
            case .water:
                let gif = try UIImage(gifName: "player01-blastoise")
                return gif
            }
        } catch {
            print(error)
            return UIImage()
        }
    }
    
    // 根據元素獲得對應的玩家2的圖像（GIF）。
    var player02: UIImage {
        do {
            switch self {
            case .fire:
                let gif = try UIImage(gifName: "player02-charizard")
                return gif
            case .grass:
                let gif = try UIImage(gifName: "player02-venusaur")
                return gif
            case .water:
                let gif = try UIImage(gifName: "player02-blastoise")
                return gif
            }
        } catch {
            print(error)
            return UIImage()
        }
    }
    
    // 定義一個方法來判斷當前元素對抗另一個元素時的遊戲狀態。
    func gameState(against opponentElement: Element) -> GameState {
        // 如果元素相同，則結果為平局。
        if self == opponentElement {
            return .draw
        }
        
        // 根據遊戲規則判斷勝負。
        switch self {
        case .fire:
            if opponentElement == .grass {
                return .win
            }
        case .grass:
            if opponentElement == .water {
                return .win
            }
        case .water:
            if opponentElement == .fire {
                return .win
            }
        }
        
        // 如果不符合上述任何條件，則為輸。
        return .lose
    }
}

// 定義一個函數，用於隨機生成一個元素。
func randomElement() -> Element {
    let element = Int.random(in: 0...2)
    switch element {
    case 0:
        return .fire
    case 1:
        return .grass
    default:
        return .water
    }
}
