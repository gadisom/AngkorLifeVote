//
//  MainView.swift
//  AngkorLifeVote
//
//  Created by 김정원 on 1/23/25.
//

import SwiftUI

struct MainView: View {
    @ObservedObject var viewModel: MainViewModel
    @EnvironmentObject var coordinator: MainCoordinator
    @State private var isDetailActive: Bool = false
    
    var body: some View {
        VStack {
            ScrollView {
                VStack(spacing: 20) {
                    // 상단 포스터 뷰
                    WmuPosterView()
                    
                    // 카운트다운 섹션
                    CountDownView()
                        .padding(.horizontal, 40)
                    
                    Image(.earthBackground)
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: .infinity)
                    
                    VotingInfoView()

                    CandidateGridView(candidateService: CandidateService())
                        .environmentObject(coordinator) // Coordinator 전달
                        .padding(.bottom)
                }
            }
            
            // 숨겨진 NavigationLink
            NavigationLink(
                destination: Group {
                    if let candidate = coordinator.selectedCandidate {
                        CandidateDetailView(candidate: candidate)
                    } else {
                        EmptyView()
                    }
                },
                isActive: Binding(
                    get: { coordinator.selectedCandidate != nil },
                    set: { newValue in
                        if !newValue {
                            coordinator.selectedCandidate = nil
                        }
                    }
                )
            ) {
                EmptyView()
            }
        }
        .background(Color.black)
    }
}

#Preview {
    let coordinator = MainCoordinator()
    MainView(viewModel: MainViewModel())
        .environmentObject(coordinator)
        .environmentObject(UserSession())
}
