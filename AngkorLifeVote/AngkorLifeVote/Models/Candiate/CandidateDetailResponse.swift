//
//  CandidateDetailResponse.swift
//  AngkorLifeVote
//
//  Created by 김정원 on 1/27/25.
//

import Foundation

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
