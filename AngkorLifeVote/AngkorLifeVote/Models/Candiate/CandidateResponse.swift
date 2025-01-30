//
//  CandidateListResponse.swift
//  AngkorLifeVote
//
//  Created by 김정원 on 1/25/25.
//

import Foundation

struct CandidateListResponse: Codable {
    let content: [CandidateItem]
    let totalPages: Int
    let totalElements: Int
    let number: Int
    let size: Int        
    let last: Bool
    let first: Bool
    let numberOfElements: Int
    let empty: Bool
}

struct CandidateDetailResponse: Decodable {
    let id: Int
    let candidateNumber: Int
    let name: String
    let country: String
    let education: String
    let major: String
    let hobby: String
    let talent: String
    let ambition: String
    let contents: String
    let profileInfoList: [ProfileInfo]
    let voted: Bool
}
