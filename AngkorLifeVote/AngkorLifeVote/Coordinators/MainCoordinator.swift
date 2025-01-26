//
//  MainCoordinator.swift
//  AngkorLifeVote
//
//  Created by 김정원 on 1/23/25.
//

import SwiftUI

final class MainCoordinator: Coordinator, ObservableObject {
    @Published var selectedCandidate: CandidateItem?
    
    func start() -> AnyView {
        let viewModel = MainViewModel()
        let view = MainView(viewModel: viewModel)
            .environmentObject(self) // Coordinator를 환경 객체로 전달
        return AnyView(view)
    }
    
    // 상세 페이지로 이동하는 함수
    func navigateToDetail(candidate: CandidateItem) {
        selectedCandidate = candidate
    }
}
