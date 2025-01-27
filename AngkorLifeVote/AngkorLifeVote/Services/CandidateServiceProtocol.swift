//
//  CandidateServiceProtocol.swift
//  AngkorLifeVote
//
//  Created by 김정원 on 1/23/25.
//

import Foundation
protocol CandidateServiceProtocol {
    func vote(userID: String, candidateID: Int) async -> Bool
    func requestCandidateList(page: Int, size: Int, sort: [SortType]) async throws -> CandidateListResponse
    func getVotedCandidateList (userID: String) async throws -> [Int]
    func requestCandidateDetail(id: Int, userID: String) async throws -> CandidateDetailResponse
}
