//
//  LoginView.swift
//  AngkorLifeVote
//
//  Created by 김정원 on 1/23/25.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var userSession: UserSession
    @State private var userID: String = ""
    var onLoginSuccess: (() -> Void)?

    var body: some View {
        GeometryReader { proxy in
            VStack(alignment: .center) {
                Spacer()
                
                WmuPosterView()
                    .padding(.bottom)
                
                VStack(spacing: 30) {
                    TextField("", text: $userID, prompt: Text("Enter your ID")
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
                        userSession.userID = userID
                        onLoginSuccess?()
                    }){
                        Text("Log in")
                            .font(.kpBold(size: 16))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(userID.isEmpty ? Color.gray : Color.AK4232d5)
                            .clipShape(RoundedRectangle(cornerRadius: 999))
                            .opacity(userID.isEmpty ? 0.6 : 1.0)
                    }
                    .disabled(userID.isEmpty)
                    .padding(.horizontal)
                    
                    Text(userID.isEmpty ? "Please enter your ID at least 1 character" : "")
                        .foregroundStyle(.white)
                        .font(.kpRegular(.caption))
                    
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
                .multilineTextAlignment(.center)
            
            Text("CAMBODIA 2024")
                .font(.kpLight(.title2))
                .foregroundColor(.white)
                .padding(.vertical, 4)
            
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
    }
}


#Preview {
    LoginView()
        .environmentObject(UserSession())
}
#Preview("w") {
    WmuPosterView()
}
