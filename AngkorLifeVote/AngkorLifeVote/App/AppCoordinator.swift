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

    }
    
    // childCoordinator에 따라 적절한 View를 생성
    func startView() -> AnyView {
        if let coordinator = childCoordinator {
            return coordinator.start()
        } else {
            return AnyView(Text("Loading..."))
        }
    }
}
