//
//  MainView.swift
//  AngkorLifeVote
//
//  Created by 김정원 on 1/23/25.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject var coordinator: MainCoordinator
    @EnvironmentObject var userSession: UserSession

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                
                    WmuPosterView()
                
                    CountDownView()
                        .padding(.horizontal, 40)
                
                    Image(.earthBackground)
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: .infinity)
                    
                    VotingInfoView()
                    
                    CandidateGridView(candidateService: CandidateService())
                  
                    Spacer()
                }
            }
            .background(Color.black)
            .background(
                NavigationLink(
                    destination: ZStack {
                        if let candidate = coordinator.selectedCandidate {
                            CandidateDetailView(viewModel: CandidateDetailViewModel(id: candidate.id, userID: userSession.userID ,candidateService: CandidateService()))
                                .environmentObject(coordinator)
                        } else {
                            EmptyView()
                        }
                    },
                    isActive: Binding<Bool>(
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
            )
            .navigationBarTitle("2024 WMU", displayMode: .inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        coordinator.logout()
                    }) {
                        Image(systemName: "xmark")
                    }
                }
            }
        }
    }
}


#Preview {
    let coordinator = MainCoordinator(appCoordinator: AppCoordinator())
    MainView()
        .environmentObject(coordinator)
        .environmentObject(UserSession())
}
