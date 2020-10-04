//
//  SceneCoordinator.swift
//  Ojoli
//
//  Created by Dinh Thanh An on 10/27/17.
//  Copyright © 2017 Elisoft. All rights reserved.
//

import UIKit

enum TransitionType {
    case changeRootView
    case push
    case present
}

struct SceneManager {
    
    static func navigateToTodayDetailScene(_ data: AjmoTodayModel, navigationController: UINavigationController) {
        let vc = Utils.controllerFromStoryboard("Main", id: "TodayDetailViewController") as! TodayDetailViewController
        vc.todayEvent = data
        self.show(viewController: vc, with: .push, navigationController: navigationController)
    }
    
    //COMMON FUNCTION
    static func show(viewController: UIViewController, with transitionType: TransitionType, navigationController: UINavigationController) {
        switch transitionType {
        case .changeRootView:
            navigationController.setViewControllers([viewController], animated: false)
        case .present:
            navigationController.viewControllers.last?.present(viewController, animated: true, completion: nil)
        case .push:
            navigationController.pushViewController(viewController, animated: true)
        }
    }
}
