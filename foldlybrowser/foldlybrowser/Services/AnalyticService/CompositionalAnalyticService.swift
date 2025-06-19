//
//  CompositAnalyticService.swift
//  foldlybrowser+
//
//  Created by m-niyazov on 31.05.2023.

// swiftlint:disable type_body_length
// swiftlint:disable file_length

protocol AnalyticService {
    func send(event: String, params: [[String: String]]?)
    func setUserIdentify(key: String, value: String)
}

final class CompositionalAnalyticService {
    private let analyticServices: [AnalyticService]

    init(analyticServices: [AnalyticService]) {
        self.analyticServices = analyticServices
    }

    // MARK: - Methods

    private func sendAMPEvent(event: String, params: [[String: String]]? = nil) {
        analyticServices[0].send(event: event, params: params)
    }

    private func sendAFEvent(event: String, params: [[String: String]]? = nil) {
        analyticServices[1].send(event: event, params: params)
    }

    private func send(event: String, params: [[String: String]]? = nil) {
        analyticServices.forEach { $0.send(event: event, params: params) }
    }

    // MARK: - User Identify

    func setUserIdentify(key: String, value: String) {
        analyticServices[0].setUserIdentify(key: key, value: value)
    }

    // MARK: - Events

    // MARK: - Splash
    /// Первый запуск
    func appFirstLaunched() {
        send(event: "app_first_launched")
    }
    /// Запуск(Не отправляется вместе с appFirstLaunch, а все следующие разы)
    func appLaunched() {
        send(event: "app_launched")
    }

    // MARK: - Onboarding

    /// Показ определенной страницы онбординга
    func showOnboarding(version: OnboardingVersion, screenNumber: Int) {
        sendAMPEvent(
            event: "shown_onboarding",
            params: [
                ["version": version.rawValue],
                ["screen-number": "\(screenNumber)"]
            ]
        )
    }

    /// Выбран статус для отправки пуш-уведомлений
    func selectNotifyPushStatus(status: Bool) {
        let status = status ? "authorized" : "denied"
        send(
            event: "notify_push_status_selected",
            params: [
                ["status": status]
            ]
        )
        setUserIdentify(key: "notify_push_status", value: status)
    }

    /// Показ запроса для отслеживание данных
    func shownAttRequest() {
        send(event: "shown_att_request")
    }

    /// Выбран статус  для отслеживание данных
    func selectAttStatus(status: Bool) {
        let status = status ? "authorized" : "denied"
        send(
            event: "att_status_selected",
            params: [
                ["status": status]
            ]
        )
        setUserIdentify(key: "att_status", value: status)
    }

    /// Онбординг завершен
    func finishedOnboarding(version: OnboardingVersion) {
        send(
            event: "finished_onboarding",
            params: [
                ["version": version.rawValue]
            ]
        )
    }

    // MARK: - Paywall
    /// Ошибка при попытки загрузить и отобразить пейволл
    func errorLoadPaywall(_ message: String) {
        send(
            event: "error_load_paywall",
            params: [
                ["message": message]
            ]
        )
    }

    /** Показ экрана подписки
     - Parameter version: Версия экрана подписки(paywall-id)
     - Parameter context: Указывает предыдущий экран или в целом контекст от куда был открыт данный пейволла
     */
    func shownPaywall(
        version: String,
        context: String,
        onboardingVersion: OnboardingVersion,
        appHudExperimentName: String?,
        appHudVariationName: String?
    ) {
        send(
            event: "shown_paywall",
            params: [
                ["version": version],
                ["context": context],
                ["onb-version": onboardingVersion.rawValue],
                ["apphud-experiment-name": appHudExperimentName ?? ""],
                ["apphud-variation-name": appHudVariationName ?? ""]
            ]
        )
    }

    /// Пользователь нажал на кнопку оформление подписки
    func tappedStartSubscription() {
        send(event: "tapped_start_subscription")
    }

    /** Подписка оформлена
     - Parameter productId: ID оформленной подписки
     - Parameter paywallId: Версия пейволл с которого была оформлена подписка
     - Parameter context: Указывает предыдущий экран или в целом контекст от куда был открыт данный пейволл
     */
    func startedSubscription(
        productId: String,
        paywallId: String,
        context: String,
        onboardingVersion: OnboardingVersion,
        appHudExperimentName: String?,
        appHudVariationName: String?
    ) {
        send(
            event: "started_subscription",
            params: [
                ["product-id": productId],
                ["paywall-id": paywallId],
                ["context": context],
                ["onb-version": onboardingVersion.rawValue],
                ["apphud-experiment-name": appHudExperimentName ?? ""],
                ["apphud-variation-name": appHudVariationName ?? ""]
            ]
        )
    }

    func errorStartedSubscriptionError(_ message: String) {
        send(
            event: "error_started_subscription",
            params: [
                ["message": message]
            ]
        )
    }

    /// Пользователь нажал на кнопку закрытие пейволла
    func tappedClosePaywall() {
        send(event: "tapped_close_paywall")
    }

    // MARK: - Main Screen

    /// Показался главный экран
    func shownHome() {
        send(event: "shown_home")
    }

    func fetchHomeDataSuccess() {
        send(event: "fetch_home_data_success")
    }

    func fetchHomeDataError(_ error: String) {
        send(
            event: "fetch_home_data_error",
            params: [
                ["error": error]
            ]
        )
    }

    func tappedCloseActualBatteryLevelTip() {
        send(event: "tapped_close_actual_battery_level_tip")
    }


    /** Пользователь нажал на определенную статью
     - Parameter id: Айди выбранной статьи
     - Parameter title: Заголовок выбранной статьи
     */
    func tappedTip(id: String, title: String) {
        let formattedTipTitle = title.lowercased().replacingOccurrences(of: " ", with: "-")
        sendAMPEvent(
            event: "tapped_tip_сell",
            params: [
                ["id": id],
                ["title": formattedTipTitle]
            ]
        )
    }

    /** Показан первый экран статьи
     - Parameter id: Айди показнной статьи
     - Parameter title: Заголовок показнной статьи
     */
    func shownTip(id: String, title: String) {
        let formattedTipTitle = title.lowercased().replacingOccurrences(of: " ", with: "-")
        sendAMPEvent(
            event: "shown_tip",
            params: [
                ["id": id],
                ["title": formattedTipTitle]
            ]
        )
    }

    func tappedTipExpand(id: String, title: String) {
        let formattedTipTitle = title.lowercased().replacingOccurrences(of: " ", with: "-")
        sendAMPEvent(
            event: "tapped_tip_expand",
            params: [
                ["id": id],
                ["title": formattedTipTitle]
            ]
        )
    }

    func tappedTipSimplify(id: String, title: String) {
        let formattedTipTitle = title.lowercased().replacingOccurrences(of: " ", with: "-")
        sendAMPEvent(
            event: "tapped_tip_simplify",
            params: [
                ["id": id],
                ["title": formattedTipTitle]
            ]
        )
    }

    func closeTip(id: String, title: String) {
        let formattedTipTitle = title.lowercased().replacingOccurrences(of: " ", with: "-")
        sendAMPEvent(
            event: "close_tip",
            params: [
                ["id": id],
                ["title": formattedTipTitle]
            ]
        )
    }

    func markAsCompletedTip(id: String, title: String) {
        let formattedTipTitle = title.lowercased().replacingOccurrences(of: " ", with: "-")
        sendAMPEvent(
            event: "mark_as_completed_tip",
            params: [
                ["id": id],
                ["title": formattedTipTitle]
            ]
        )
    }

    func markAsUnCompletedTip(id: String, title: String) {
        let formattedTipTitle = title.lowercased().replacingOccurrences(of: " ", with: "-")
        sendAMPEvent(
            event: "mark_as_un_completed_tip",
            params: [
                ["id": id],
                ["title": formattedTipTitle]
            ]
        )
    }

    // MARK: - Settings

    /// Показан экран Settings в таббаре
    func shownSettings() {
        sendAMPEvent(event: "shown_settings")
    }

    /// Выбран один из настроек из списка на экране settings
    func tappedSettingsItem(_ itemName: String) {
        let formattedItemName = itemName.lowercased().replacingOccurrences(of: " ", with: "-")
        sendAMPEvent(
            event: "tapped_settings_item",
            params: [
                ["item-name": formattedItemName]
            ]
        )
    }

    // MARK: - LongPressToStart

    /// Показан экрана LongPressToStart
    func shownLongPressToStart() {
        sendAMPEvent(event: "shown_long_press")
    }

    /// Пользователь нажал на кнопку перехода на следующий экрвн
    func longPressed() {
        sendAMPEvent(event: "long_pressed_button")
    }

    // MARK: - Questionnaire

    /// Показан экрана Questionnaire
    func shownQuestionnaire() {
        sendAMPEvent(event: "shown_questionnaire")
    }

    /// Пользователь ответил на вопрос на конкретной странице
    func questionnairePageCompletedPage(_ pageNum: Int, _ questionId: String, _ answerId: String) {
        sendAMPEvent(
            event: "questionnaire_page_completed",
            params: [
                ["page-num": "\(pageNum)"],
                ["question-id": "\(questionId)"],
                ["answer-id": "\(answerId)"]
            ]
        )
    }

    /// Пользователь полностью завершил опрос
    func questionnaireCompleted() {
        sendAMPEvent(event: "questionnaire_completed")
    }

    // MARK: - QuestionnaireAnalysis

    /// Показан экрана QuestionnaireAnalysis
    func shownQuestionnaireAnalysis() {
        sendAMPEvent(event: "shown_questionnaire_analysis")
    }

    func habitMakerSuccess() {
        sendAMPEvent(event: "questionnaire_analysis_success")
    }

    // MARK: - QuestionnaireAnalysis
    /// Показался главный экран
    func shownNetworkScreen() {
        send(event: "shown_network_screen")
    }

    func tappedNetworkStartTest() {
        send(event: "tapped_start_speed_test")
    }

    func locationAccessSelected(_ status: String) {
        send(
            event: "location_access_selected",
            params: [
                ["status": status]
            ]
        )
    }

    func speedTestStarted() {
        send(event: "speed_test_started")
    }

    func tappedCloseSpeedTestXmark() {
        send(event: "tapped_close_speed_test_xmark")
    }

    func tappedStopeSpeedTestButton() {
        send(event: "tapped_close_speed_test_button")
    }

    func speedTestFinished() {
        send(event: "speed_test_finished")
    }

    func speedTestDownloadStarted() {
        send(event: "speed_test_download_started")
    }

    func speedTestDownloadCompleted() {
        send(event: "speed_test_download_completed")
    }

    func speedTestUploadStarted() {
        send(event: "speed_test_upload_started")
    }

    func speedTestUploadCompleted() {
        send(event: "speed_test_upload_completed")
    }

    func speedTestError(_ error: String) {
        send(
            event: "speed_test_error",
            params: [
                ["error": error]
            ]
        )
    }
}
// swiftlint:enable type_body_length
// swiftlint:enable file_length
