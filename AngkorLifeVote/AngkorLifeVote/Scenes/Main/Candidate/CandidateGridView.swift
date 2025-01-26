//
//  CandidateListView.swift
//  AngkorLifeVote
//
//  Created by 김정원 on 1/25/25.
//

import SwiftUI

struct CandidateGridView: View {
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
        if viewModel.candidates.isEmpty && viewModel.isLoading {
            ProgressView("Loading...")
                .padding()
        } else {
            VStack {
                TabView(selection: $viewModel.currentPageIndex) {
                    ForEach(viewModel.pages.indices, id: \.self) { index in
                        ScrollView {
                            LazyVGrid(columns: columns, spacing: 16) {
                                ForEach(viewModel.pages[index]) { candidate in
                                    CandidateGridItemView(candidate: candidate) { selected in
                                        viewModel.vote(candidate: selected)
                                    }
                                    .onAppear {
                                        if candidate == viewModel.pages[index].last {
                                            viewModel.fetchCandidates()
                                        }
                                    }
                                }
                            }
                            .padding()
                            
                            // 에러 메시지 표시
                            if let error = viewModel.errorMessage {
                                Text("Error: \(error)")
                                    .foregroundColor(.red)
                            }
                            
                            // "Load More" 버튼 (선택 사항)
                            if viewModel.currentPage <= viewModel.totalPages {
                                Button("Load More") {
                                    viewModel.fetchCandidates()
                                }
                                .padding()
                            }
                        }
                        .tag(index)
                    }
                }
                .tabViewStyle(PageTabViewStyle())
                .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
                
                // 페이지 번호 표시
                Text("Page \(viewModel.currentPageIndex + 1) of \(viewModel.totalPages)")
                    .padding(.top, 8)
            }
            .navigationTitle("Candidates")
            .onAppear {
                viewModel.fetchCandidates() // 첫 페이지 로드
            }
            .background(.black)
        }
        
    }
}


#Preview {
    CandidateGridView(candidateService: CandidateService())
}
