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
                
                VStack(spacing: 30) {
                    TextField("", text: $viewModel.userID, prompt: Text("Enter your ID").foregroundColor(.gray))
                        .padding()
                        .background(Color(white: 0.12))
                        .foregroundColor(.gray)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.rgb(red: 219, green: 219, blue: 219, opacity: 0.8), lineWidth: 0.5)
                        )
                        .padding(.horizontal)
                    Button(action: {
                        userSession.userID = viewModel.userID
                        viewModel.onLoginSuccess?()
                    }){
                        Text("Log in")
                            .font(.kpBold(size: 18))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(.accent)
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
        GeometryReader { proxy in
            VStack(alignment: .center){
                Text("WORLD MISS UNIVERSITY")
                    .font(.kpMedium(.title))
                    .foregroundColor(.white)
                    .padding(.horizontal)
                    .multilineTextAlignment(.center)
                
                Text("CAMBODIA 2024")
                    .font(.kpLight(size: 25))
                    .foregroundColor(.white)
                    .padding()
                
                Image(.crown)
                    .resizable()
                    .scaledToFit()
                    .frame(width: proxy.size.width * 0.6)
                
                Text("Cast your vote for the brightest candidate!\nWorld Miss University voting starts now!")
                    .font(.kpExtraLight())
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.black)
        }
    }
}


#Preview {
    LoginView(viewModel: LoginViewModel())
        .environmentObject(UserSession())
}
