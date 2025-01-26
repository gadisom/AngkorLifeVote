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
        
        // 로그인 성공 콜백 설정
        loginCoordinator.onLoginSuccess = { [weak self] in
            self?.showMainFlow()
        }
        
        childCoordinator = loginCoordinator
    }
    
    func showMainFlow() {
        let mainCoordinator = MainCoordinator()
        childCoordinator = mainCoordinator
    }
    
    func startView() -> some View {
        NavigationView { // 최상위 NavigationView
            if let coordinator = childCoordinator {
                coordinator.start()
            } else {
                Text("Loading...")
            }
        }
    }
}
