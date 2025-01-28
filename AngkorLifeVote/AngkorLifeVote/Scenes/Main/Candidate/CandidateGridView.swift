//
//  CandidateListView.swift
//  AngkorLifeVote
//
//  Created by 김정원 on 1/25/25.
//

import SwiftUI

struct CandidateGridView: View {
    @EnvironmentObject var userSession: UserSession
    @EnvironmentObject var coordinator: MainCoordinator
    @StateObject private var viewModel: CandidateGridViewModel
    @State private var isVoted: Bool = false
    init(candidateService: CandidateServiceProtocol) {
        _viewModel = StateObject(wrappedValue: CandidateGridViewModel(candidateService: candidateService))
    }
    
    private let columns = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            VStack(alignment: .leading) {
                Rectangle()
                    .fill(Color.AK6f76ff)
                    .frame(width: 19.41, height: 3)
                
                Text("2024\nCandidate List")
                    .font(.kpSemiBold(.largeTitle))
                    .foregroundStyle(.white)
                    .padding(.bottom)
                
                Text("※ You can vote for up to 3 candidates")
                    .font(.kpRegular())
                    .foregroundStyle(Color.AKgray2)
            }
            .padding(.horizontal)
            
            LazyVGrid(columns: columns, spacing: 40) {
                ForEach(viewModel.candidates) { candidate in
                    CandidateGridItemView(
                        candidate: candidate,
                        isVoted: viewModel.votedIDs.contains(candidate.id)
                    )
                    .onTapGesture {
                        coordinator.selectedCandidate = candidate
                    }
                }
            }
            .padding()
            
            Text("COPYRIGHT © WUPSC ALL RIGHT RESERVED.")
                .font(.kpRegular(.caption))
                .foregroundStyle(Color.AKbackground)
                .frame(maxWidth: .infinity, alignment: .center)
        }
        .background(Color.black)
        .background(
            NavigationLink(
                destination: ZStack {
                    if let candidate = coordinator.selectedCandidate {
                        CandidateDetailView(viewModel: CandidateDetailViewModel(id: candidate.id, userID: userSession.userID ,candidateService: CandidateService()), isVoted: $isVoted)
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
        .onAppear {
            if viewModel.candidates.isEmpty {
                viewModel.fetchAllCandidates(userID: userSession.userID)
            }
        }
        .task {
            if isVoted {
                 viewModel.fetchAllCandidates(userID: userSession.userID)
                 isVoted = false
            }
        }
    }
}

#Preview {
    NavigationView {
        ScrollView {
            CandidateGridView(candidateService: CandidateService())
                .environmentObject(UserSession())
                .environmentObject(MainCoordinator(appCoordinator: AppCoordinator()))
        }
    }
}
