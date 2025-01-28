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
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    // 이미 투표한 후보자 ID들
    @Published var votedIDs: Set<Int> = []
    @Published var sortType: SortType = .name
    
    private let candidateService: CandidateServiceProtocol
    
    init(candidateService: CandidateServiceProtocol) {
        self.candidateService = candidateService
    }
    
    /// 모든 후보자 불러오기 (한 번에)
    func fetchAllCandidates(userID: String) {
        guard !isLoading else { return }
        
        isLoading = true
        errorMessage = nil
        
        Task {
            do {
                let response = try await candidateService.requestCandidateList(
                    page: 0,
                    size: 99,
                    sort: sortType
                )
                
                let votedList = try await candidateService.getVotedCandidateList(userID: userID)
                
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
                    self.candidates = newItems
                    self.votedIDs = Set(votedList)
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
}
