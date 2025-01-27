//
//  CandidateDetailViewModel.swift
//  AngkorLifeVote
//
//  Created by 김정원 on 1/27/25.
//

import SwiftUI
import Combine

final class CandidateDetailViewModel: ObservableObject {
    @Published var candidateDetail: CandidateDetailResponse?
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    private let userID: String
    private let id: Int
    private let candidateService: CandidateServiceProtocol
    
    init(id: Int, userID: String ,candidateService: CandidateServiceProtocol) {
        self.id = id
        self.userID = userID
        self.candidateService = candidateService
        
        fetchDetail()
    }
    
    func fetchDetail() {
        guard !isLoading else { return }
        
        isLoading = true
        errorMessage = nil
        
        Task {
            do {
                let detail = try await candidateService.requestCandidateDetail(id: id, userID: userID)
                await MainActor.run {
                    self.candidateDetail = detail
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
