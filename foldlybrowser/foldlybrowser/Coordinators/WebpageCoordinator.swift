//
//  WebpageCoordinator.swift
//  foldlybrowser
//
//  Created by TapticGroup on 12/07/2025.
//

import Foundation
import UIKit
import XCoordinator

//enum WebpageRoute: Route {
//    case initialPage(: String)
//}
//
//final class WebpageCoordinator: NavigationCoordinator<WebpageRoute> {
//    private let dependencies: Dependencies
//
//    init(dependencies: Dependencies, initialUserRequest: String) {
//        self.dependencies = dependencies
//        super.init(initialRoute: .initialPage(String()))
//    }
//
//    override func prepareTransition(for route: WebpageRoute) -> NavigationTransition {
//        switch route {
//        case .initialPage:
//         //   let settings = settings()
//        //    return .set([settings])
//            return .none()
//        }
//    }
//
//    func webPageController() -> UIViewController {
//        let paywall = WebpageBuilder.build(router: weakRouter)
//        return paywall
//    }
//}
