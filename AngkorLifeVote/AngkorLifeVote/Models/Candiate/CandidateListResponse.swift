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
