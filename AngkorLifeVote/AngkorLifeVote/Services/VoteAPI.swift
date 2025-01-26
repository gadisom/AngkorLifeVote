//
//  VoteAPI.swift
//  AngkorLifeVote
//
//  Created by 김정원 on 1/25/25.
//

import Foundation

enum VoteAPI {
    case vote(userID: String, candidateID: Int)
    case candidateDetail(id: Int)
    case candidateList(page: Int, size: Int, sort: [Sort])
    case votedCandidateList(userID: String)
}

enum Sort: String {
    case voteCnt = "voteCnt"
    case voteCntDesc = "voteCnt,DESC"
    case name = "name"
    case nameDesc = "name,DESC"
    case candidateNumber = "candidateNumber"
    case candidateNumberDesc = "candidateNumber,DESC"
}

// MARK: - URL 구성, HTTPMethod, Body, Query 등

extension VoteAPI {
    
    /// 공통 baseURL
    var baseURL: URL {
        return URL(string: "https://api-wmu-dev.angkorcoms.com")!
    }
    
    var path: String {
        switch self {
        case .vote:
            return "/vote"
        case .candidateDetail(let id):
            return "/vote/candidate/\(id)"
        case .candidateList:
            return "/vote/candidate/list"
        case .votedCandidateList:
            return "/vote/voted/candidate/list"
        }
    }
    
    var method: String {
        switch self {
        case .vote:
            return "POST"
        default:
            return "GET"
        }
    }
    
    var queryItems: [URLQueryItem]? {
        switch self {
        case .candidateList(let page, let size, let sort):
            // 예: /vote/candidate/list?page=0&size=9&sort=voteCnt,DESC...
            var items: [URLQueryItem] = [
                URLQueryItem(name: "page", value: "\(page)"),
                URLQueryItem(name: "size", value: "\(size)")
            ]
            for s in sort {
                items.append(URLQueryItem(name: "sort", value: s.rawValue))
            }
            return items
            
        case .votedCandidateList(let userID):
            return [URLQueryItem(name: "userId", value: userID)]
            
        default:
            return nil
        }
    }
    
    var body: Data? {
        switch self {
        case .vote(let userID, let candidateID):
            // { "userId": "kimdd", "id": 48 }
            let dict: [String: Any] = [
                "userId": userID,
                "id": candidateID
            ]
            return try? JSONSerialization.data(withJSONObject: dict)
            
        default:
            return nil
        }
    }
}
