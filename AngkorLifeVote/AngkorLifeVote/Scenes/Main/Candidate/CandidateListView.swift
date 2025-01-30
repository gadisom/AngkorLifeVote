//
//  CandidateListView.swift
//  AngkorLifeVote
//
//  Created by 김정원 on 1/25/25.
//

import SwiftUI

struct CandidateListView: View {
    @EnvironmentObject var userSession: UserSession
    @EnvironmentObject var coordinator: MainCoordinator
    @StateObject private var viewModel: CandidateListViewModel
    @State private var isVoted: Bool = false
    let onAlert: (String) -> Void
    
    init(candidateService: CandidateServiceProtocol,
         onAlert: @escaping (String) -> Void) {
        _viewModel = StateObject(wrappedValue: CandidateListViewModel(candidateService: candidateService))
        self.onAlert = onAlert
    }
    
    private let columns = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]
    
    var body: some View {
        ZStack{
            VStack(alignment: .leading, spacing: 20) {
                VStack(alignment: .leading) {
                    Rectangle()
                        .fill(Color.AK6f76ff)
                        .frame(width: 19.41, height: 3)
                    
                    Text("2024\nCandidate List")
                        .font(.kpSemiBold(.largeTitle))
                        .foregroundStyle(.white)
                        .padding(.bottom)
                    HStack {
                        Text("※ You can vote for up to 3 candidates")
                            .font(.kpRegular())
                            .foregroundStyle(Color.AKgray2)
                        Spacer()
                        Picker("정렬", selection: $viewModel.sortType) {
                            ForEach([SortType.name, SortType.voteCntDesc, SortType.candidateNumber], id: \.self) { type in
                                Text(type.sortValue)
                                    .tag(type)
                            }
                        }
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                        .background(Color.AKdbdbdb)
                        .pickerStyle(MenuPickerStyle()) // 선택적으로 스타일 변경
                        .clipShape(RoundedRectangle(cornerRadius: 30))
                    }
                }
                .padding(.horizontal)
                
                LazyVGrid(columns: columns, spacing: 40) {
                    ForEach(viewModel.candidates) { candidate in
                        CandidateGridItemView(
                            candidate: candidate,
                            isVoted: viewModel.votedIDs.contains(candidate.id)
                        ) { id in
                            viewModel.vote(userID: userSession.userID, candidateID: id)
                        }
                    }
                }
                .padding()
                
                Text("COPYRIGHT © WUPSC ALL RIGHT RESERVED.")
                    .font(.kpRegular(.caption))
                    .foregroundStyle(Color.AKbackground)
                    .frame(maxWidth: .infinity, alignment: .center)
            }
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
        
        .refreshable {
            viewModel.fetchAllCandidates(userID: userSession.userID)
        }
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
        .onReceive(viewModel.$sortType) { _ in
            viewModel.fetchAllCandidates(userID: userSession.userID)
        }
        
        .onReceive(viewModel.$showAlert) { newValue in
            if newValue {
                onAlert(viewModel.alertMessage)
                viewModel.showAlert = false
            }
        }
    }
}

#Preview {
    NavigationView {
        ScrollView {
            CandidateListView(candidateService: CandidateService(), onAlert: { _ in })
                .environmentObject(UserSession())
                .environmentObject(MainCoordinator(appCoordinator: AppCoordinator()))
        }
    }
}
