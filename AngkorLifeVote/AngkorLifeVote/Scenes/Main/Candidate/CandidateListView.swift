//
//  CandidateListView.swift
//  AngkorLifeVote
//
//  Created by 김정원 on 1/25/25.
//

import SwiftUI

struct CandidateListView: View {
    @StateObject private var viewModel = CandidateListViewModel()
    
    var body: some View {
        NavigationView {
            Group {
                if viewModel.isLoading {
                    ProgressView("Loading...")
                } else if let errorMessage = viewModel.errorMessage {
                    Text("Error: \(errorMessage)")
                } else {
                    // 후보자 리스트 표시
                    List(viewModel.candidates) { candidate in
                        HStack {
                            // 썸네일
                            AsyncImage(url: URL(string: candidate.profileUrl)) { image in
                                image.resizable()
                            } placeholder: {
                                Color.gray
                            }
                            .frame(width: 50, height: 50)
                            .clipShape(Circle())
                            
                            VStack(alignment: .leading) {
                                Text("\(candidate.candidateNumber). \(candidate.name)")
                                    .font(.headline)
                                Text("Votes: \(candidate.voteCnt)")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Candidate List")
        }
        .onAppear {
            // 뷰 초기 표시 시, 한번 불러오기
            // 원하는 page, size, sort 지정
            viewModel.fetchCandidateList(page: 0, size: 9, sort: [])
        }
    }
}
#Preview {
    CandidateListView()
}
