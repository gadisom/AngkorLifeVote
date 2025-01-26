//
//  CandidateService.swift
//  AngkorLifeVote
//
//  Created by 김정원 on 1/25/25.
//

import Foundation

final class CandidateService: CandidateServiceProtocol {
    private let baseURL = "https://api-wmu-dev.angkorcoms.com"
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func requestCandidateList(page: Int, size: Int, sort: [Sort]) async throws -> CandidateListResponse {
        let apiCase = VoteAPI.candidateList(page: page, size: size, sort: sort)
        
        var components = URLComponents(url: apiCase.baseURL.appendingPathComponent(apiCase.path),
                                       resolvingAgainstBaseURL: false)
        components?.queryItems = apiCase.queryItems
        
        guard let url = components?.url else {
            throw URLError(.badURL)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = apiCase.method
        
        let (data, response) = try await URLSession.shared.data(for: request)
        guard let httpResponse = response as? HTTPURLResponse,
              (200..<300).contains(httpResponse.statusCode) else {
            throw URLError(.badServerResponse)
        }
        
        let decoded = try JSONDecoder().decode(CandidateListResponse.self, from: data)
        return decoded
    }

}
