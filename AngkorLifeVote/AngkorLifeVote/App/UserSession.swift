//
//  UserSession.swift
//  AngkorLifeVote
//
//  Created by 김정원 on 1/24/25.
//

import Foundation

final class UserSession: ObservableObject {
    @Published var userID: String = ""
    
    func resetSession() {
        userID = ""
    }
}
