//
//  LoginView.swift
//  AngkorLifeVote
//
//  Created by 김정원 on 1/23/25.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var userSession: UserSession
    @ObservedObject var viewModel: LoginViewModel
    var body: some View {
        GeometryReader { proxy in
            VStack(alignment: .center) {
                Spacer()
                
                WmuPosterView()
                    .padding(.vertical)
                
                VStack(spacing: 30) {
                    TextField("", text: $viewModel.userID, prompt: Text("Enter your ID")
                        .font(.kpRegular())
                        .foregroundColor(.AKgray2)
                    )
                        .padding()
                        .background(Color(white: 0.12))
                        .foregroundColor(.gray)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.AKdbdbdb, lineWidth: 0.5)
                        )
                        .padding(.horizontal)
                    Button(action: {
                        userSession.userID = viewModel.userID
                        viewModel.onLoginSuccess?()
                    }){
                        Text("Log in")
                            .font(.kpBold(size: 16))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.AK4232d5)
                            .clipShape(RoundedRectangle(cornerRadius: 999))
                    }
                    .padding(.horizontal)
                }
                Spacer()
                Image(.earthBackground)
                    .resizable()
                    .scaledToFit()
                    .frame(width: proxy.size.width)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.black)
            .edgesIgnoringSafeArea(.bottom)
        }
    }
}

struct WmuPosterView: View {
    var body: some View {
        VStack(alignment: .center){
            Text("WORLD MISS UNIVERSITY")
                .font(.kpMedium(.title))
                .foregroundColor(.white)
                .padding(.bottom)
                .multilineTextAlignment(.center)
            
            Text("CAMBODIA 2024")
                .font(.kpLight(.title2))
                .foregroundColor(.white)
                .padding()
            
            Image(.crown)
                .resizable()
                .scaledToFit()
                .padding(.horizontal, 70)
            
            Text("Cast your vote for the brightest candidate!\nWorld Miss University voting starts now!")
                .font(.kpLight(.subheadline))
                .lineSpacing(5)
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
        }
        .background(.black)
    }
}


#Preview {
    LoginView(viewModel: LoginViewModel())
        .environmentObject(UserSession())
}
#Preview("w") {
    WmuPosterView()
}
