//
//  MainCoordinator.swift
//  AngkorLifeVote
//
//  Created by 김정원 on 1/23/25.
//

import SwiftUI

final class MainCoordinator: Coordinator, ObservableObject {
    weak var appCoordinator: AppCoordinator?
    
    @Published var selectedCandidate: CandidateItem?
    init(appCoordinator: AppCoordinator?) {
        self.appCoordinator = appCoordinator
    }
    
    func start() -> AnyView {
        return AnyView(
            NavigationView {
                MainView()
                    .environmentObject(self)
            }
        )
    }
    
    /// 로그아웃 처리
    func logout() {
        appCoordinator?.logout()
    }

}

