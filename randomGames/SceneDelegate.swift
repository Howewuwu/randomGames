//
//  SceneDelegate.swift
//  randomGames
//
//  Created by Howe on 2023/12/5.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // 確保 scene 是 UIWindowScene 的實例
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        
        // 創建一個 UIWindow 並將其與 windowScene 關聯
        //let window = UIWindow(windowScene: windowScene)
        
        // 創建 UITabBarController
        let tabBarController = UITabBarController()
        tabBarController.tabBar.tintColor = .white
        //tabBarController.tabBar.unselectedItemTintColor = .lightGray
        //tabBarController.tabBar.barTintColor = .black
        tabBarController.tabBar.barStyle = .black
        
        // 創建 ViewViewController 並為其設置 UITabBarItem
        let dicesVC = dicesViewViewController()
        dicesVC.tabBarItem = UITabBarItem(title: "Dices", image: UIImage(systemName: "dice.fill"), tag: 0)
        
        
        let wheelVC = wheelViewController()
        wheelVC.tabBarItem = UITabBarItem(title: "Wheel", image: UIImage(systemName: "circle.dashed.inset.fill"), tag: 1)
        
        let rpsVC = rockPaperScissorsViewController()
        rpsVC.tabBarItem = UITabBarItem(title: "RPS", image: UIImage(systemName: "hand.raised.fingers.spread.fill"), tag: 2)
        
        let tttVC = ticTacToeViewController()
        tttVC.tabBarItem = UITabBarItem(title: "TTT", image: UIImage(systemName: "grid"), tag: 3)
        
        // 將 dicesVC 添加為 UITabBarController 的一部分
        tabBarController.viewControllers = [dicesVC, wheelVC, rpsVC, tttVC]
        
        // 將 UITabBarController 設置為 window 的根視圖控制器
        window?.rootViewController = tabBarController
        
        // 顯示 window
        window?.makeKeyAndVisible()
        
        // 將創建的 window 設置為 SceneDelegate 的屬性，以保持對它的引用
        //self.window = window
    }
    
    
    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }
    
    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }
    
    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }
    
    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }
    
    
}

