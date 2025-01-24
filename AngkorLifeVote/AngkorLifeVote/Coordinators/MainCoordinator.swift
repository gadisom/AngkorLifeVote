//
//  MainCoordinator.swift
//  AngkorLifeVote
//
//  Created by 김정원 on 1/23/25.
//

import SwiftUI

final class MainCoordinator: Coordinator {
    func start() -> AnyView {
        let viewModel = MainViewModel()
        let view = MainView(viewModel: viewModel)
        return AnyView(view)
    }
}
