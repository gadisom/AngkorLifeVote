//
//  CandidateGridViewModel.swift
//  AngkorLifeVote
//
//  Created by 김정원 on 1/25/25.
//

import SwiftUI
import Combine

final class CandidateGridViewModel: ObservableObject {
    @Published var candidates: [CandidateItem] = []
    @Published var pages: [[CandidateItem]] = []
    @Published var currentPage: Int = 1 // 1부터 시작
    @Published var totalPages: Int = 1 // 서버 응답으로 받아옴
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    @Published var sortType: Sort = .name
    
    private let pageSize = 4
    @Published var currentPageIndex: Int = 0 {
        didSet {
            // 사용자가 마지막 페이지로 이동하면 추가 로드
            if currentPageIndex == pages.count - 1 && currentPage < totalPages {
                fetchCandidates()
            }
        }
    }
    
    let candidateService: CandidateServiceProtocol  // 실제 네트워크 서비스
    
    init(candidateService: CandidateServiceProtocol) {
        self.candidateService = candidateService
    }
    
    func fetchCandidates() {
        guard !isLoading, currentPage <= totalPages else { return }
        
        isLoading = true
        
        Task {
            do {
                let response = try await candidateService.requestCandidateList(
                    page: currentPage,
                    size: pageSize,
                    sort: [sortType] // 예시
                )
                
                await MainActor.run {
                    let newItems = response.content.map {
                        CandidateItem(
                            id: $0.id,
                            candidateNumber: $0.candidateNumber,
                            name: $0.name,
                            profileUrl: $0.profileUrl,
                            voteCnt: $0.voteCnt
                        )
                    }
                    self.candidates += newItems
                    self.pages.append(newItems)
                    self.totalPages = response.totalPages
                    self.currentPage += 1    // 다음 페이지
                    self.isLoading = false
                }
            } catch {
                await MainActor.run {
                    self.errorMessage = error.localizedDescription
                    self.isLoading = false
                }
            }
        }
    }
    
    func vote(candidate: CandidateItem) {
        // TODO: 실제 투표 POST 요청
        // candidateService.vote(userID, candidate.id)
        print("투표 요청: \(candidate.name)")
    }
}
