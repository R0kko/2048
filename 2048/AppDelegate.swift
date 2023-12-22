//
//  AppDelegate.swift
//  2048
//
//  Created by Алексей Дробот on 22.12.2023.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Создаем новое окно для приложения
        window = UIWindow(frame: UIScreen.main.bounds)

        // Создаем экземпляр ViewController
        let viewController = ViewController()

        // Устанавливаем корневой ViewController
        window?.rootViewController = viewController

        // Сделать окно видимым
        window?.makeKeyAndVisible()

        return true
    }
}
