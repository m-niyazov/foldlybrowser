// 
//  SplashPresenter.swift
//  foldlybrowser
//
//  Created by Niyazov on 13.02.2023.
//

import Foundation
import XCoordinator
import ApphudSDK

protocol SplashPresenterProtocol: AnyObject {
    func checkUserStatus()
}

final class SplashPresenter: SplashPresenterProtocol {
    // MARK: - Properties
    private weak var view: SplashViewControllerProtocol?
    private let router: WeakRouter<RootRoute>
    private let analyticService: CompositionalAnalyticService
    private let subscriptionService: SubscriptionService
    private var applicationState: UserDefaultsState
    private let remoteConfigService: RemoteConfigService
    private let authRepository: AuthRepository
    private let attPermissionService: ATTPermissionService

    // MARK: - Initialize
    init(view: SplashViewControllerProtocol,
         router: WeakRouter<RootRoute>,
         analyticService: CompositionalAnalyticService,
         subscriptionService: SubscriptionService,
         remoteConfigService: RemoteConfigService,
         applicationState: UserDefaultsState,
         authRepository: AuthRepository,
         attPermissionService: ATTPermissionService) {
        self.view = view
        self.router = router
        self.analyticService = analyticService
        self.subscriptionService = subscriptionService
        self.remoteConfigService = remoteConfigService
        self.applicationState = applicationState
        self.authRepository = authRepository
        self.attPermissionService = attPermissionService
    }

    // MARK: - Methods
    func checkUserStatus() {
        if applicationState.hasBeenLaunchedBefore == false {
            applicationState.hasBeenLaunchedBefore = true
            analyticService.appFirstLaunched()
        } else {
            analyticService.appLaunched()
        }
        leaveScreen()
//        if authRepository.isNeedToSignUp {
//            signUp()
//        } else if authRepository.isNeedToRefreshToken() {
//            refreshToken()
//        } else {
//            leaveScreen()
//        }
    }

    func signUp() {
        authRepository.signUp { [weak self] result in
            guard let self = self else {
                return
            }
            switch result {
            case .success(let response):
                self.setUserIdentify(firebaseUUID: response.localId)
                self.leaveScreen()
            case .failure(let error):
               // self.analyticService.splashSignInError(error.localizedDescription)
                self.showErrorAlert(error: error.localizedDescription) { [weak self] in
                    self?.signUp()
                }
            }
        }
    }

    func refreshToken() {
        authRepository.refreshToken { [weak self] result in
            guard let self = self else {
                return
            }
            switch result {
            case .success(let response):
                self.setUserIdentify(firebaseUUID: response.userId)
                self.leaveScreen()
            case .failure(let error):
                print(error)
                // Логируем ошибку обновления токена для аналитики
//                self.analyticService.splashSignInError("Failed to refresh token: \(error.localizedDescription)")
//                // Показываем алерт пользователю для повторной попытки
//                self.showErrorAlert(error: Strings.Alerts.failedRefreshSession) { [weak self] in
//                    self?.signUp() // Пробуем войти заново
//                }
            }
        }
    }

    func leaveScreen() {
        Task {
            await router.trigger(.tabBar)
//            // await remoteConfigService.load()
//            let isOnboardingCompleted = self.applicationState.isOnboardingCompleted
//
//            if isOnboardingCompleted {
//                await router.trigger(.home)
//            } else {
//                await Apphud.paywallsDidLoadCallback { _, _ in }
//                await router.trigger(.onboarding)
//            }
        }
    }

    func setUserIdentify(firebaseUUID: String) {
        analyticService.setUserIdentify(key: "firebase-uuid", value: firebaseUUID)
        Apphud.setUserProperty(key: .init("firebase-uuid"), value: firebaseUUID)
    }
}

// MARK: - Private Methods
private extension SplashPresenter {
    func showErrorAlert(error: String, action: (() -> Void)?) {
        let okAction = Alert.Action(
            title: "Ok",
            style: .default,
            action: nil
        )

        let tryAgainAction = Alert.Action(
            title: "Try Again",
            style: .default,
            action: action
        )

        let actions: [Alert.Action] = [okAction, tryAgainAction]

        router.trigger(.alert(
            Alert(
                title: error,
                message: nil,
                style: .alert,
                actions: actions)
        )
        )
    }
}
