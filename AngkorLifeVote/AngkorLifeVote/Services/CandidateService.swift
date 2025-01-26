//
//  CandidateService.swift
//  AngkorLifeVote
//
//  Created by 김정원 on 1/25/25.
//

import Foundation

final class CandidateService: CandidateServiceProtocol {
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    private func makeRequest<T: Decodable>(_ api: VoteAPI) async throws -> T {
        var components = URLComponents(url: api.baseURL.appendingPathComponent(api.path), resolvingAgainstBaseURL: false)
        components?.queryItems = api.queryItems
        
        guard let url = components?.url else {
            throw URLError(.badURL)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = api.method
        
        if let body = api.body {
            request.httpBody = body
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        }
        
        let (data, response) = try await session.data(for: request)
        
        // HTTP 응답 상태 코드 검증
        guard let httpResponse = response as? HTTPURLResponse,
              (200..<300).contains(httpResponse.statusCode) else {
            throw URLError(.badServerResponse)
        }
        
        // 디코딩
        return try JSONDecoder().decode(T.self, from: data)
    }
    
    /// 투표 요청을 보내는 메서드
    func vote(userID: String, candidateID: Int) async throws {
        let api = VoteAPI.vote(userID: userID, candidateID: candidateID)
        
        struct EmptyResponse: Decodable {}
        _ = try await makeRequest(api) as EmptyResponse
    }
    
    /// 후보자 목록 요청을 보내는 메서드
    func requestCandidateList(page: Int, size: Int, sort: [SortType]) async throws -> CandidateListResponse {
        let api = VoteAPI.candidateList(page: page, size: size, sort: sort)
        return try await makeRequest(api)
    }
    
    func getVotedCandidateList (userID: String) async throws -> [Int] {
        let api = VoteAPI.votedCandidateList(userID: userID)
        return try await makeRequest(api)
    }

}

