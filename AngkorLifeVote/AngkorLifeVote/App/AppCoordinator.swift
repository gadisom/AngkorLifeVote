//
//  Coordinator.swift
//  AngkorLifeVote
//
//  Created by 김정원 on 1/23/25.
//

import SwiftUI

final class AppCoordinator: ObservableObject {
    @Published var currentView: AnyView = .init(EmptyView())
    
//    let userSession = UserSession()
//    let networkService = NetworkService()
    init() {
        start()
    }
    
    func start() {
        
    }
    
    func showLoginFlow() {
        
        
    }
    
    func showMainFlow() {
        
    }
    
    func showProfileFlow() {
        
    }
}

