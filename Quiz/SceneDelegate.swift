//
//  SceneDelegate.swift
//  Quiz
//
//  Created by Dennis Parussini on 08.08.19.
//  Copyright © 2019 Dennis Parussini. All rights reserved.
//

import UIKit
import SwiftUI

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            window.rootViewController = UIHostingController(rootView: QuizView())
            self.window = window
            window.makeKeyAndVisible()
        }
    }
}
