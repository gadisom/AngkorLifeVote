//
//  ContentView.swift
//  AngkorLifeVote
//
//  Created by 김정원 on 1/23/25.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var appCoordinator: AppCoordinator
    var body: some View {
        appCoordinator.startView()
    }
}

#Preview {
    ContentView()
}
