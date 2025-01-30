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
    
    @State private var showAlert: Bool = false
    @State private var alertMessage: String = ""
    
    var body: some View {
        ZStack {
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
                
                CandidateListView(candidateService: CandidateService(), onAlert: { message in
                    alertMessage = message
                    showAlert = true
                })
            }
            if showAlert {
                Color.black.opacity(0.5)
                    .edgesIgnoringSafeArea(.all)
                    .onTapGesture {
                        withAnimation {
                            showAlert = false
                        }
                    }
                CustomAlertView(
                    title: alertMessage == "Thank you for voting" ? "Voting Completed" : "Voting Failed",
                    message: alertMessage,
                    confirmAction: {
                        withAnimation {
                            showAlert = false // Alert 닫기
                        }
                    }
                )
                .frame(width: UIScreen.main.bounds.width * 0.8)
                .background(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .shadow(radius: 10)
                .transition(.scale)
                .zIndex(1)
            }
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
