//
//  AngkorLifeVoteApp.swift
//  AngkorLifeVote
//
//  Created by 김정원 on 1/23/25.
//

import SwiftUI

@main
struct AngkorLifeVoteApp: App {
    @StateObject private var userSession = UserSession()
    @StateObject private var appCoordinator = AppCoordinator()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(userSession)
                .environmentObject(appCoordinator)
        }
    }
}
