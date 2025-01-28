//
//  CandidateService.swift
//  AngkorLifeVote
//
//  Created by 김정원 on 1/25/25.
//

import Foundation

struct EmptyResponse: Decodable {}

final class CandidateService: CandidateServiceProtocol {
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    private func makeRequest<T: Decodable>(_ api: VoteAPI) async throws -> T {
        var components = URLComponents(url: api.baseURL.appendingPathComponent(api.path),
                                       resolvingAgainstBaseURL: false)
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
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        let (data, response) = try await session.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse,
              (200..<300).contains(httpResponse.statusCode) else {
            throw URLError(.badServerResponse)
        }

        if data.isEmpty {
            if T.self == EmptyResponse.self {
                return EmptyResponse() as! T
            } else {
                throw URLError(.cannotParseResponse)
            }
        }

        if let apiError = try? JSONDecoder().decode(APIError.self, from: data) {
            throw apiError
        }

        return try JSONDecoder().decode(T.self, from: data)
    }
    
    func vote(userID: String, candidateID: Int) async -> Bool {
        let api = VoteAPI.vote(userID: userID, candidateID: "\(candidateID)")
        do {
            let _: EmptyResponse = try await makeRequest(api)
            return true
        } catch let error as APIError {
            if error.errorCode == "2003" {
                return false
            }
            return false
        } catch {
            return false
        }
    }
    
    func requestCandidateList(page: Int, size: Int, sort: SortType) async throws -> CandidateListResponse {
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

