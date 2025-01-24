//
//  MainView.swift
//  AngkorLifeVote
//
//  Created by 김정원 on 1/23/25.
//

import SwiftUI

struct MainView: View {
    @ObservedObject var viewModel: MainViewModel
    @EnvironmentObject var userSession: UserSession
    
    var body: some View {
        NavigationView {
            VStack {
                Text("메인 화면")
                    .font(.largeTitle)
                
                Text("로그인한 ID: \(userSession.userID)")
                    .padding()
                
                Spacer()
            }
            .navigationTitle("메인")
        }
    }
}
#Preview {
    MainView(viewModel: MainViewModel())
        .environmentObject(UserSession())
        
}
