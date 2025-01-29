//
//  MainView.swift
//  AngkorLifeVote
//
//  Created by 김정원 on 1/23/25.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject var coordinator: MainCoordinator
    @EnvironmentObject var userSession: UserSession
    
    var body: some View {
        ScrollView {
            
            WmuPosterView()
                .padding(.bottom)
            
            CountDownView()
                .padding(.horizontal, 40)
            
            Image(.earthBackground)
                .resizable()
                .scaledToFit()
                .frame(maxWidth: .infinity)
            
            VotingInfoView()
            
            CandidateGridView(candidateService: CandidateService())
        }
        .background(Color.black)
        .navigationBarTitle("2024 WMU", displayMode: .inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button(action: {
                    coordinator.logout()
                }) {
                    Image(systemName: "xmark")
                }
            }
        }
        
    }
}


#Preview {
    NavigationView {
        MainView()
            .environmentObject(MainCoordinator(appCoordinator: AppCoordinator()))
            .environmentObject(UserSession())
    }
}
