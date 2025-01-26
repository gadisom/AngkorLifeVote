//
//  CandidateListView.swift
//  AngkorLifeVote
//
//  Created by 김정원 on 1/25/25.
//

import SwiftUI

struct CandidateGridView: View {
    @EnvironmentObject var userSession: UserSession
    @StateObject private var viewModel: CandidateGridViewModel
    
    init(candidateService: CandidateServiceProtocol) {
        _viewModel = StateObject(wrappedValue: CandidateGridViewModel(candidateService: candidateService))
    }
    
    // 2열 레이아웃
    private let columns = [
        GridItem(.flexible(minimum: 0), spacing: 16),
        GridItem(.flexible(minimum: 0), spacing: 16)
    ]
    
    var body: some View {
        NavigationView {
            GeometryReader { geomtry in
                ZStack {
                    if viewModel.isLoading {
                        ProgressView("Loading...")
                    }
                    else if let error = viewModel.errorMessage {
                        VStack {
                            Text("Error: \(error)")
                                .foregroundColor(.red)
                            Button("Retry") {
                                viewModel.fetchAllCandidates(userID: userSession.userID)
                            }
                            .padding()
                        }
                    }
                    else {
                        // 후보자 그리드
                        LazyVStack {
                            VStack(alignment: .leading) {
                                Text("2024\nCadidate List")
                                    .font(.kpSemiBold(.largeTitle))
                                    .foregroundStyle(.white)
                                    .padding(.vertical)
                                
                                Text("※ You can vote for up to 3 candidates")
                                    .font(.kpRegular())
                                    .foregroundStyle(Color.rgb(red: 174, green: 174, blue: 178))
                            }
                            
                            LazyVGrid(columns: columns, spacing: 40) {
                                ForEach(viewModel.candidates) { candidate in
                                    CandidateGridItemView(
                                        candidate: candidate,
                                        isVoted: viewModel.votedIDs.contains(candidate.id)
                                    ) { selectedID in
                                        viewModel.vote(userID: userSession.userID, candidateID: selectedID)
                                    }
                                    .background(Color.red)
                                }
                            }
                            .padding()
                            Text("COPYRIGHT © WUPSC ALL RIGHT RESERVED.")
                                .font(.kpRegular(.caption))
                                .foregroundStyle(.gray)
                                .frame(alignment: .center)
                        }
                        .frame(maxHeight: .infinity)
                    }
                }
                .background(.black)
            }
        }
        .onAppear {
            // 첫 로딩
            if viewModel.candidates.isEmpty {
                viewModel.fetchAllCandidates(userID: userSession.userID)
            }
        }
    }
}



#Preview {
    CandidateGridView(candidateService: CandidateService())
        .environmentObject(UserSession())
}
