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
    
    // 자동 슬라이드용
    @Published var currentIndex: Int = 0  // TabView index
    private var timerTask: Task<Void, Never>?
    
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
                    // 자동 슬라이드 시작 (데이터가 성공적으로 로드된 후)
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
    
    /// 프로필 이미지 배열 (null-check)
    var images: [ProfileInfo] {
        candidateDetail?.profileInfoList ?? []
    }
    
    /// 3초마다 다음 이미지로 이동
    func startAutoSlide() {
        // 혹시 이미 Task가 있다면 취소
        timerTask?.cancel()
        
        let count = images.count
        guard count > 1 else { return } // 이미지가 1장이면 자동 슬라이드 불필요
        
        // 새 Task 생성
        timerTask = Task {
            while !Task.isCancelled {
                try? await Task.sleep(nanoseconds: 3_000_000_000)
                await MainActor.run {
                    // currentIndex 순환
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
