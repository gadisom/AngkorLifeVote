//
//  CandidateListViewModel.swift
//  AngkorLifeVote
//
//  Created by 김정원 on 1/25/25.
//

import SwiftUI
import Combine

final class CandidateListViewModel: ObservableObject {
    @Published var candidates: [CandidateItem] = []
    @Published var errorMessage: String?
    @Published var isLoading: Bool = false
    
    // 페이지 정보
    @Published var currentPage: Int = 0
    @Published var totalPages: Int = 0
    
    private let candidateService: CandidateServiceProtocol
    
    init(candidateService: CandidateServiceProtocol = CandidateService()) {
        self.candidateService = candidateService
    }

    func fetchCandidateList(page: Int = 0, size: Int = 9, sort: [String] = []) {
        Task {
            do {
                await MainActor.run {
                    self.isLoading = true
                    self.errorMessage = nil
                }
                
                let response = try await candidateService.requestCandidateList(page: page, size: size, sort: sort)
                
                await MainActor.run {
                    self.candidates = response.content
                    self.currentPage = response.number
                    self.totalPages = response.totalPages
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
