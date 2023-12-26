//
//  GameState.swift
//  randomGames
//
//  Created by Howe on 2023/12/21.
//

import Foundation

// 定義一個名為 GameState 的枚舉，用來表示遊戲的狀態。
enum GameState {
    case start  // 遊戲開始
    case win    // 玩家勝利
    case lose   // 玩家失敗
    case draw   // 平局
    
    // 根據遊戲的狀態提供相應的狀態文字。
    var status: String {
        switch self {
        case .start:
            return "Let's play !"  // 遊戲開始時的信息
        case .win:
            return "You Won !"    // 玩家勝利時的信息
        case .lose:
            return "You Lost!"    // 玩家失敗時的信息
        case .draw:
            return "DRAW"         // 平局時的信息
        }
    }
}
