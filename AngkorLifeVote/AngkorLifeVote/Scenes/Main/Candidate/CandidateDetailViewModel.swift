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
    @Published var showAlert: Bool = false
    @Published var alertMessage: String?
    @Published var currentIndex: Int = 0

    var images: [ProfileInfo] {
        candidateDetail?.profileInfoList ?? []
    }
    
    private var timerTask: Task<Void, Never>?
    private let userID: String
    private let id: Int
    private let candidateService: CandidateServiceProtocol
    
    init(id: Int, userID: String, candidateService: CandidateServiceProtocol) {
        self.id = id
        self.userID = userID
        self.candidateService = candidateService
        
        fetchDetail()
    }
    
    /// 디테일 정보 불러오기
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
                    self.startAutoSlide()
                }
            } catch {
                await MainActor.run {
                    self.errorMessage = error.localizedDescription
                    self.isLoading = false
                }
            }
        }
    }
    /// 투표하기 
    func vote() {
        guard !isLoading else { return }
        isLoading = true
        errorMessage = nil
        
        Task {
            let success = await candidateService.vote(userID: userID,
                                                      candidateID: id)
            await MainActor.run {
                self.isLoading = false
                if success {
                    self.alertMessage = "Thank you for voting"
                } else {
                    self.alertMessage = "You have already voted or failed."
                }
                self.showAlert = true
            }
        }
    }
    
    // MARK: - 타이머 관련 메서드
    
    /// 3초마다 다음 이미지로 이동
    func startAutoSlide() {
        // 혹시 이미 Task가 있다면 취소
        timerTask?.cancel()
        
        let count = images.count
        guard count > 1 else { return }
        
        timerTask = Task {
            while !Task.isCancelled {
                try? await Task.sleep(nanoseconds: 3_000_000_000)
                await MainActor.run {
                    withAnimation(.easeInOut(duration: 0.5)) {
                        currentIndex = (currentIndex + 1) % count
                    }
                }
            }
        }
    }
    
    /// 뷰가 사라질 때 타이머 정지 등
    func stopAutoSlide() {
        timerTask?.cancel()
        timerTask = nil
    }
    
   
}
