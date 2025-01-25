//
//  CandidateServiceProtocol.swift
//  AngkorLifeVote
//
//  Created by 김정원 on 1/23/25.
//

import Foundation
protocol CandidateServiceProtocol {
    func requestCandidateList(page: Int, size: Int, sort: [String]) async throws -> CandidateListResponse
}
