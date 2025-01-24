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
        let viewModel = LoginViewModel()
        
        // ViewModel에서 로그인 완료 시 -> Coordinator 콜백
        viewModel.onLoginSuccess = { [weak self] in
            self?.onLoginSuccess?()
        }
        
        let view = LoginView(viewModel: viewModel)
        return AnyView(view)
    }
}
