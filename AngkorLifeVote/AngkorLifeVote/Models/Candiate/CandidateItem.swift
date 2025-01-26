//
//  CandidateItem.swift
//  AngkorLifeVote
//
//  Created by 김정원 on 1/25/25.
//

import Foundation

struct CandidateItem: Codable, Identifiable, Equatable {
    let id: Int
    let candidateNumber: Int
    let name: String
    let profileUrl: String
    let voteCnt: String
}
