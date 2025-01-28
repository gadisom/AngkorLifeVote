//
//  Coordinator.swift
//  AngkorLifeVote
//
//  Created by 김정원 on 1/23/25.
//
import SwiftUI

final class AppCoordinator: ObservableObject {
    @Published var childCoordinator: Coordinator?
    
    init() {
        start()
    }
    
    func start() {
        showLoginFlow()
    }
    
    func showLoginFlow() {
        let loginCoordinator = LoginCoordinator()
        loginCoordinator.onLoginSuccess = { [weak self] in
            self?.showMainFlow()
        }
        childCoordinator = loginCoordinator
    }
    
    func showMainFlow() {
        let mainCoordinator = MainCoordinator(appCoordinator: self)
        childCoordinator = mainCoordinator
    }
    
    func logout() {
        showLoginFlow()
    }
    
    func startView() -> some View {
        if let coordinator = childCoordinator {
            return coordinator.start()
        } else {
            return AnyView(Text("Loading..."))
        }
    }
}
