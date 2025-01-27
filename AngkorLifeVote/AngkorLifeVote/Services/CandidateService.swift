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
    
    func vote(userID: String, candidateID: Int) async -> Bool {
        // 1) URL 생성
        guard let url = URL(string: "https://api-wmu-dev.angkorcoms.com/vote") else {
            return false
        }
        
        // 2) URLRequest
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        // 헤더 설정
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        // 3) 요청 바디
        let bodyDict: [String: Any] = [
            "userId": userID,
            "id": candidateID
        ]
        request.httpBody = try? JSONSerialization.data(withJSONObject: bodyDict, options: [])
        
        do {
            let (data, response) = try await session.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                return false
            }
            
            if httpResponse.statusCode == 200 {
                if let errorObj = try? JSONDecoder().decode(APIError.self, from: data),
                   errorObj.errorCode == "2003" {
                    // 이미 투표한 경우
                    return false
                }
                return true
            } else {
                return false
            }
        } catch {
            return false
        }
    }
    
    func requestCandidateList(page: Int, size: Int, sort: [SortType]) async throws -> CandidateListResponse {
        let api = VoteAPI.candidateList(page: page, size: size, sort: sort)
        return try await makeRequest(api)
    }
    
    func getVotedCandidateList (userID: String) async throws -> [Int] {
        let api = VoteAPI.votedCandidateList(userID: userID)
        return try await makeRequest(api)
    }

    func requestCandidateDetail(id: Int, userID: String) async throws -> CandidateDetailResponse {
        let api = VoteAPI.candidateDetail(id: id, userID: userID)
        return try await makeRequest(api)
    }
}

