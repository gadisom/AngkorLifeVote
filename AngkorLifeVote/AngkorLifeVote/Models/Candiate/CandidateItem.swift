//
//  CandidateItem.swift
//  AngkorLifeVote
//
//  Created by 김정원 on 1/25/25.
//

import Foundation

/// [content] 배열 하나하나의 아이템
struct CandidateItem: Codable, Identifiable {
    let id: Int
    let candidateNumber: Int
    let name: String
    let profileUrl: String
    let voteCnt: String
}
