//
//  ApplicationCoordinator.swift
//  AcademyChallenge
//
//  Created by Keven Esmael on 07/10/2022.
//

import UIKit

class ApplicationCoordinator: Coordinator {

    // SETUPS IT'S PRESENTATIONS IN THE APP'S WINDOW
    let window: UIWindow
    // THE ROOTVIEWCONTROLLER WILL BE THE NAVIGATION CONTROLLER SO WE CAN NAVIGATE BETWEEN THE OTHERS VIEW CONTROLLER

    let rootViewController: UINavigationController

    let mainPageCoordinator: MainPageCoordinator
    let application: Application
    // INITIALIZE THE PROPERTIES
    init(window: UIWindow, application: Application) {

        self.window = window
        self.rootViewController = UINavigationController()
        self.application = application

        self.mainPageCoordinator = MainPageCoordinator(presenter: rootViewController, application: application)

    }

    // THIS FUNCTION WILL PRESENT THE WINDOW WITH ITS ROOTVIEWCONTROLLER
    func start() {
        window.rootViewController = rootViewController
        mainPageCoordinator.start()
        window.makeKeyAndVisible()
    }
}
