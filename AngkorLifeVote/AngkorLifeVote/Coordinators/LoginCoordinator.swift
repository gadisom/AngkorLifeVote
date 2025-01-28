//
//  LoginCoordinator.swift
//  AngkorLifeVote
//
//  Created by 김정원 on 1/23/25.
//

import SwiftUI

final class LoginCoordinator: Coordinator {
    var onLoginSuccess: (() -> Void)?
    
    func start() -> AnyView {
        let loginView = LoginView(onLoginSuccess: { [weak self] in
            self?.onLoginSuccess?()
        })
        return AnyView(loginView)
    }
}
