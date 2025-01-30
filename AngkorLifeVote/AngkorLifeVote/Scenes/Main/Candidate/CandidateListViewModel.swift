//
//  CandidateGridViewModel.swift
//  AngkorLifeVote
//
//  Created by 김정원 on 1/25/25.
//

import SwiftUI
import Combine

final class CandidateListViewModel: ObservableObject {
    @EnvironmentObject var userSession: UserSession
    @Published var candidates: [CandidateItem] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    @Published var alertMessage = ""
    @Published var showAlert: Bool = false
    @Published var votedIDs: Set<Int> = []  // 이미 투표한 후보자 ID들
    @Published var sortType: SortType = .name
    
    private let candidateService: CandidateServiceProtocol
    
    init(candidateService: CandidateServiceProtocol) {
        self.candidateService = candidateService
    }
    
    /// 투표 로직
    func vote(userID: String, candidateID: Int) {
        guard !isLoading else { return }
        
        // 이미 투표 3명한 경우 
        if votedIDs.count >= 3 && !votedIDs.contains(candidateID) {
            self.alertMessage = "You have already voted for 3 candidates."
            self.showAlert = true
            return
        }
        
        isLoading = true
        errorMessage = nil
        
        Task {
            let success = await candidateService.vote(userID: userID,
                                                      candidateID: candidateID)
            await MainActor.run {
                self.isLoading = false
                if success {
                    self.alertMessage = "Thank you for voting"
                    fetchAllCandidates(userID: userID)
                } else {
                    self.alertMessage = "You have already voted or failed."
                }
                self.showAlert = true
            }
        }
    }
    
    /// 모든 후보자 한번에 불러오기
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
